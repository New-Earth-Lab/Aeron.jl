using Aeron

conf = AeronConfig1(
    "aeron:udp?endpoint=localhost:20121",
    stream=1001,
)


i = 0
Aeron.subscribe(conf) do buffer
    
    total = sum(buffer)
    @info "Message received" total

    # Break out after a while (Better to use a for loop/iterator API?)
    global i += 1
    if i > 10
        error()
    end

end