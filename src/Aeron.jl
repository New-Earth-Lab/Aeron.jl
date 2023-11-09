module Aeron

include("LibAeron.jl")
using CSyntax

export AeronCtx
mutable struct AeronCtx
    aeron::Ptr{Nothing}
    context::Ptr{Nothing}
end
function AeronCtx()
    # Initialize 
    aeron = Ptr{LibAeron.aeron_t}(C_NULL)
    context = Ptr{LibAeron.aeron_context_t}(C_NULL)
    if @c(LibAeron.aeron_context_init(&context)) < 0
        error("aeron_context_init: "*unsafe_string(LibAeron.aeron_errmsg()))
    end

    if @c(LibAeron.aeron_init(&aeron, context)) < 0
        error("aeron_init: "*unsafe_string(LibAeron.aeron_errmsg()))
    end

    if LibAeron.aeron_start(aeron) < 0
        error("aeron_start: "*unsafe_string(LibAeron.aeron_errmsg()))
    end
    ctx =  AeronCtx(aeron,context)
    finalizer(close, ctx)
    return ctx
end

function AeronCtx(callback::Base.Callable)    
    ctx = aeronctx()
    try
        callback(ctx)
    finally
        close(ctx)
    end
end


function Base.close(ctx::AeronCtx)
    if ctx.aeron != C_NULL
        LibAeron.aeron_close(ctx.aeron)
    end
    ctx.aeron = C_NULL
    if ctx.context != C_NULL
        LibAeron.aeron_context_close(ctx.context)
    end
    ctx.context = C_NULL
    return
end


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
