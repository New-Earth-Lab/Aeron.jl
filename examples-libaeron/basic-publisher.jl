using Aeron: LibAeron

using CSyntax
using Libdl
using StrideArrays

## Basic config
DEFAULT_CHANNEL = "aeron:udp?endpoint=localhost:20121"
DEFAULT_PING_CHANNEL = "aeron:udp?endpoint=localhost:20123"
DEFAULT_PONG_CHANNEL = "aeron:udp?endpoint=localhost:20124"
DEFAULT_STREAM_ID = (1001)
DEFAULT_PING_STREAM_ID = (1002)
DEFAULT_PONG_STREAM_ID = (1003)
DEFAULT_NUMBER_OF_WARM_UP_MESSAGES = (100000)
DEFAULT_NUMBER_OF_MESSAGES = (10000000)
DEFAULT_MESSAGE_LENGTH = (32)
DEFAULT_LINGER_TIMEOUT_MS = (0)
DEFAULT_FRAGMENT_COUNT_LIMIT = (10)
DEFAULT_RANDOM_MESSAGE_LENGTH = (false)
DEFAULT_PUBLICATION_RATE_PROGRESS = (false)
##


function main()
    channel = DEFAULT_CHANNEL
    stream_id = DEFAULT_STREAM_ID

    println("Publishing to channel $channel on Stream ID $stream_id")

    aeron = Ptr{LibAeron.aeron_t}(C_NULL)
    context = Ptr{LibAeron.aeron_context_t}(C_NULL)
    publication = Ptr{LibAeron.aeron_publication_t}(C_NULL)
    # fragment_assembler = Ptr{LibAeron.aeron_fragment_assembler_t}(C_NULL)
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
            channel,
            stream_id,)) < 0
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

        for i in 1:100000
            msg = "Hello world $i   "
            print(msg)
            message = Vector{UInt8}(msg)
            message_len = length(message)
            result = 
                LibAeron.aeron_publication_offer(publication, message, message_len, C_NULL, C_NULL)


            if result > 0
                println("yay!")
            elseif LibAeron.AERON_PUBLICATION_BACK_PRESSURED == result
                println("Offer failed due to back pressure")
            elseif LibAeron.AERON_PUBLICATION_NOT_CONNECTED == result
                println("Offer failed because publisher is not connected to a subscriber")
            elseif LibAeron.AERON_PUBLICATION_ADMIN_ACTION == result
                println("Offer failed because of an administration action in the system")
            elseif LibAeron.AERON_PUBLICATION_CLOSED == result
                println("Offer failed because publication is closed")
            else
                println("Offer failed due to unknown reason ", res)
            end
            if !LibAeron.aeron_publication_is_connected(publication)
                println("No active subscribers detected")
            end
            sleep(1)
        end

    finally
        LibAeron.aeron_subscription_close(publication, C_NULL, C_NULL)
        LibAeron.aeron_close(aeron)
        LibAeron.aeron_context_close(context)
        @info "cleanup complete"
    end
end

main()