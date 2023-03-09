# Aeron.jl

Julia wrappers around the [Aeron Client](https://github.com/real-logic/Aeron) C library for reliable UDP unicast, multicast, and shared-memory messaging.

This repository provides LibAeron.jl and Aeron.jl. The former containers bare-bones defintions for accessing the Aeron client C library, while the latter attemps to wrap those definitions in a higher level more Julia-friendly interface.

Using this library, you can shuttle data between processes or machines with zero dynamic memory allocations and at very low latency.

## Example

This example assumes you have already started an Aeron media driver (for now you will have to compile aeronmd yourself from the [upstream repo](https://github.com/real-logic/Aeron)). You must start one media driver per user/computer.

### Publisher

First, specify the stream. You can use an inter-process-communication channel or UDP / UDP multicast across a network.
The stream number is a unique integer to specify which stream of data to publish to / listen on.
```julia
conf = AeronConfig(
    channel="aeron:ipc",
    stream=1001,
)
```

Now start publishing to that stream. You have to convert your data into a vector of bytes (UInt8).
Interpretting those bytes is up to you. You could serialize / deserialize a message using any format
you want, or just send raw arrays.
```
Aeron.publisher(conf) do pub
    
    # For this test, send 10,000 bytes incrementing from 0:255 in a repeating cycle.
    message = zeros(UInt8, 10_000)
    
    for i in 1:100000

        message .= rem.(i, 255)


        # Sending a string:        
        # msg = "Hello world $i"
        # message = Vector{UInt8}(msg)

        # Status is a symbol to indicate if the publication was successful.
        status = Aeron.publication_offer(pub, message)

        @show status
        sleep(1)
    end
end
```


### Subscriber

The subscriber looks similar, only you use a for loop to pull data frames out
of the subscription. 

The main loop is completely allocation free.
```
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

    # frame.buffer is a byte vector that is valid during that loop iteration only.

    return
end
```
