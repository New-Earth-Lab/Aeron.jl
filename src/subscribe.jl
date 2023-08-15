# Need two types: an iterable and frame type.

# We may in future want to return additional information about the frame, e.g. sequence numbers.
struct AeronFrame{T}
    buffer::Vector{T}
end

mutable struct AeronSubscriptionSession
    buffer::Vector{UInt8}
    next_term_offset::Int32
    buffer_limit::Int32
    frame_received::Bool
    wait_until_message_start::Bool
    # Constructor with initialized defaults
    function AeronSubscriptionSession(
        buffer = nothing,
        next_term_offset = Int32(0),
        buffer_limit = Int32(0);
        sizehint=512*512
    )
        if isnothing(buffer)
            buffer = Vector{UInt8}(undef, sizehint)
            resize!(buffer,0)
        end
        new(buffer, next_term_offset, buffer_limit, false, false)
    end
end

struct AeronSubscriptionInner
    aeron::Ptr{LibAeron.aeron_t}
    context::Ptr{LibAeron.aeron_context_t}
    libaeron_subscription::Ptr{LibAeron.aeron_subscription_t}
    session_map::Dict{Int32,AeronSubscriptionSession}
    header_values_ref::Base.RefValue{LibAeron.aeron_header_values_t}
    # Constructor
    AeronSubscriptionInner(
        aeron,
        context,
        libaeron_subscription,
    ) = new(
        aeron,
        context,
        libaeron_subscription,
        Dict{Int,AeronSubscriptionSession}(),
        Ref(LibAeron.aeron_header_values_t(ntuple(i->0x00, 44)))
    )
end

# Mutable wrapper around AeronSubscription
# so that we can take a pointer to it / preserve the pointer.
mutable struct AeronSubscription
    conf::AeronConfig
    contents::Base.RefValue{AeronSubscriptionInner}
    # Constructor
    AeronSubscription(
        conf,
        aeron,
        context,
        libaeron_subscription,
    ) = new(
        conf,
        Ref(AeronSubscriptionInner(
            aeron,
            context,
            libaeron_subscription,
        ))
    )
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
    subscription = subscribe(conf; sizehint, verbose)
    try
        callback(subscription)
    finally
        close(subscription)
    end
end
function subscribe(conf::AeronConfig; sizehint=512*512, verbose=false)

    @info "Subscribing" conf.channel conf.stream

    aeron = Ptr{LibAeron.aeron_t}(C_NULL)
    context = Ptr{LibAeron.aeron_context_t}(C_NULL)
    libaeron_subscription = Ptr{LibAeron.aeron_subscription_t}(C_NULL)
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

        subscription = AeronSubscription(conf, aeron, context, libaeron_subscription)

        @show subscription
        # Return the subscription object for them to iterate over
        return subscription

    catch exception
        @error "Could not subscribe to stream" exception
        if libaeron_subscription != C_NULL
            LibAeron.aeron_subscription_close(libaeron_subscription, C_NULL, C_NULL)
        end
        if aeron != C_NULL
            LibAeron.aeron_close(aeron)
        end
        if context != C_NULL
            LibAeron.aeron_context_close(context)
        end
        verbose && @info "cleanup complete"
        rethrow(exception)
    end
end

