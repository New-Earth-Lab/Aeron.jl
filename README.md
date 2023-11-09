# Aeron.jl

Julia wrappers around the [Aeron Client](https://github.com/real-logic/Aeron) C library for reliable UDP unicast, multicast, and shared-memory messaging.

This repository provides LibAeron.jl and Aeron.jl. The former containers bare-bones defintions for accessing the Aeron client C library, while the latter attemps to wrap those definitions in a higher level more Julia-friendly interface.

Using this library, you can shuttle data between processes or machines with zero dynamic memory allocations and at very low latency.

## Example

### Media Driver
Aeron uses a "media driver" to coordinate moving data between processes or over the network. You must start one media driver per computer (and perhaps user, on multi-user systems). This is a standalone process that runs in the background.

For supported platforms, we provide a pre-built media driver that you can run like this:
```julia
using Aeron_jll
run(`$(aeronmd())`)
```

You can also compile it yourself from the [upstream repo](https://github.com/real-logic/Aeron)).


### Context
Start by creating an aeron context object. This will fail if the media driver isn't yet running.
```julia
ctx = Aeron.AeronCtx()
```

### Publisher

Aeron communications take place over a "channel" and "stream". The channel can be "aeron:ipc" 
to use shared memory if both endpoints are on the same computer, or a UDP address if they
are across a network.
The stream number is a unique integer to specify which stream of data to publish to / listen on.

Create a config object to hold these parameters:
```julia
conf = AeronConfig(
    channel="aeron:ipc",
    stream=1001,
)
```

Now start publishing to that stream. You have to convert your data into a vector of bytes (UInt8).
Interpretting those bytes is up to you. You could serialize / deserialize a message using any format
you want, or just send raw arrays.
```julia
Aeron.publisher(ctx, conf) do pub
    
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
```julia
conf = AeronConfig(
    channel="aeron:ipc",
    stream=1001,
)

Aeron.subscribe(ctx, conf) do sub

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
