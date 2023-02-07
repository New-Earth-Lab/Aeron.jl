# Prologue file
AeronClient = joinpath(@__DIR__, "artifact/libaeron.so")

INT64_C = Int64
INT64_MAX = typemax(INT64_C)

using Clang
offsetof = Clang.LibClang.clang_Type_getOffsetOf