using Aeron

# conf = AeronConfig(
#     "aeron:udp?endpoint=localhost:20121",
#     stream=1001,
# )
conf = AeronConfig(
           channel="aeron:ipc",
           stream=1001,
       )

i = 0
Aeron.subscribe2(conf) do header, buffer
    
    total = sum(buffer)
    @info "Message received"

    global i += 1

    return i < 10
end

