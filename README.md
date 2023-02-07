# Aeron.jl
Julia wrappers for the Aeron IPC library


A .NET port of the Aeron Client.

Aeron is an efficient reliable UDP unicast, UDP multicast, and IPC message transport.

Performance is the key focus. Aeron is designed to have the highest throughput with the lowest and most predictable latency possible of any messaging system. Aeron is designed not to perform any allocations after the initial set-up, this means less time will be spent garbage collecting and as a result, latency will be kept down.
