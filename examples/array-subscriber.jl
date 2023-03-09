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

    # Loop for 10 frames:
    for (i, frame) in enumerate(sub)

        arr = reshape(reinterpret(Int16,frame.buffer), 640, 512)
        display(imview(arr, clims=(0, 50)))
        
        if i > 10
            break
        end
    end

    return true
end

