using Aeron

using OnlineStats

conf = AeronConfig1(
    channel="aeron:ipc",
    stream=1001,
)

function speedtest(conf)

    delays=fill(Float64(-1), 10000)
    i = Ref(1)
    try 
        Aeron.subscribe(conf) do header, buffer
            buffer64 = reinterpret(Float64, buffer)
            tsent = buffer64[1]
            tnow = time()
            diff = (tnow - tsent)
            # @info "Message received" diff_ns
            # fit!(q, diff_ns)
            delays[i[]] = diff

            i[] = i[] + 1

            if i[] > length(delays)
                error()
            end

            return true
        end
    catch 
    end

    return delays
end
# q = speedtest(conf)
