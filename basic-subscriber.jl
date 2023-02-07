include("gen/LibAeron.jl")

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
if !@isdefined AVAIL
    const AVAIL = Ref(0)
end
function print_available_image(clientd, subscription, image)
    AVAIL[] = AVAIL[] + 1
    # @ccall printf("available image"::Cstring)::Cint
    # must be static pre 1.9 (but should be static after too?)
    return 1
end
function print_unavailable_image(clientd, subscription, image)
    # foo = 1
    # @ccall printf("%s = %d"::Cstring ; "foo"::Cstring, foo::Cint)::Cint
    # must be static pre 1.9 (but should be static after too?)
    return 1
end
# void print_available_image(void *clientd, aeron_subscription_t *subscription, aeron_image_t *image)
# {
#     aeron_subscription_constants_t subscription_constants;
#     aeron_image_constants_t image_constants;

#     if (aeron_subscription_constants(subscription, &subscription_constants) < 0 ||
#         aeron_image_constants(image, &image_constants) < 0)
#     {
#         fprintf(stderr, "could not get subscription/image constants: %s\n", aeron_errmsg());
#     }
#     else
#     {
#         printf(
#             "Available image on %s streamId=%" PRId32 " sessionId=%" PRId32 " mtu=%" PRId32 " term-length=%" PRId32 " from %s\n",
#             subscription_constants.channel,
#             subscription_constants.stream_id,
#             image_constants.session_id,
#             (int32_t)image_constants.mtu_length,
#             (int32_t)image_constants.term_buffer_length,
#             image_constants.source_identity);
#     }
# }

# void print_unavailable_image(void *clientd, aeron_subscription_t *subscription, aeron_image_t *image)
# {
#     aeron_subscription_constants_t subscription_constants;
#     aeron_image_constants_t image_constants;

#     if (aeron_subscription_constants(subscription, &subscription_constants) < 0 ||
#         aeron_image_constants(image, &image_constants) < 0)
#     {
#         fprintf(stderr, "could not get subscription/image constants: %s\n", aeron_errmsg());
#     }
#     else
#     {
#         printf(
#             "Unavailable image on %s streamId=%" PRId32 " sessionId=%" PRId32 "\n",
#             subscription_constants.channel,
#             subscription_constants.stream_id,
#             image_constants.session_id);
#     }
# }

function poll_handler(clientd, buffer, length, header_ptr)
    # Allocation free
    bufarr = PtrArray(buffer, (length,))

    # Allocates
    # header = unsafe_load(header_ptr)

    @info "Message received" bufarr

    return nothing
end


    # void poll_handler(void *clientd, const uint8_t *buffer, size_t length, aeron_header_t *header)
    # {
    #     aeron_subscription_t *subscription = (aeron_subscription_t *)clientd;
    #     aeron_subscription_constants_t subscription_constants;
    #     aeron_header_values_t header_values;
    
    #     if (aeron_subscription_constants(subscription, &subscription_constants) < 0)
    #     {
    #         fprintf(stderr, "could not get subscription constants: %s\n", aeron_errmsg());
    #         return;
    #     }
    
    #     aeron_header_values(header, &header_values);
    
    #     printf(
    #         "Message to stream %" PRId32 " from session %" PRId32 " (%" PRIu64 " bytes) <<%.*s>>\n",
    #         subscription_constants.stream_id,
    #         header_values.frame.session_id,
    #         (uint64_t)length,
    #         (int)length,
    #         buffer);
    # }

function main()
    channel = DEFAULT_CHANNEL
    idle_duration_ns = 1000 * 1000
    stream_id = DEFAULT_STREAM_ID

    println("Subscribing to channel $channel on Stream ID $stream_id")

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
            channel,
            stream_id,
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

    # void poll_handler(void *clientd, const uint8_t *buffer, size_t length, aeron_header_t *header)
        poll_handler_ptr = @cfunction(poll_handler, Cvoid, (Ptr{Nothing}, Ptr{UInt8}, Csize_t, Ptr{LibAeron.aeron_header_t}))
    
        if @c(LibAeron.aeron_fragment_assembler_create(&fragment_assembler, poll_handler_ptr, subscription)) < 0
            error("aeron_fragment_assembler_create: "*unsafe_string(LibAeron.aeron_errmsg()))
        end

        # function aeron_fragment_assembler_handler(clientd, buffer, length, header)
        #     @ccall libaeron.aeron_fragment_assembler_handler(clientd::Ptr{Cvoid}, buffer::Ptr{UInt8}, length::Csize_t, header::Ptr{aeron_header_t})::Cvoid
        # end
        # aeron_fragment_assembler_handler_ptr = @cfunction(LibAeron.aeron_fragment_assembler_handler, Cvoid, (Ptr{Cvoid}, Ptr{UInt8}, Csize_t, Ptr{aeron_header_t}))
        aeron_fragment_assembler_handler_ptr = dlsym(dlopen(LibAeron.libaeron), :aeron_fragment_assembler_handler)
        timeout = time() + 30
        while time() < timeout
            fragments_read = LibAeron.aeron_subscription_poll(
                subscription,
                aeron_fragment_assembler_handler_ptr,
                fragment_assembler,
                DEFAULT_FRAGMENT_COUNT_LIMIT
            )
            if fragments_read < 0
                error("aeron_subscription_poll: "*unsafe_string(LibAeron.aeron_errmsg()))
            end

            @c LibAeron.aeron_idle_strategy_sleeping_idle(&idle_duration_ns, fragments_read);
        
        #         if (fragments_read < 0)
        #         {
        #             fprintf(stderr, "aeron_subscription_poll: %s\n", aeron_errmsg());
        #             goto cleanup;
        #         }
        
        #         aeron_idle_strategy_sleeping_idle((void *)&idle_duration_ns, fragments_read);
        end

    finally
        LibAeron.aeron_subscription_close(subscription, C_NULL, C_NULL)
        LibAeron.aeron_close(aeron)
        LibAeron.aeron_context_close(context)
        LibAeron.aeron_fragment_assembler_delete(fragment_assembler)
        @info "cleanup complete"
    end
end

main()