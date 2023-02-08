using Aeron

conf = AeronConfig1(
    "aeron:udp?endpoint=localhost:20121",
    stream=1001,
)

Aeron.subscribe(conf) do buffer
    
    total = sum(buffer)
    @info "Message received" total

end