

# Need two types: an iterable and frame type.

# We may in future want to return additional information about the frame, e.g. sequence numbers.
struct AeronFrame{T}
    buffer::Vector{T}
end

mutable struct AeronSubscription
    const conf::AeronConfig
    const libaeron_subscription::Ptr{LibAeron.aeron_subscription_t}
    const fragment_assembler_ptr::Base.CFunction
    const buffer::Vector{UInt8}
    next_term_offset::Int32
    buffer_limit::Int32
    frame_received::Bool
    # Constructor
    AeronSubscription(
        conf,
        libaeron_subscription,
        fragment_assembler_ptr,
        buffer,
        next_term_offset = Int32(0),
        buffer_limit = Int32(0),
        frame_received = false,
    ) = new(conf, libaeron_subscription, fragment_assembler_ptr, buffer, next_term_offset, buffer_limit, frame_received)
end


# Not yet handled
function _print_available_image(clientd, subscription, image)
    return 1
end
function _print_unavailable_image(clientd, subscription, image)
    return 1
end


"""

    subscribe(callback::Base.Callable, conf::AeronConfig)

Subscribe to a stream given by `conf`. Inside the callback, you have access to an AeronSubscription
object that can be iterated to receive frames.

!!! warning
    The frame object is only valid for the duration of the iteration. It is overwritten as soon as you
    request / iterate to receive a new frame. To be specific, it is still valid if the media driver
    receives a new frame, but is overwritten when you request a new frame.
    

## Examples
````julia
subscribe(callback, conf) do stream
    frame = first(stream)
    @info "received frame"
    return copy(frame.buffer)
end

subscribe(conf) do stream
    for frame in stream
        @info "received frame" sum(frame.buffer)

        if frame.buffer[1] > 3
            break
        end
    end
end
````
"""
function subscribe(callback::Base.Callable, conf::AeronConfig; sizehint=512*512, verbose=false)

    @info "Subscribing" conf.channel conf.stream

    aeron = Ptr{LibAeron.aeron_t}(C_NULL)
    context = Ptr{LibAeron.aeron_context_t}(C_NULL)
    libaeron_subscription = Ptr{LibAeron.aeron_subscription_t}(C_NULL)
    async = Ptr{LibAeron.aeron_async_add_subscription_t}(C_NULL)

    # We will copy data into this buffer. 
    # We will resize it to be the right size for each message.
    # If the message size is larger than the buffer, our call to resize
    # will reallocate it (julia should handle this transparently)
    buffer = UInt8[]
    sizehint!(buffer, sizehint)

    local result

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

        print_available_image_ptr = @cfunction(_print_available_image, Int64, (Ptr{Nothing}, Ptr{Nothing}, Ptr{Nothing}))
        print_unavailable_image_ptr = @cfunction(_print_unavailable_image, Int64, (Ptr{Nothing}, Ptr{Nothing}, Ptr{Nothing}))

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
        while (C_NULL == libaeron_subscription)
            if @c(LibAeron.aeron_async_add_subscription_poll(&libaeron_subscription, async)) < 0
                error("aeron_async_add_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
            end    
            yield()
            if time() > timeout
                error("timed out adding subscription after 5s")
            end
        end
    
        @info "Subscription channel status " LibAeron.aeron_subscription_channel_status(libaeron_subscription)

        # Create a "pointer" to an uninitialized aeron_header_values_t struct.
        # Annoyingly we have to manually initialize it with zeros.
        # The aeron_header_values_t struct is immutable and doesn't escape, so is therefore stack allocated.
        # We're not allowed to get pointers to stack allocated data in Julia so we place it into a mutable
        # Ref. This way it's heap-allocated and we can pass that pointer into aeron to be mutated..
        header_values_ref = Ref(Aeron.LibAeron.aeron_header_values_t(ntuple(i->0x00, 44)))


        # After creating the fragment_assembler, we stuff it and other needed context into our
        # AeronSubscription struct. 
        # We could use `context` to pass our reference to it; however, it is easier for 
        # now to just close over it using an LLVM trampoline. If this causes compatibility issues
        # down the road we could do this bookkeeping manually.
        function fragment_assembler(context, fragment_buffer, length, header_ptr)

            # `framgent_buffer` and `length` is a pointer to the data in this fragment.
            # We don't know the length of the entire frame in advance until it has finished
            # arriving.

            # memcpy the header data into header_values_ref
            LibAeron.aeron_header_values(header_ptr, header_values_ref)
            header_values = header_values_ref[]
            frame = header_values.frame

            local aligned_length::Int32

            # Unfragmented case
            if frame.flags & LibAeron.AERON_DATA_HEADER_UNFRAGMENTED == LibAeron.AERON_DATA_HEADER_UNFRAGMENTED
                resize!(buffer, length)
                subscription.frame_received = true
                # user_continue[] = callback(header_values, buffer)::Bool
            # Fragemented case: first fragment
            elseif frame.flags & LibAeron.AERON_DATA_HEADER_BEGIN_FLAG == LibAeron.AERON_DATA_HEADER_BEGIN_FLAG 
                resize!(buffer, length)
                if !isassigned(buffer, length)
                    @error "Attempted to copy data past length of buffer. How did this happen?" size(buffer) subscription.buffer_limit
                    return
                end
                unsafe_copyto!(pointer(buffer), fragment_buffer, length)
                aligned_length = LibAeron.AERON_ALIGN(LibAeron.AERON_DATA_HEADER_LENGTH + length, LibAeron.AERON_LOGBUFFER_FRAME_ALIGNMENT)
                subscription.next_term_offset = frame.term_offset + aligned_length
                subscription.buffer_limit = length
            # Appending case
            elseif subscription.next_term_offset == frame.term_offset
                # Resize to give sufficient room
                if !isassigned(buffer, subscription.buffer_limit)
                    resize!(buffer, subscription.buffer_limit + length)
                end
                unsafe_copyto!(pointer(buffer, subscription.buffer_limit+1), fragment_buffer, length)
                subscription.buffer_limit = subscription.buffer_limit  + length
                # Case: we're done, trigger callback
                if frame.flags & LibAeron.AERON_DATA_HEADER_END_FLAG == LibAeron.AERON_DATA_HEADER_END_FLAG
                    # user_continue[] = callback(header_values, buffer)::Bool
                    subscription.frame_received = true
                # Case: we're not done, record next offset we expect
                else
                    aligned_length = LibAeron.AERON_ALIGN(LibAeron.AERON_DATA_HEADER_LENGTH + length, LibAeron.AERON_LOGBUFFER_FRAME_ALIGNMENT)
                    subscription.next_term_offset = frame.term_offset + aligned_length
                end
            else
            end

            return nothing
        end
        fragment_assembler_ptr = @cfunction($fragment_assembler, Cvoid, (Ptr{Nothing}, Ptr{UInt8}, Csize_t, Ptr{LibAeron.aeron_header_t}))
        subscription = AeronSubscription(conf, libaeron_subscription, fragment_assembler_ptr, buffer)

        # Pass the subscription object to the user's callback.
        # They can iterate on it to receive frames.
        result = callback(subscription)

        verbose && @info "will close subscription"

    finally
        LibAeron.aeron_subscription_close(libaeron_subscription, C_NULL, C_NULL)
        LibAeron.aeron_close(aeron)
        LibAeron.aeron_context_close(context)
        verbose && @info "cleanup complete"
    end
    return result
end

# struct AeronSubscription
#     conf::AeronConfig
#     libaeron_subscription::Ptr{LibAeron.aeron_subscription_t}
#     fragment_assembler_ptr::Ptr# TODO make concerete
#     buffer::Vector{UInt8}
# end

# Currently we don't use state
function Base.iterate(subscription::AeronSubscription, state=nothing)
    while !subscription.frame_received
        fragments_read = LibAeron.aeron_subscription_poll(
            subscription.libaeron_subscription,
            subscription.fragment_assembler_ptr,
            # Context pointer for callback if we want it: in future we can use this to pass a pointer to our subscription struct.
            C_NULL,
            subscription.conf.fragment_count_limit
        )
        if fragments_read < 0
            error("aeron_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
        GC.safepoint()
        # TODO: this is currently a busy wait
    end
    frame = AeronFrame(subscription.buffer)
    # TODO: exit cleanly if subscriber stops?
    return frame, state
end

        # while true
        #     fragments_read = LibAeron.aeron_subscription_poll(
        #         libaeron_subscription,
        #         fragment_assembler_ptr,
        #         # Context pointer for callback if we want it
        #         C_NULL,
        #         conf.fragment_count_limit
        #     )
        #     if fragments_read < 0
        #         error("aeron_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
        #     end
        #     GC.safepoint()
        # end


# The following is an alterative implementation

"""
    subscribe_aeron_fragment_assembler(conf::AeronConfig) do header, bufarr::PtrArray

Subscribe to a stream given by `conf`. Uses the aeron library's built in fragment
assembler to re-assemble large frames. Memory is then wrapped with a PtrArray
and passed to the callback.

"""
function subscribe_aeron_fragment_assembler(callback::Base.Callable, conf::AeronConfig; verbose=Val{false})

    verbose && @info "Subscribing" conf.channel conf.stream

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
        verbose && @info "inited"

        if LibAeron.aeron_start(aeron) < 0
            error("aeron_start: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
        verbose && @info "started"

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
    
        verbose && @info "Subscription channel status " LibAeron.aeron_subscription_channel_status(subscription)

        # Use a trampoline to close over the user's function
        function poll_handler_closure(clientd, buffer, length, header_ptr)
            # Allocation free
            bufarr = PtrArray(buffer, (length,))
    
            # Allocates
            header = unsafe_load(header_ptr)

            should_continue[] = GC.@preserve header bufarr callback(header, bufarr)
        
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
        verbose && @info "cleanup complete"
    end
end
