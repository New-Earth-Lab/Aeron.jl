
function print_available_image(clientd, subscription, image)
    # @show "available image"
    return 1
end
function print_unavailable_image(clientd, subscription, image)
    # @show "unavailable image"
    return 1
end



function subscribe(callback::Base.Callable, conf::AeronConfig1)

    @info "Subscribing" conf.channel conf.stream

    aeron = Ptr{LibAeron.aeron_t}(C_NULL)
    context = Ptr{LibAeron.aeron_context_t}(C_NULL)
    subscription = Ptr{LibAeron.aeron_subscription_t}(C_NULL)
    fragment_assembler = Ptr{LibAeron.aeron_fragment_assembler_t}(C_NULL)
    async = Ptr{LibAeron.aeron_async_add_subscription_t}(C_NULL)

    should_continue = Ref(true)

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
            # @time  begin
                bufarr = PtrArray(buffer, (length,))
        
                # Allocates
                header = unsafe_load(header_ptr)
            # end

            should_continue[] = callback(header, bufarr)
        
            return nothing
        end
        

        # poll_handler_ptr = @cfunction(poll_handler, Cvoid, (Ptr{Nothing}, Ptr{UInt8}, Csize_t, Ptr{LibAeron.aeron_header_t}))
        poll_handler_ptr = @cfunction($poll_handler_closure, Cvoid, (Ptr{Nothing}, Ptr{UInt8}, Csize_t, Ptr{LibAeron.aeron_header_t}))
    
        if @c(LibAeron.aeron_fragment_assembler_create(&fragment_assembler, poll_handler_ptr, subscription)) < 0
            error("aeron_fragment_assembler_create: "*unsafe_string(LibAeron.aeron_errmsg()))
        end

        aeron_fragment_assembler_handler_ptr = dlsym(dlopen(LibAeron.libaeron), :aeron_fragment_assembler_handler)
        while should_continue[]
            fragments_read = LibAeron.aeron_subscription_poll(
                subscription,
                aeron_fragment_assembler_handler_ptr,
                fragment_assembler,
                conf.fragment_count_limit
            )
            if fragments_read < 0
                error("aeron_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
            end

        
        end

    finally
        LibAeron.aeron_subscription_close(subscription, C_NULL, C_NULL)
        LibAeron.aeron_close(aeron)
        LibAeron.aeron_context_close(context)
        LibAeron.aeron_fragment_assembler_delete(fragment_assembler)
        @info "cleanup complete"
    end
end





# function subscribe2(callback::Base.Callable, conf::AeronConfig1)

#     @info "Subscribing" conf.channel conf.stream

#     aeron = Ptr{LibAeron.aeron_t}(C_NULL)
#     context = Ptr{LibAeron.aeron_context_t}(C_NULL)
#     subscription = Ptr{LibAeron.aeron_subscription_t}(C_NULL)
#     async = Ptr{LibAeron.aeron_async_add_subscription_t}(C_NULL)
#     fragment_assembler = Ptr{LibAeron.aeron_fragment_assembler_t}(C_NULL)

#     try

#         if @c(LibAeron.aeron_context_init(&context)) < 0
#             error("aeron_context_init: "*unsafe_string(LibAeron.aeron_errmsg()))
#         end

#         if @c(LibAeron.aeron_init(&aeron, context)) < 0
#             error("aeron_init: "*unsafe_string(LibAeron.aeron_errmsg()))
#         end
#         @info "inited"

#         if LibAeron.aeron_start(aeron) < 0
#             error("aeron_start: "*unsafe_string(LibAeron.aeron_errmsg()))
#         end
#         @info "started"

#         print_available_image_ptr = @cfunction(print_available_image, Int64, (Ptr{Nothing}, Ptr{Nothing}, Ptr{Nothing}))
#         print_unavailable_image_ptr = @cfunction(print_unavailable_image, Int64, (Ptr{Nothing}, Ptr{Nothing}, Ptr{Nothing}))

#         if @c(LibAeron.aeron_async_add_subscription(
#             &async,
#             aeron,
#             conf.channel,
#             conf.stream,
#             print_available_image_ptr,
#             C_NULL,
#             print_unavailable_image_ptr,
#             C_NULL)) < 0
#             error("aeron_async_add_subscription: "*unsafe_string(LibAeron.aeron_errmsg()))
#         end
    
#         timeout = time() + 5
#         while (C_NULL == subscription)
#             if @c(LibAeron.aeron_async_add_subscription_poll(&subscription, async)) < 0
#                 error("aeron_async_add_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
#             end    
#             yield()
#             if time() > timeout
#                 error("timed out adding subscription after 5s")
#             end
#         end
    
#         @info "Subscription channel status " LibAeron.aeron_subscription_channel_status(subscription)



#         # Make our poll-handler c-callable
#         poll_handler_ptr = @cfunction(poll_handler, Cvoid, (Ptr{Nothing}, Ptr{UInt8}, Csize_t, Ptr{LibAeron.aeron_header_t}))
       
#         # Use the default fragment assembler
#         aeron_fragment_assembler_handler = dlsym(dlopen(LibAeron.libaeron), :aeron_fragment_assembler_handler)


#         # Now: run their callback with a Subscription object.
#         # They can iterate over this as long as they like, or grab results one by one as needed.
#         # When their callback returns or fails, we end up back here to clean up the subscription
#         # and context.
#         subiter = SubscriptionIterator1(
#             subscription,
#             # aeron_fragment_assembler_handler_ptr,
#             # fragment_assembler,
#             conf
#         )

#         # Register the fragement assembler which will call our poll_handler when a message is ready.
#         # We provide a pointer to `sub` as our clientdata.
#         if @c(LibAeron.aeron_fragment_assembler_create(&fragment_assembler, poll_handler_ptr, subscription)) < 0
#             error("aeron_fragment_assembler_create: "*unsafe_string(LibAeron.aeron_errmsg()))
#         end

        

#         callback(subiter)


#     finally
#         LibAeron.aeron_subscription_close(subscription, C_NULL, C_NULL)
#         LibAeron.aeron_close(aeron)
#         LibAeron.aeron_context_close(context)
#         # TODO: how to clean this up? Need to store in struct I guess
#         # LibAeron.aeron_fragment_assembler_delete(fragment_assembler)
#         @info "cleanup complete"
#     end
# end


# mutable struct SubscriptionIterator1
#     subscription::Ptr{LibAeron.aeron_subscription_t}
#     conf::AeronConfig1
#     aeron_fragment_assembler_handler::Ptr{Nothing}
#     fragment_assembler::Ptr{LibAeron.aeron_fragment_assembler_t}
#     assembled::Bool
#     result # Non-concrete...
#     function SubscriptionIterator1(subscription, conf)
#         # initial_result = PtrArray(zeros(UInt8,UInt64(0)))
#         return new(subscription, conf, C_NULL, C_NULL, false,  nothing)
#     end
# end

# function poll_handler(clientd, buffer, length, header_ptr)

#     @info "Poll handler triggered" clientd

#     # User clientd to insert the buffer ptr and length into the right iterator.
#     # Make clientd a pointer to the SubscriptionIterator.
#     # It can see that we've set that and break out of the loop
#     # Then it can allocate or do whatever with the data

#     # iter_ptr = 

#     # # Allocation free
#     # bufarr = 
#     # iter.result = PtrArray(buffer, (length,))
#     # iter.result = collect(unsafe_wrap(Array, buffer, (length,)))
#     # iter.assembled = true

#     # # Allocates
#     # # header = unsafe_load(header_ptr)
#     # callback(bufarr)


#     return nothing
# end

# function Base.iterate(
#     iter::SubscriptionIterator1,
# )

#     iter.assembled = false

#     # # Use a trampoline to close over the user's function
#     # function poll_handler_closure(clientd, buffer, length, header_ptr)
#     #     # # Allocation free
#     #     # bufarr = 
#     #     # iter.result = PtrArray(buffer, (length,))
#     #     iter.result = collect(unsafe_wrap(Array, buffer, (length,)))
#     #     iter.assembled = true
    
#     #     # # Allocates
#     #     # # header = unsafe_load(header_ptr)
#     #     # callback(bufarr)
#     #     return nothing
#     # end
    
    
#     idle_duration_ns = Ptr{UInt64}(UInt64(1000 * 1000)) # 1ms 

#     while true
#         fragments_read = LibAeron.aeron_subscription_poll(
#             iter.subscription,
#             iter.aeron_fragment_assembler_handler,
#             iter.fragment_assembler,
#             iter.conf.fragment_count_limit
#         )
#         if fragments_read < 0
#             error("aeron_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
#         end
#         if iter.assembled
#             return (iter.result, true)
#         end
#         yield()
#         # @c LibAeron.aeron_idle_strategy_sleeping_idle(&idle_duration_ns, fragments_read);
#     end

#     # State for next iteration
# end
# function Base.iterate(
#     iter::SubscriptionIterator1,
#     _continuing::Bool
# )
#     iter.assembled = false
#     while true

#         fragments_read = LibAeron.aeron_subscription_poll(
#             iter.subscription,
#             iter.aeron_fragment_assembler_handler,
#             iter.fragment_assembler,
#             iter.conf.fragment_count_limit
#         )
#         if fragments_read < 0
#             error("aeron_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
#         end
#         if iter.assembled
#             return (iter.result, true)
#         end
#         yield()
#         # @c LibAeron.aeron_idle_strategy_sleeping_idle(&idle_duration_ns, fragments_read);
#     end
    
#     return ("DEF", true)
# end
