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

Aeron.publisher(conf) do pub
    
    buffer = zeros(UInt8, 640*512*2+53)
    header = VenomsFrameHeader1(buffer)
    SizeX!(header, 640)
    SizeY!(header, 512)
    MetadataLength!(header,  0)
    ImageBufferLength!(header, 640*512*2)

    
    for i in 1:100000
        TimestampNs!(header, time_ns())
        Image(header) .= clamp.(round.(800 .*randn.().+800), typemin(Int16), typemax(Int16))
        
        status = Aeron.publication_offer(pub, header.buffer)

        @show status
        sleep(1)
    end
end
