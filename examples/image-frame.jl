
"""
Represents the header of a VENOMS frame sent over an Aeron stream.
Given a buffer or view, provide property access to the underlying
fields without copying
"""
struct VenomsFrameHeader1{T<:AbstractArray{UInt8}}
    buffer::T
end

Version(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[ 1:4 ])[] 
Version!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[ 1:4 ])[] = value
PayloadType(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[ 5:8 ])[] 
PayloadType!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[ 5:8 ])[] = value
TimestampNs(vfh::VenomsFrameHeader1) = reinterpret(Int64, @view vfh.buffer[ 9:16])[] 
TimestampNs!(vfh::VenomsFrameHeader1, value) = reinterpret(Int64, @view vfh.buffer[ 9:16])[] = value
Format(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[17:20])[] 
Format!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[17:20])[] = value
SizeX(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[21:24])[] 
SizeX!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[21:24])[] = value
SizeY(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[25:28])[] 
SizeY!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[25:28])[] = value
OffsetX(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[29:32])[] 
OffsetX!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[29:32])[] = value
OffsetY(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[33:36])[] 
OffsetY!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[33:36])[] = value
PaddingX(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[37:40])[] 
PaddingX!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[37:40])[] = value
PaddingY(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[41:44])[] 
PaddingY!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[41:44])[] = value
MetadataLength(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[45:48])[] 
MetadataLength!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[45:48])[] = value
MetadataBuffer(vfh::VenomsFrameHeader1) = @view vfh.buffer[49:49+MetadataLength(vfh)-1] # TODO: 4-byte alignment
ImageBufferLength(vfh::VenomsFrameHeader1) = reinterpret(Int32, @view vfh.buffer[49+MetadataLength(vfh):49+MetadataLength(vfh)+3])[]
ImageBufferLength!(vfh::VenomsFrameHeader1, value) = reinterpret(Int32, @view vfh.buffer[49+MetadataLength(vfh):49+MetadataLength(vfh)+3])[]= value
function ImageBuffer(vfh::VenomsFrameHeader1)
    start = 49+MetadataLength(vfh)+4
    len = ImageBufferLength(vfh)
    return @view vfh.buffer[start:start+len-1]
end
function Image(vfh::VenomsFrameHeader1)
    # TODO: read Format to decide output kind
    return reshape(reinterpret(Int16, ImageBuffer(vfh)), Int64(SizeX(vfh)), Int64(SizeY(vfh)))
end


# function Base.propertynames(::VenomsFrameHeader1; private=false)
#     return (
#         :Version,
#         :PayloadType,
#         :TimestampNs,
#         :Format,
#         :SizeX,
#         :SizeY,
#         :OffsetX,
#         :OffsetY,
#         :PaddingX,
#         :PaddingY,
#         :MetadataLength,
#         :MetadataBuffer,
#         :ImageBufferLength,
#         :ImageBuffer,
#         :Image
#     )
# end

# # TODO: this is not type stable
# function Base.getproperty(vfh::VenomsFrameHeader1, prop::Symbol)
#     return ( 
#         if prop === :Version
#             reinterpret(Int32, @view vfh.buffer[ 1:4 ])[] 
#         elseif prop === :PayloadType
#             reinterpret(Int32, @view vfh.buffer[ 5:8 ])[] 
#         elseif prop === :TimestampNs
#             reinterpret(Int64, @view vfh.buffer[ 9:16])[] 
#         elseif prop === :Format
#             reinterpret(Int32, @view vfh.buffer[17:20])[] 
#         elseif prop === :SizeX
#             reinterpret(Int32, @view vfh.buffer[21:24])[] 
#         elseif prop === :SizeY
#             reinterpret(Int32, @view vfh.buffer[25:28])[] 
#         elseif prop === :OffsetX
#             reinterpret(Int32, @view vfh.buffer[29:32])[] 
#         elseif prop === :OffsetY
#             reinterpret(Int32, @view vfh.buffer[33:36])[] 
#         elseif prop === :PaddingX
#             reinterpret(Int32, @view vfh.buffer[37:40])[] 
#         elseif prop === :PaddingY
#             reinterpret(Int32, @view vfh.buffer[41:44])[] 
#         elseif prop === :MetadataLength
#             reinterpret(Int32, @view vfh.buffer[45:48])[] 
#         elseif prop === :MetadataBuffer
#             # TODO: 4-byte alignment
#             @view vfh.buffer[49:49+vfh.MetadataLength-1] 
#         elseif prop === :ImageBufferLength
#             reinterpret(Int32, @view vfh.buffer[49+vfh.MetadataLength:49+vfh.MetadataLength+3])[]
#         elseif prop === :ImageBuffer
#             start = 49+vfh.MetadataLength+4
#             len = vfh.ImageBufferLength
#             @view vfh.buffer[start:start+len-1]
#         elseif prop === :Image
#             # TODO: read Format to decide output kind
#             @show vfh.SizeX vfh.SizeY
#             reshape(reinterpret(Int16, vfh.ImageBuffer), Int64(vfh.SizeX), Int64(vfh.SizeY))
#         else
#             getfield(vfh, prop)
#         end
#     )
# end
# function Base.setproperty!(vfh::VenomsFrameHeader1, prop::Symbol, value)
#     return ( 
#         if prop === :Version
#             reinterpret(Int32, @view vfh.buffer[ 1:4 ])[] = value
#         elseif prop === :PayloadType
#             reinterpret(Int32, @view vfh.buffer[ 5:8 ])[] = value
#         elseif prop === :TimestampNs
#             reinterpret(Int64, @view vfh.buffer[ 9:16])[] = value
#         elseif prop === :Format
#             reinterpret(Int32, @view vfh.buffer[17:20])[] = value
#         elseif prop === :SizeX
#             reinterpret(Int32, @view vfh.buffer[21:24])[] = value
#         elseif prop === :SizeY
#             reinterpret(Int32, @view vfh.buffer[25:28])[] = value
#         elseif prop === :OffsetX
#             reinterpret(Int32, @view vfh.buffer[29:32])[] = value
#         elseif prop === :OffsetY
#             reinterpret(Int32, @view vfh.buffer[33:36])[] = value
#         elseif prop === :PaddingX
#             reinterpret(Int32, @view vfh.buffer[37:40])[] = value
#         elseif prop === :PaddingY
#             reinterpret(Int32, @view vfh.buffer[41:44])[] = value
#         elseif prop === :MetadataLength
#             reinterpret(Int32, @view vfh.buffer[45:48])[] = value
#         elseif prop === :MetadataBuffer
#             # TODO: 4-byte alignment
#             @view vfh.buffer[49:49+vfh.MetadataLength-1] 
#         elseif prop === :ImageBufferLength
#             reinterpret(Int32, @view vfh.buffer[49+vfh.MetadataLength:49+vfh.MetadataLength+3])[] = value
#         else
#             getfield(vfh, prop)
#         end
#     )
# end