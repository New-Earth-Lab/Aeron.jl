include("gen/LibAeron.jl")


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
    idle_duration_ns = 1000 * 1000
    stream_id = DEFAULT_STREAM_ID

    println("Subscribing to channel $channel on Stream ID $stream_id")

    aeron = C_NULL
    context = C_NULL
    subscription = C_NULL
    fragment_assembler = C_NULL

    # try
        
        context = LibAeron.aeron_context_t()
        # @show context
        context_ptr = pointer_from_objref(context)
        # context_ptr = Ptr{LibAeron.aeron_context_t}()
        # @show context
        if LibAeron.aeron_context_init(context_ptr) < 0
            error("aeron_context_init: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
        @info "contexted" context

        aeron = LibAeron.aeron_t()
        aeron_ptr = pointer_from_objref(LibAeron.aeron_t())
        aeron_ptr_ptr = Ptr{Nothing}(aeron_ptr)
        if LibAeron.aeron_init(aeron_ptr_ptr, context_ptr) < 0
            error("aeron_init: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
        @info "inited"


        if aeron_start(aeron) < 0
            error("aeron_start: "*unsafe_string(LibAeron.aeron_errmsg()))
        end
        @info "started"

    # finally
    #     LibAeron.aeron_subscription_close(subscription, C_NULL, C_NULL)
    #     LibAeron.aeron_close(aeron)
    #     if context != C_NULL
    #         LibAeron.aeron_context_close(context)
    #     end
    #     LibAeron.aeron_fragment_assembler_delete(fragment_assembler)
    # end
end

main()