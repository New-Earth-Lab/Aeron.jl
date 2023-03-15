using Aeron

conf = AeronConfig(
    channel="aeron:ipc",
    stream=1002,
)

# Version           flyweight.Int32Field
# PayloadType       flyweight.Int32Field
# TimestampNs       flyweight.Int64Field
# Format            flyweight.Int32Field
# SizeX             flyweight.Int32Field
# SizeY             flyweight.Int32Field
# OffsetX           flyweight.Int32Field
# OffsetY           flyweight.Int32Field
# PaddingX          flyweight.Int32Field
# PaddingY          flyweight.Int32Field
# MetadataLength    flyweight.Int32Field
# MetadataBuffer    flyweight.RawDataField
# pad0              flyweight.Padding
# ImageBufferLength flyweight.Int32Field
include(joinpath(@__DIR__, "image-frame.jl"))


global image
t = Threads.@spawn  Aeron.subscribe(conf) do subscrption
        
    
    
    # Loop for 10 frames:
    for (i, frame) in enumerate(subscrption)
        total = sum(frame.buffer)
        if i > 10
            break
        end

        header = VenomsFrameHeader1(frame.buffer)
        @info "Message received" SizeX(header) SizeY(header) TimestampNs(header)


        # header32 = reinterpret(Int32, frame.buffer[1:52])
        # header64 = reinterpret(Int64, frame.buffer[1:48])

        # i = 1
        # Version = header32[i]; i+= 1;
        # PayloadType = header32[i]; i+= 1;
        # TimestampNs = header64[2]; i+= 2;
        # Format = header32[i]; i+= 1;
        # SizeX = header32[i]; i+= 1;
        # SizeY = header32[i]; i+= 1;
        # OffsetX = header32[i]; i+= 1;
        # OffsetY = header32[i]; i+= 1;
        # PaddingX = header32[i]; i+= 1;
        # PaddingY = header32[i]; i+= 1;
        # MetadataLength = header32[i]; i+= 1;

        # @show pointer(frame.buffer,1)
        # @info "Message received" SizeX SizeY TimestampNs

        # Version     = unsafe_load(Ptr{Int32}(pointer(frame.buffer,1)))
        # PayloadType = unsafe_load(Ptr{Int32}(pointer(frame.buffer,5)))
        # TimestampNs = unsafe_load(Ptr{Int64}(pointer(frame.buffer,9)))
        # Format      = unsafe_load(Ptr{Int32}(pointer(frame.buffer,9)))
        # SizeX       = unsafe_load(Ptr{Int32}(pointer(frame.buffer,11)))
        # SizeY       = unsafe_load(Ptr{Int32}(pointer(frame.buffer,13)))
        # OffsetX     = unsafe_load(Ptr{Int32}(pointer(frame.buffer,15)))
        # OffsetY     = unsafe_load(Ptr{Int32}(pointer(frame.buffer,17)))
        # PaddingX    = unsafe_load(Ptr{Int32}(pointer(frame.buffer,19)))
        # PaddingY    = unsafe_load(Ptr{Int32}(pointer(frame.buffer,21)))
        # MetadataLength = unsafe_load(Ptr{Int32}(pointer(frame.buffer,23)))
        # MetadataBuffer    flyweight.RawDataField
        # pad0              flyweight.Padding
        # ImageBufferLength flyweight.Int32Field

        global image

        # image = reshape(reinterpret(Int16, header.ImageBuffer), Int64(header.SizeX), Int64(header.SizeY))
        image = Image(header)
        display(imview(image[:,end:-1:begin],))
        sleep(0.01)

    end

    
    return
end
errormonitor(t)