# Our custom fragment assembler places data into a pre-allocated Julia Array as it arrives.
# The aeron-provided fragment assemblers are not optimal for use in Julia since it would
# require us to copy the data once it is all done, allocate a new array each time with 
# unsafe_wrap (this actually allocates a small header!), or use a work around like 
# StrideArrays.
# We sizehint! the array, and then grow it from 0 length as fragments arrive.
# If the incoming messages are more or less consistently sized, then the array will quickly
# grow to fit the largest incoming message and subsequent messages will be received without
# any allocations.
function fragment_assembler(context_ptr::Ptr{AeronSubscriptionInner}, fragment_buffer, buflength, header_ptr)
    # `framgent_buffer` and `buflength` is a pointer to the data in this fragment.
    # We don't know the buflength of the entire frame in advance until it has finished
    # arriving.

    subscription = unsafe_load(context_ptr)

    # memcpy the header data into header_values_ref
    LibAeron.aeron_header_values(header_ptr, subscription.header_values_ref)
    header_values = subscription.header_values_ref[]
    frame = header_values.frame

    # Each publisher gets its own session_id. We may be receiving data
    # from multiple publisher simultaneously. We therefore assemble
    # into a frame identified by that session_id, all stored in a dictionary.
    if haskey(subscription.session_map, frame.session_id)
        session = subscription.session_map[frame.session_id]
    else
        # Note: this allocates! 
        # It should happen only once per publisher if messages are consistently sized. 
        session = subscription.session_map[frame.session_id] = AeronSubscriptionSession()
    end

    # The session contains a preallocated buffer (see above) that we copy into.
    # We will resize it to be the right size for each message.
    # If the message size is larger than the buffer, our call to resize
    # will reallocate it (julia should handle this transparently)

    local aligned_buflength::Int32
    
    # Unfragmented case
    if frame.flags & LibAeron.AERON_DATA_HEADER_UNFRAGMENTED == LibAeron.AERON_DATA_HEADER_UNFRAGMENTED
        session.wait_until_message_start = false
        session.frame_received = true
        resize!(session.buffer, buflength)
        unsafe_copyto!(pointer(session.buffer), fragment_buffer, buflength)
    # Fragemented case: first fragment
    elseif frame.flags & LibAeron.AERON_DATA_HEADER_BEGIN_FLAG == LibAeron.AERON_DATA_HEADER_BEGIN_FLAG 
        session.wait_until_message_start = false
        session.frame_received = false
        resize!(session.buffer, buflength)
        if !isassigned(session.buffer, buflength)
            @error "Attempted to copy data past length of buffer. How did this happen?" size(session.buffer) session.buffer_limit
            return
        end
        unsafe_copyto!(pointer(session.buffer), fragment_buffer, buflength)
        aligned_buflength = LibAeron.AERON_ALIGN(LibAeron.AERON_DATA_HEADER_LENGTH + buflength, LibAeron.AERON_LOGBUFFER_FRAME_ALIGNMENT)
        session.next_term_offset = frame.term_offset + aligned_buflength
        session.buffer_limit = buflength
    # Appending case
    elseif session.next_term_offset == frame.term_offset && !session.wait_until_message_start
        # Resize to give sufficient room
        if length(session.buffer) != session.buffer_limit + buflength
            resize!(session.buffer, session.buffer_limit + buflength)
        end
        unsafe_copyto!(pointer(session.buffer, session.buffer_limit+1), fragment_buffer, buflength)
        session.buffer_limit = session.buffer_limit  + buflength
        # Case: we're done, trigger callback
        if frame.flags & LibAeron.AERON_DATA_HEADER_END_FLAG == LibAeron.AERON_DATA_HEADER_END_FLAG
            session.frame_received = true
        # Case: we're not done, record next offset we expect
        else
            aligned_buflength = LibAeron.AERON_ALIGN(LibAeron.AERON_DATA_HEADER_LENGTH + buflength, LibAeron.AERON_LOGBUFFER_FRAME_ALIGNMENT)
            session.next_term_offset = frame.term_offset + aligned_buflength
            session.frame_received = false
        end
    else
    end

    return
end



# This version of the fragment assembler deliberately does no work.
# Polling with this version prevents us from backpressuring but requires minimal work.
function fragment_assembler_noop(context_ptr::Ptr{AeronSubscriptionInner}, fragment_buffer, buflength, header_ptr)
    # See fragment_assembler comments for details. 
    subscription = unsafe_load(context_ptr)
    LibAeron.aeron_header_values(header_ptr, subscription.header_values_ref)
    header_values = subscription.header_values_ref[]
    frame = header_values.frame
    if haskey(subscription.session_map, frame.session_id)
        session = subscription.session_map[frame.session_id]
    else
        session = subscription.session_map[frame.session_id] = AeronSubscriptionSession()
    end
    session.wait_until_message_start = true
    return
end


"""
    close(subscription)
"""
function Base.close(subhandle::AeronSubscription)
    LibAeron.aeron_subscription_close(subhandle.contents[].libaeron_subscription, C_NULL, C_NULL)
    LibAeron.aeron_close(subhandle.contents[].aeron)
    LibAeron.aeron_context_close(subhandle.contents[].context)
end


# Currently we don't use state
"""
Iterator interface to an aeron subscription. Polls internally to receive
full messages.
"""
function Base.iterate(subscription::AeronSubscription, _=nothing::Nothing)
    i = 0
    while true
        i+=1
        out = poll(subscription)
        if !isnothing(out)
            return out, nothing
        end
        # Insert safepoints every 1000 polls
        if mod(i, 1000) == 0
            GC.safepoint()
        end
        # yield()
        # TODO: this is currently a busy wait
    end
end

