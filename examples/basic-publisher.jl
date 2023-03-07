using Aeron

# conf = AeronConfig(
#     "aeron:udp?endpoint=localhost:20121",
#     stream=1001,
# )
conf = AeronConfig(
           channel="aeron:ipc",
           stream=1001,
       )

Aeron.publisher(conf) do pub
    
    message = zeros(UInt8, 50*1308)
    
    for i in 1:100000
        
        # msg = "Hello world $i   " #* "A"^10024
        # print(msg)
        # message = Vector{UInt8}(msg)
        message .= rem.(i, 255)

        status = Aeron.publication_offer(pub, message)

        @show status
        sleep(1)
    end
end