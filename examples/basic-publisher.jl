using Aeron

conf = AeronConfig1(
    "aeron:udp?endpoint=localhost:20121",
    stream=1001,
)

Aeron.publisher(conf) do pub
    
    for i in 1:100000
        msg = "Hello world $i   "
        print(msg)
        message = Vector{UInt8}(msg)
        message_len = length(message)

        status = Aeron.publication_offer(pub, message)
        @show status
        sleep(1)
    end

end