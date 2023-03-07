using Clang
using Clang.Generators

using Aeron_jll

cd(@__DIR__)

# include_dir = normpath("../artifact/include/aeron")
include_dir = joinpath(Aeron_jll.artifact_dir, "include/aeron")
options = load_options(joinpath(@__DIR__, "generator.toml"))

# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args(Clang.JLLEnvs.JLL_ENV_TRIPLES[11])  # Note you must call this function firstly and then append your own flags
push!(args, "-I$include_dir")

headers = joinpath.(
    include_dir,
    [
        "aeronc.h",
        "concurrent/aeron_atomic.h",
        "util/aeron_strutil.h",
        "util/aeron_parse_util.h",
        "aeron_agent.h",
        "protocol/aeron_udp_protocol.h",
    ]
)


# headers = [header for header in readdir(include_dir,join=true) if endswith(header, ".h")]
# there is also an experimental `detect_headers` function for auto-detecting top-level headers in the directory
# headers = detect_headers(clang_dir, args)

# headers = detect_headers(includedir, args)

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx, BUILDSTAGE_NO_PRINTING)


build!(ctx, BUILDSTAGE_PRINTING_ONLY)
