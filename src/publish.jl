
struct AeronPublication1
    handle::Ptr{LibAeron.aeron_publication_t}
end

function publisher(callback::Base.Callable, conf::AeronConfig1)


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

        pubhandle = AeronPublication1(publication)
        callback(pubhandle)


    finally
        LibAeron.aeron_subscription_close(publication, C_NULL, C_NULL)
        LibAeron.aeron_close(aeron)
        LibAeron.aeron_context_close(context)
        @info "cleanup complete"
    end
end


function publication_offer(pub::AeronPublication1, message::AbstractArray{UInt8})

    message_len = length(message)
    result = 
        LibAeron.aeron_publication_offer(pub.handle, message, message_len, C_NULL, C_NULL)

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
        return :closed
        # println("Offer failed because publication is closed")
    else
        return :unknown
        # println("Offer failed due to unknown reason ", res)
    end
    # if !LibAeron.aeron_publication_is_connected(publication)
        # println("No active subscribers detected")
    # end
end
