# Prologue file
# libaeron = joinpath(@__DIR__, "../artifact/lib/libaeron.so")

INT64_C = Int64
UINT8_C = UInt8
UINT16_C = UInt16
UINT32_C = UInt32
INT64_MAX = typemax(INT64_C)

__declspec = (args...)->nothing
dllimport = nothing
offsetof = (args...)->nothing
registration_id = type_id = free_for_reuse_deadline_ms  = key = label = nothing

AERON_ALIGN(value, alignment) = (((value) + ((alignment) - 0x01)) & ~((alignment) - 0x01))