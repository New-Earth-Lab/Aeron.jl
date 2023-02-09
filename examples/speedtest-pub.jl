using Aeron

conf = AeronConfig1(
    channel="aeron:ipc",
    stream=1001,
)

Aeron.publisher(conf) do pub
    buffer64 = zeros(Float64, 1)
    buffer8 = reinterpret(UInt8, buffer64)
    # for i in 1:1000
    # for i in 1:1000
    while true
        # t = time_ns()
        t = time()
        buffer64[] = t
        status = Aeron.publication_offer(pub, buffer8)
        sleep(0.001)
    end
end
