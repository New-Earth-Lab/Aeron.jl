module Aeron

include("LibAeron.jl")
export LibAeron

using CSyntax
using Libdl
using StrideArrays


Base.@kwdef struct AeronConfig1
    channel::String
    stream::Int64
    fragment_count_limit::Int64=10
end
AeronConfig1(channel; kwargs...) = AeronConfig1(;channel, kwargs...)
AeronConfig1(channel, stream; kwargs...) = AeronConfig1(;channel, stream, kwargs...)
export AeronConfig1


include("subscribe.jl")
include("publish.jl")

end