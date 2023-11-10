
struct AeronPublication
    handle::Ptr{LibAeron.aeron_publication_t}
    context::Ptr{LibAeron.aeron_context_t}
    aeron::Ptr{LibAeron.aeron_t}
end

function publisher(ctx::AeronContext, conf::AeronConfig)


    @debug "Publishing to channel $(conf.channel) on Stream ID $(conf.stream)"

    publication = Ptr{LibAeron.aeron_publication_t}(C_NULL)
    async = Ptr{LibAeron.aeron_async_add_publication_t}(C_NULL)

    try

        if LibAeron.aeron_start(ctx.aeron) < 0
            error("aeron_start: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
        @debug "started"

        if @c(LibAeron.aeron_async_add_publication(
            &async,
            ctx.aeron,
            conf.channel,
            conf.stream,)) < 0
            error("aeron_async_add_publication: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
    
        timeout = time() + 5
        while (C_NULL == publication)
            if @c(LibAeron.aeron_async_add_publication_poll(&publication, async)) < 0
                error("aeron_async_add_publication_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
            end    
            yield()
            if time() > timeout
                error("timed out adding subscription after 5s")
            end
        end
    
        @debug "Publication channel status " LibAeron.aeron_publication_channel_status(publication)

        # callback(pubhandle)

    catch err
        LibAeron.aeron_publication_close(publication, C_NULL, C_NULL)
        rethrow(err)
    end
    pubhandle = AeronPublication(publication,ctx.context,ctx.aeron)

    return pubhandle
end

function publisher(callback::Base.Callable, ctx::AeronContext,  conf::AeronConfig)
    pubhandle = publisher(ctx, conf)
    try
        callback(pubhandle)
    finally
        LibAeron.aeron_publication_close(pubhandle.handle, C_NULL, C_NULL)
    end
end

function Base.close(pubhandle::AeronPublication)
    LibAeron.aeron_publication_close(pubhandle.handle, C_NULL, C_NULL)
end

"""
    put!(pub::AeronPublication, data::AbstractArray{UInt8}; robust=true, robust_timeout_ns=100_000)::Symbol

Send data over an aeron publication. The return value is `:success`, `:backpressured`, `:notconnected`, or 
`:unknown`. Errors if the publication is closed.

If robust is true, try a bit harder to send the message, retrying repeatedly 
if the status is `:adminaction` or `:backpressure` until `robust_timeout_ns` passes.
"""
function Base.put!(pub::AeronPublication, message::AbstractArray{UInt8}, robust=true, robust_timeout_ns=100_000)

    if robust
        start_time = time_ns()
        message_len = length(message)
        # Retry the publication in case we are rotating term buffers.
        # Use ADMIN_ACTION as an initial sentinel
        result = LibAeron.AERON_PUBLICATION_ADMIN_ACTION
        while (
            result == LibAeron.AERON_PUBLICATION_ADMIN_ACTION ||
            result == LibAeron.AERON_PUBLICATION_BACK_PRESSURED
        ) && time_ns() - start_time < robust_timeout_ns
            result = 
                LibAeron.aeron_publication_offer(pub.handle, message, message_len, C_NULL, C_NULL)
        end
    else
        result = 
                LibAeron.aeron_publication_offer(pub.handle, message, message_len, C_NULL, C_NULL)
    end


    if result > 0
        return :success
    elseif LibAeron.AERON_PUBLICATION_BACK_PRESSURED == result
        return :backpressured
    elseif LibAeron.AERON_PUBLICATION_NOT_CONNECTED == result
        return :notconnected
    elseif LibAeron.AERON_PUBLICATION_ADMIN_ACTION == result
        return :adminaction
    elseif LibAeron.AERON_PUBLICATION_CLOSED == result
        error("Offer failed because publication is closed")
    else
        return :unknown
    end
    # if !LibAeron.aeron_publication_is_connected(publication)
        # println("No active subscribers detected")
    # end
end
const publication_offer = Base.put!