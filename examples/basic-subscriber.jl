using Aeron

# conf = AeronConfig(
#     "aeron:udp?endpoint=localhost:20121",
#     stream=1001,
# )
conf = AeronConfig(
           channel="aeron:ipc",
           stream=1001,
       )

Aeron.subscribe(conf) do sub

    # Loop forever:
    # for frame in sub
    #     total = sum(frame.buffer)
    #     @info "Message received" total
    # end

    # Loop for 10 frames:
    for (i, frame) in enumerate(sub)
        total = sum(frame.buffer)
        @info "Message received" total
        if i > 10
            break
        end
    end

    return true
end

