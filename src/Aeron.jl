module Aeron

include("LibAeron.jl")
export LibAeron

using CSyntax

Base.@kwdef struct AeronConfig
    channel::String
    stream::Int64
    fragment_count_limit::Int64=10
end
AeronConfig(channel; kwargs...) = AeronConfig(;channel, kwargs...)
AeronConfig(channel, stream; kwargs...) = AeronConfig(;channel, stream, kwargs...)
export AeronConfig


include("subscribe.jl")
include("publish.jl")

end