"""
    Aeron.poll(subscription)::Union{Nothing,AeronFrame}

Do work to receive fragments from a given subscription if available. If a received
fragment completes a frame, the full frame is returned as an `AeronFrame`
(otherwise `nothing`)

Pass `noop=true` to poll for messages without doing any work to assemble incoming data
or copy it anywhere (to discard messages without backpressuring).
"""
function poll(subscription::AeronSubscription; fragment_count_limit=1, noop=false)

    subscription_ptr = pointer_from_objref(subscription.contents)

    if noop
        fragment_assembler_ptr = @cfunction(
            fragment_assembler_noop,
            Cvoid,
            (Ptr{AeronSubscriptionInner}, Ptr{UInt8}, Csize_t, Ptr{LibAeron.aeron_header_t})
        )
    else
        fragment_assembler_ptr = @cfunction(
            fragment_assembler,
            Cvoid,
            (Ptr{AeronSubscriptionInner}, Ptr{UInt8}, Csize_t, Ptr{LibAeron.aeron_header_t})
        )
    end
    
    GC.@preserve subscription  begin
        fragments_read = LibAeron.aeron_subscription_poll(
            subscription.contents[].libaeron_subscription,
            fragment_assembler_ptr,
            subscription_ptr,
            fragment_count_limit,
        )
    end

    if fragments_read < 0
        error("aeron_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
    elseif fragments_read == 0
        return nothing
    elseif fragments_read > 0
        for session in values(subscription.contents[].session_map)
            if session.frame_received
                frame = AeronFrame(session.buffer)
                session.frame_received = false
                return frame
            end
        end
    end
end


Base.@kwdef mutable struct AeronWatchHandle{T<:Base.Callable}
    const subscription::AeronSubscription
    const callback::T
    active::Bool=true
    decimate::Int=1
    decimate_idx::Int=0
    decimate_time::Float64=0.0
    decimate_last_time::Float64=0.0
end

"""
    watch(callback::Base.Callable, subscription::AeronSubscription)

Using a background Julia thread, poll `subscription` and run `callback` 
with a message each time a full message is received.

Implementation note: a single Julia thread is used for any/all subscriptions
that are watched. You can safely `watch` many different streams without 
needing more than one background thread available.

Returns: AeronWatchHandle

See also: iterate(subscription)
"""
function watch(callback::Base.Callable, subscription::AeronSubscription; kwargs...)
    wh = AeronWatchHandle(;subscription, callback, kwargs...)
    if !haskey(watch_handles, subscription)
        watch_handles[subscription] = AeronWatchHandle[]
    end
    push!(watch_handles[subscription], wh)
    if isnothing(poller_task[])
        poller_task[] = Threads.@spawn :default _launch_poller_task(watch_handles)
        errormonitor(poller_task[])
    end
    return wh
end
function unwatch(wh::AeronWatchHandle)
    arr = watch_handles[wh.subscription]
    deleteat!(arr, findfirst(==(wh), arr))
end

# TODO: thread safety

# TODO:
# function watch(callback::Base.Callable, conf::AeronConfig; kwargs...)
#     subscribe(conf) do sub
#         watch(callback, sub; kwargs...)
#     end
# end


"""
Temporarilly pause or continue processing callbacks for a given watched subscription. 
Messages are still received and dealt with, but no data is copied and
"""
function active(wh::AeronWatchHandle, active::Bool)
    return wh.active = active
end

"""
Return if callbacks are being processed for a given subscription.
"""
function active(wh::AeronWatchHandle)
    return wh.active
end

const watch_handles = Dict{AeronSubscription,Vector{AeronWatchHandle}}()
const poller_task = Ref{Union{Nothing, Task}}(nothing)

function _launch_poller_task(watch_handles)
    i = 0
    while true
        # TODO: we should support multiple watch handles for the same subscription using a dictionary
        for sub in keys(watch_handles)
            any_active = false
            for wh in watch_handles[sub]
                any_active |= wh.active
            end
            if !any_active
                poll(sub, noop=true)
                continue
            end
            out = poll(sub)
            if !isnothing(out)
                for wh in watch_handles[sub]
                    if mod(wh.decimate_idx, wh.decimate) == 0 &&
                        (wh.decimate_time == 0 || time() - wh.decimate_last_time > wh.decimate_time)
                        wh.callback(out)
                        if wh.decimate_time > 0
                            wh.decimate_last_time = time()
                        end
                    end
                end
            end
            for wh in watch_handles[sub]
                wh.decimate_idx += 1
            end
        end
        # Insert safepoints every 1000 polls
        if mod(i, 1000) == 0
            GC.safepoint()
        end

        i += 1
    end
end