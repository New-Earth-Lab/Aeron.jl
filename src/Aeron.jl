module Aeron
using CSyntax
using Compat
using Aeron_jll

include("LibAeron.jl")

export AeronContext, AeronConfig
@compat public mediadriver, subscriber, publisher, publication_offer, poll, watch, unwatch, active, unwatchall

export AeronContext
mutable struct AeronContext
    aeron::Ptr{Nothing}
    context::Ptr{Nothing}
end
function AeronContext(;dir::Union{Nothing,AbstractString}=nothing)
    # Initialize 
    aeron = Ptr{LibAeron.aeron_t}(C_NULL)
    context = Ptr{LibAeron.aeron_context_t}(C_NULL)
    if @c(LibAeron.aeron_context_init(&context)) < 0
        error("aeron_context_init: "*unsafe_string(LibAeron.aeron_errmsg()))
    end

    if !isnothing(dir)
        ret = LibAeron.aeron_context_set_dir(context, dir)
        if ret != 0
            msg = LibAeron.aeron_errmsg()
            error(lazy"failed to set aeron directory: $msg")
        end
    end

    if @c(LibAeron.aeron_init(&aeron, context)) < 0
        error("aeron_init: "*unsafe_string(LibAeron.aeron_errmsg()))
    end

    if LibAeron.aeron_start(aeron) < 0
        error("aeron_start: "*unsafe_string(LibAeron.aeron_errmsg()))
    end
    
    ctx =  AeronContext(aeron,context)
    finalizer(close, ctx)
    return ctx
end

function AeronContext(callback::Base.Callable)    
    ctx = AeronContext()
    try
        callback(ctx)
    finally
        close(ctx)
    end
end


function Base.close(ctx::AeronContext)
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
    uri::String
    stream::Int64
    fragment_count_limit::Int64=10
end
AeronConfig(uri; kwargs...) = AeronConfig(;uri, kwargs...)
AeronConfig(uri, stream; kwargs...) = AeronConfig(;uri, stream, kwargs...)
export AeronConfig


"""
    mediadriver(;env=String[], wait=true)

Run the aeron media driver process. One media driver must be run per computer & user account
in order to pass data between processes and over the network.

You can control some aspects of how the media driver runs by passing environment variables in 
the `env` vector of strings.

See the aeron wiki at: https://github.com/real-logic/aeron/wiki/Configuration-Options


Pass `wait=false` to 
"""
function mediadriver(;env::Vector{String}=String[], wait=true)
    cmd = addenv(Aeron_jll.aeronmd(), env)
    t = run(`$(cmd)`; wait)
    if !wait
        @async begin
            ret = fetch(t)
            if ret.exitcode > 0
                @error "media driver exited with error" exitcode=ret.exitcode
            end
        end
    end
    return t
end

include("subscribe.jl")
include("publish.jl")

end
