# Aeron.jl

Julia wrappers around the [Aeron Client](https://github.com/real-logic/Aeron) C library for reliable UDP unicast, multicast, and shared-memory messaging.

This repository provides LibAeron.jl and Aeron.jl. The former containers bare-bones defintions for accessing the Aeron client C library, while the latter attemps to wrap those definitions in a higher level more Julia-friendly interface.

Using this library, you can shuttle data between processes or machines with zero dynamic memory allocations and at very low latency.


### Media Driver
Aeron uses a "media driver", which is a standalone process, to coordinate moving data between processes or over the network. You must start one media driver per computer (and perhaps user, on multi-user systems). The client library (linked into Julia) then communicates only with the media driver using shared memory.

For supported platforms (GNU/linux x64 and aarch64, Apple silicon), we provide both the pre-built client library and media driver. 

In a dedicated Julia process, you can start the media driver like this:
```julia
using Aeron
Aeron.mediadriver()
```

For other platforms (eg. Windows and Intel macs), you can build the client library and media driver  yourself following instrutions from the [upstream repo](https://github.com/real-logic/Aeron)). Either the Java or C media driver will work.

## Example

### Setup

Start the media driver process in the background (note: only one media driver per computer & user account).
```julia
using Aeron_jll
run(`$(aeronmd())`, wait=false)
```

Now create an aeron context object to initialize the client library. This will fail if the media driver isn't yet running.
```julia
using Aeron
ctx = AeronContext()
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
        status = put!(pub, message)

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

Aeron.subscriber(ctx, conf) do sub

    # Loop forever:
    # for message in sub
    #     total = sum(message.buffer)
    #     @info "Message received" total
    # end

    # Loop for 10 message:
    for (i, message) in enumerate(sub)
        total = sum(message.buffer)
        @info "Message received" total
        if i > 10
            break
        end
    end

    # message is an AeronAssembledMessage
    # message.buffer is a byte vector that is valid during that loop iteration only.

    return
end
```


You can also poll the subscription as needed. This is a great way to incorporate a subscription
into an existing event loop.


The main loop is completely allocation free.
```julia
conf = AeronConfig(
    channel="aeron:ipc",
    stream=1001,
)

sub = Aeron.subscriber(ctx, conf)

# Take a single assembled messages directly (blocking, busy wait)
message = take!(sub)

# Read 0 or more fragments
while true
    fragments_read, message = Aeron.poll(
        sub;
        # fragment_count_limit=1,
        # noop=false
    )
    # Large messages are split into multiple fragments and automatically reassembled. 
    # fragments_read is an integer number of message fragments received. 
    # If a message is received
    if !isnothing(message)
        # process message
    end
end
```


## More Control
The submodule `Aeron.LibAeron` directly wraps the C aeron client library. Use this if you want to handle all the details of the connection yourself, or want to ensure true zero-copy semantics.