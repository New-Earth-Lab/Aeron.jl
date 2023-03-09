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
    
    arr = zeros(Int16, 640, 512)
    
    # View of our data as a vector of bytes. This is what we will send over the wire.
    bytes = vec(reinterpret(UInt8, arr))
    
    for i in 1:100000
        
        arr .= i

        status = Aeron.publication_offer(pub, bytes)

        @show status
        sleep(1)
    end
end
