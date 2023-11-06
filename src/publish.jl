
struct AeronPublication
    handle::Ptr{LibAeron.aeron_publication_t}
    context::Ptr{LibAeron.aeron_context_t}
    aeron::Ptr{LibAeron.aeron_t}
end

function publisher(conf::AeronConfig)


    println("Publishing to channel $(conf.channel) on Stream ID $(conf.stream)")

    aeron = Ptr{LibAeron.aeron_t}(C_NULL)
    context = Ptr{LibAeron.aeron_context_t}(C_NULL)
    publication = Ptr{LibAeron.aeron_publication_t}(C_NULL)
    async = Ptr{LibAeron.aeron_async_add_publication_t}(C_NULL)

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

        if @c(LibAeron.aeron_async_add_publication(
            &async,
            aeron,
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
    
        @info "Publication channel status " LibAeron.aeron_publication_channel_status(publication)

        # callback(pubhandle)

    catch err
        LibAeron.aeron_publication_close(publication, C_NULL, C_NULL)
        LibAeron.aeron_close(aeron)
        LibAeron.aeron_context_close(context)
        rethrow(err)
    end
    pubhandle = AeronPublication(publication,context,aeron)

    return pubhandle
end

function publisher(callback::Base.Callable, conf::AeronConfig)
    pubhandle = publisher(conf)
    try
        callback(pubhandle)
    finally
        LibAeron.aeron_publication_close(pubhandle.handle, C_NULL, C_NULL)
        LibAeron.aeron_close(pubhandle.aeron)
        LibAeron.aeron_context_close(pubhandle.context)
    end
end

function Base.close(pubhandle::AeronPublication)
    LibAeron.aeron_publication_close(pubhandle.handle, C_NULL, C_NULL)
    LibAeron.aeron_close(pubhandle.aeron)
    LibAeron.aeron_context_close(pubhandle.context)
end


function publication_offer(pub::AeronPublication, message::AbstractArray{UInt8})

    message_len = length(message)
    # Retry the publication in case we are rotating term buffers.
    # Use ADMIN_ACTION as an initial sentinel
    result = LibAeron.AERON_PUBLICATION_ADMIN_ACTION
    retries = 5
    while result == LibAeron.AERON_PUBLICATION_ADMIN_ACTION && retries > 0
        retries -= 1
        result = 
            LibAeron.aeron_publication_offer(pub.handle, message, message_len, C_NULL, C_NULL)
    end
    if result > 0
        return :success
        # println("yay!")
    elseif LibAeron.AERON_PUBLICATION_BACK_PRESSURED == result
        return :backpressured
        # println("Offer failed due to back pressure")
    elseif LibAeron.AERON_PUBLICATION_NOT_CONNECTED == result
        return :notconnected
        # println("Offer failed because publisher is not connected to a subscriber")
    elseif LibAeron.AERON_PUBLICATION_ADMIN_ACTION == result
        return :adminaction
        # println("Offer failed because of an administration action in the system")
    elseif LibAeron.AERON_PUBLICATION_CLOSED == result
        # return :closed
        error("Offer failed because publication is closed")
    else
        return :unknown
        # println("Offer failed due to unknown reason ", res)
    end
    # if !LibAeron.aeron_publication_is_connected(publication)
        # println("No active subscribers detected")
    # end
end
