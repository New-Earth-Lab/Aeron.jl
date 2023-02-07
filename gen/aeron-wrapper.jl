using Clang.Generators

cd(@__DIR__)

include_dir = normpath("../artifact/include/aeron")

options = load_options(joinpath(@__DIR__, "generator.toml"))

# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args(Clang.JLLEnvs.JLL_ENV_TRIPLES[11])  # Note you must call this function firstly and then append your own flags
push!(args, "-I$include_dir")

# headers = [header for header in readdir(include_dir,join=true) if endswith(header, ".h")]
# there is also an experimental `detect_headers` function for auto-detecting top-level headers in the directory
# headers = detect_headers(clang_dir, args)

headers = detect_headers(include_dir, args)
# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)