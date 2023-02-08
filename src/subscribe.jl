
function print_available_image(clientd, subscription, image)
    # @show "available image"
    return 1
end
function print_unavailable_image(clientd, subscription, image)
    # @show "unavailable image"
    return 1
end


function poll_handler(clientd, buffer, length, header_ptr)
    # Allocation free
    bufarr = PtrArray(buffer, (length,))

    # Allocates
    # header = unsafe_load(header_ptr)

    @info "Message received"
    @show sum(bufarr)

    return nothing
end

function subscribe(callback::Base.Callable, conf::AeronConfig1)
    idle_duration_ns = 1000 * 1000

    @info "Subscribing" conf.channel conf.stream

    aeron = Ptr{LibAeron.aeron_t}(C_NULL)
    context = Ptr{LibAeron.aeron_context_t}(C_NULL)
    subscription = Ptr{LibAeron.aeron_subscription_t}(C_NULL)
    fragment_assembler = Ptr{LibAeron.aeron_fragment_assembler_t}(C_NULL)
    async = Ptr{LibAeron.aeron_async_add_subscription_t}(C_NULL)

    try

        if @c(LibAeron.aeron_context_init(&context)) < 0
            error("aeron_context_init: "*unsafe_string(LibAeron.aeron_errmsg()))
        end

        if @c(LibAeron.aeron_init(&aeron, context)) < 0
            error("aeron_init: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
        @info "inited"

        if LibAeron.aeron_start(aeron) < 0
            error("aeron_start: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
        @info "started"

        print_available_image_ptr = @cfunction(print_available_image, Int64, (Ptr{Nothing}, Ptr{Nothing}, Ptr{Nothing}))
        print_unavailable_image_ptr = @cfunction(print_unavailable_image, Int64, (Ptr{Nothing}, Ptr{Nothing}, Ptr{Nothing}))

        if @c(LibAeron.aeron_async_add_subscription(
            &async,
            aeron,
            conf.channel,
            conf.stream,
            print_available_image_ptr,
            C_NULL,
            print_unavailable_image_ptr,
            C_NULL)) < 0
            error("aeron_async_add_subscription: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
    
        timeout = time() + 5
        while (C_NULL == subscription)
            if @c(LibAeron.aeron_async_add_subscription_poll(&subscription, async)) < 0
                error("aeron_async_add_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
            end    
            yield()
            if time() > timeout
                error("timed out adding subscription after 5s")
            end
        end
    
        @info "Subscription channel status " LibAeron.aeron_subscription_channel_status(subscription)

        # Use a trampoline to close over the user's function
        function poll_handler_closure(clientd, buffer, length, header_ptr)
            # Allocation free
            bufarr = PtrArray(buffer, (length,))
        
            # Allocates
            # header = unsafe_load(header_ptr)
            callback(bufarr)
        
        
            return nothing
        end
        

        # poll_handler_ptr = @cfunction(poll_handler, Cvoid, (Ptr{Nothing}, Ptr{UInt8}, Csize_t, Ptr{LibAeron.aeron_header_t}))
        poll_handler_ptr = @cfunction($poll_handler_closure, Cvoid, (Ptr{Nothing}, Ptr{UInt8}, Csize_t, Ptr{LibAeron.aeron_header_t}))
    
        if @c(LibAeron.aeron_fragment_assembler_create(&fragment_assembler, poll_handler_ptr, subscription)) < 0
            error("aeron_fragment_assembler_create: "*unsafe_string(LibAeron.aeron_errmsg()))
        end

        aeron_fragment_assembler_handler_ptr = dlsym(dlopen(LibAeron.libaeron), :aeron_fragment_assembler_handler)
        timeout = time() + 30
        while time() < timeout
            fragments_read = LibAeron.aeron_subscription_poll(
                subscription,
                aeron_fragment_assembler_handler_ptr,
                fragment_assembler,
                conf.fragment_count_limit
            )
            if fragments_read < 0
                error("aeron_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
            end

            @c LibAeron.aeron_idle_strategy_sleeping_idle(&idle_duration_ns, fragments_read);
        
        end

    finally
        LibAeron.aeron_subscription_close(subscription, C_NULL, C_NULL)
        LibAeron.aeron_close(aeron)
        LibAeron.aeron_context_close(context)
        LibAeron.aeron_fragment_assembler_delete(fragment_assembler)
        @info "cleanup complete"
    end
end
