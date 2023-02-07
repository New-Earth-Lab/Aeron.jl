module LibAeronClient

# Prologue file
AeronClient = joinpath(@__DIR__, "artifact/libaeron.so")

INT64_C = Int64
INT64_MAX = typemax(INT64_C)

using Clang
offsetof = Clang.LibClang.clang_Type_getOffsetOf

const __socklen_t = Cuint

const pthread_t = Culong

struct __pthread_internal_list
    __prev::Ptr{__pthread_internal_list}
    __next::Ptr{__pthread_internal_list}
end

const __pthread_list_t = __pthread_internal_list

struct pthread_mutex_t
    data::NTuple{40, UInt8}
end

function Base.getproperty(x::Ptr{pthread_mutex_t}, f::Symbol)
    f === :__data && return Ptr{__pthread_mutex_s}(x + 0)
    f === :__size && return Ptr{NTuple{40, Cchar}}(x + 0)
    f === :__align && return Ptr{Clong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::pthread_mutex_t, f::Symbol)
    r = Ref{pthread_mutex_t}(x)
    ptr = Base.unsafe_convert(Ptr{pthread_mutex_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{pthread_mutex_t}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const socklen_t = __socklen_t

const sa_family_t = Cushort

struct sockaddr
    sa_family::sa_family_t
    sa_data::NTuple{14, Cchar}
end

struct sockaddr_storage
    ss_family::sa_family_t
    __ss_align::Culong
    __ss_padding::NTuple{112, Cchar}
end

struct addrinfo
    ai_flags::Cint
    ai_family::Cint
    ai_socktype::Cint
    ai_protocol::Cint
    ai_addrlen::socklen_t
    ai_addr::Ptr{sockaddr}
    ai_canonname::Cstring
    ai_next::Ptr{addrinfo}
end

struct var"##Ctag#7686"
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#7686"}, f::Symbol)
    f === :ifu_broadaddr && return Ptr{Ptr{sockaddr}}(x + 0)
    f === :ifu_dstaddr && return Ptr{Ptr{sockaddr}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#7686", f::Symbol)
    r = Ref{var"##Ctag#7686"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#7686"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#7686"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ifaddrs
    data::NTuple{56, UInt8}
end

function Base.getproperty(x::Ptr{ifaddrs}, f::Symbol)
    f === :ifa_next && return Ptr{Ptr{ifaddrs}}(x + 0)
    f === :ifa_name && return Ptr{Cstring}(x + 8)
    f === :ifa_flags && return Ptr{Cuint}(x + 16)
    f === :ifa_addr && return Ptr{Ptr{sockaddr}}(x + 24)
    f === :ifa_netmask && return Ptr{Ptr{sockaddr}}(x + 32)
    f === :ifa_ifu && return Ptr{var"##Ctag#7686"}(x + 40)
    f === :ifa_data && return Ptr{Ptr{Cvoid}}(x + 48)
    return getfield(x, f)
end

function Base.getproperty(x::ifaddrs, f::Symbol)
    r = Ref{ifaddrs}(x)
    ptr = Base.unsafe_convert(Ptr{ifaddrs}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{ifaddrs}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct aeron_counter_value_descriptor_stct
    data::NTuple{128, UInt8}
end

function Base.getproperty(x::Ptr{aeron_counter_value_descriptor_stct}, f::Symbol)
    f === :counter_value && return Ptr{Int64}(x + 0)
    f === :registration_id && return Ptr{Int64}(x + 8)
    f === :owner_id && return Ptr{Int64}(x + 16)
    f === :pad1 && return Ptr{NTuple{104, UInt8}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_counter_value_descriptor_stct, f::Symbol)
    r = Ref{aeron_counter_value_descriptor_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_counter_value_descriptor_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_counter_value_descriptor_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_counter_value_descriptor_t = aeron_counter_value_descriptor_stct

struct aeron_counter_metadata_descriptor_stct
    data::NTuple{512, UInt8}
end

function Base.getproperty(x::Ptr{aeron_counter_metadata_descriptor_stct}, f::Symbol)
    f === :state && return Ptr{Int32}(x + 0)
    f === :type_id && return Ptr{Int32}(x + 4)
    f === :free_for_reuse_deadline_ms && return Ptr{Int64}(x + 8)
    f === :key && return Ptr{NTuple{112, UInt8}}(x + 16)
    f === :label_length && return Ptr{Int32}(x + 128)
    f === :label && return Ptr{NTuple{380, UInt8}}(x + 132)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_counter_metadata_descriptor_stct, f::Symbol)
    r = Ref{aeron_counter_metadata_descriptor_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_counter_metadata_descriptor_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_counter_metadata_descriptor_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_counter_metadata_descriptor_t = aeron_counter_metadata_descriptor_stct

struct aeron_error_log_entry_stct
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{aeron_error_log_entry_stct}, f::Symbol)
    f === :length && return Ptr{Int32}(x + 0)
    f === :observation_count && return Ptr{Int32}(x + 4)
    f === :last_observation_timestamp && return Ptr{Int64}(x + 8)
    f === :first_observation_timestamp && return Ptr{Int64}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_error_log_entry_stct, f::Symbol)
    r = Ref{aeron_error_log_entry_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_error_log_entry_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_error_log_entry_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_error_log_entry_t = aeron_error_log_entry_stct

function aeron_alloc_no_err(ptr, size)
    @ccall AeronClient.aeron_alloc_no_err(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::Cint
end

function aeron_alloc(ptr, size)
    @ccall AeronClient.aeron_alloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::Cint
end

function aeron_alloc_aligned(ptr, offset, size, alignment)
    @ccall AeronClient.aeron_alloc_aligned(ptr::Ptr{Ptr{Cvoid}}, offset::Ptr{Csize_t}, size::Csize_t, alignment::Csize_t)::Cint
end

function aeron_reallocf(ptr, size)
    @ccall AeronClient.aeron_reallocf(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::Cint
end

function aeron_free(ptr)
    @ccall AeronClient.aeron_free(ptr::Ptr{Cvoid})::Cvoid
end

# typedef void ( * aeron_error_handler_t ) ( void * clientd , int errcode , const char * message )
const aeron_error_handler_t = Ptr{Cvoid}

# typedef void ( * aeron_on_new_publication_t ) ( void * clientd , aeron_async_add_publication_t * async , const char * channel , int32_t stream_id , int32_t session_id , int64_t correlation_id )
const aeron_on_new_publication_t = Ptr{Cvoid}

# typedef void ( * aeron_on_new_subscription_t ) ( void * clientd , aeron_async_add_subscription_t * async , const char * channel , int32_t stream_id , int64_t correlation_id )
const aeron_on_new_subscription_t = Ptr{Cvoid}

# typedef void ( * aeron_on_available_image_t ) ( void * clientd , aeron_subscription_t * subscription , aeron_image_t * image )
const aeron_on_available_image_t = Ptr{Cvoid}

# typedef void ( * aeron_on_unavailable_image_t ) ( void * clientd , aeron_subscription_t * subscription , aeron_image_t * image )
const aeron_on_unavailable_image_t = Ptr{Cvoid}

# typedef void ( * aeron_on_available_counter_t ) ( void * clientd , aeron_counters_reader_t * counters_reader , int64_t registration_id , int32_t counter_id )
const aeron_on_available_counter_t = Ptr{Cvoid}

# typedef void ( * aeron_on_unavailable_counter_t ) ( void * clientd , aeron_counters_reader_t * counters_reader , int64_t registration_id , int32_t counter_id )
const aeron_on_unavailable_counter_t = Ptr{Cvoid}

# typedef void ( * aeron_agent_on_start_func_t ) ( void * state , const char * role_name )
const aeron_agent_on_start_func_t = Ptr{Cvoid}

# typedef void ( * aeron_on_close_client_t ) ( void * clientd )
const aeron_on_close_client_t = Ptr{Cvoid}

# typedef void ( * aeron_idle_strategy_func_t ) ( void * state , int work_count )
const aeron_idle_strategy_func_t = Ptr{Cvoid}

# typedef int64_t ( * aeron_clock_func_t ) ( void )
const aeron_clock_func_t = Ptr{Cvoid}

struct aeron_mapped_file_stct
    addr::Ptr{Cvoid}
    length::Csize_t
end

const aeron_mapped_file_t = aeron_mapped_file_stct

struct var"##Ctag#7687"
    tail::UInt64
    head_cache::UInt64
    shared_head_cache::UInt64
    padding::NTuple{40, Int8}
end
function Base.getproperty(x::Ptr{var"##Ctag#7687"}, f::Symbol)
    f === :tail && return Ptr{UInt64}(x + 0)
    f === :head_cache && return Ptr{UInt64}(x + 8)
    f === :shared_head_cache && return Ptr{UInt64}(x + 16)
    f === :padding && return Ptr{NTuple{40, Int8}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#7687", f::Symbol)
    r = Ref{var"##Ctag#7687"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#7687"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#7687"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#7688"
    head::UInt64
    padding::NTuple{56, Int8}
end
function Base.getproperty(x::Ptr{var"##Ctag#7688"}, f::Symbol)
    f === :head && return Ptr{UInt64}(x + 0)
    f === :padding && return Ptr{NTuple{56, Int8}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#7688", f::Symbol)
    r = Ref{var"##Ctag#7688"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#7688"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#7688"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct aeron_mpsc_concurrent_array_queue_stct
    data::NTuple{208, UInt8}
end

function Base.getproperty(x::Ptr{aeron_mpsc_concurrent_array_queue_stct}, f::Symbol)
    f === :padding && return Ptr{NTuple{56, Int8}}(x + 0)
    f === :producer && return Ptr{var"##Ctag#7687"}(x + 56)
    f === :consumer && return Ptr{var"##Ctag#7690"}(x + 120)
    f === :capacity && return Ptr{Csize_t}(x + 184)
    f === :mask && return Ptr{Csize_t}(x + 192)
    f === :buffer && return Ptr{Ptr{Ptr{Cvoid}}}(x + 200)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_mpsc_concurrent_array_queue_stct, f::Symbol)
    r = Ref{aeron_mpsc_concurrent_array_queue_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_mpsc_concurrent_array_queue_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_mpsc_concurrent_array_queue_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_mpsc_concurrent_array_queue_t = aeron_mpsc_concurrent_array_queue_stct

struct aeron_context_stct
    aeron_dir::Cstring
    error_handler::aeron_error_handler_t
    error_handler_clientd::Ptr{Cvoid}
    on_new_publication::aeron_on_new_publication_t
    on_new_publication_clientd::Ptr{Cvoid}
    on_new_exclusive_publication::aeron_on_new_publication_t
    on_new_exclusive_publication_clientd::Ptr{Cvoid}
    on_new_subscription::aeron_on_new_subscription_t
    on_new_subscription_clientd::Ptr{Cvoid}
    on_available_image::aeron_on_available_image_t
    on_available_image_clientd::Ptr{Cvoid}
    on_unavailable_image::aeron_on_unavailable_image_t
    on_unavailable_image_clientd::Ptr{Cvoid}
    on_available_counter::aeron_on_available_counter_t
    on_available_counter_clientd::Ptr{Cvoid}
    on_unavailable_counter::aeron_on_unavailable_counter_t
    on_unavailable_counter_clientd::Ptr{Cvoid}
    agent_on_start_func::aeron_agent_on_start_func_t
    agent_on_start_state::Ptr{Cvoid}
    on_close_client::aeron_on_close_client_t
    on_close_client_clientd::Ptr{Cvoid}
    idle_strategy_func::aeron_idle_strategy_func_t
    idle_strategy_state::Ptr{Cvoid}
    driver_timeout_ms::UInt64
    keepalive_interval_ns::UInt64
    resource_linger_duration_ns::UInt64
    use_conductor_agent_invoker::Bool
    pre_touch_mapped_memory::Bool
    nano_clock::aeron_clock_func_t
    epoch_clock::aeron_clock_func_t
    cnc_map::aeron_mapped_file_t
    command_queue::aeron_mpsc_concurrent_array_queue_t
end

const aeron_context_t = aeron_context_stct

struct aeron_broadcast_descriptor_stct
    data::NTuple{128, UInt8}
end

function Base.getproperty(x::Ptr{aeron_broadcast_descriptor_stct}, f::Symbol)
    f === :tail_intent_counter && return Ptr{Int64}(x + 0)
    f === :tail_counter && return Ptr{Int64}(x + 8)
    f === :latest_counter && return Ptr{Int64}(x + 16)
    f === :pad && return Ptr{NTuple{104, UInt8}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_broadcast_descriptor_stct, f::Symbol)
    r = Ref{aeron_broadcast_descriptor_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_broadcast_descriptor_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_broadcast_descriptor_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_broadcast_descriptor_t = aeron_broadcast_descriptor_stct

struct aeron_broadcast_receiver_stct
    scratch_buffer::NTuple{4096, UInt8}
    buffer::Ptr{UInt8}
    descriptor::Ptr{aeron_broadcast_descriptor_t}
    capacity::Csize_t
    mask::Csize_t
    record_offset::Csize_t
    cursor::Int64
    next_record::Int64
    lapped_count::Clong
end

const aeron_broadcast_receiver_t = aeron_broadcast_receiver_stct

struct aeron_rb_descriptor_stct
    data::NTuple{768, UInt8}
end

function Base.getproperty(x::Ptr{aeron_rb_descriptor_stct}, f::Symbol)
    f === :begin_pad && return Ptr{NTuple{128, UInt8}}(x + 0)
    f === :tail_position && return Ptr{Int64}(x + 128)
    f === :tail_pad && return Ptr{NTuple{120, UInt8}}(x + 136)
    f === :head_cache_position && return Ptr{Int64}(x + 256)
    f === :head_cache_pad && return Ptr{NTuple{120, UInt8}}(x + 264)
    f === :head_position && return Ptr{Int64}(x + 384)
    f === :head_pad && return Ptr{NTuple{120, UInt8}}(x + 392)
    f === :correlation_counter && return Ptr{Int64}(x + 512)
    f === :correlation_counter_pad && return Ptr{NTuple{120, UInt8}}(x + 520)
    f === :consumer_heartbeat && return Ptr{Int64}(x + 640)
    f === :consumer_heartbeat_pad && return Ptr{NTuple{120, UInt8}}(x + 648)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_rb_descriptor_stct, f::Symbol)
    r = Ref{aeron_rb_descriptor_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_rb_descriptor_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_rb_descriptor_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_rb_descriptor_t = aeron_rb_descriptor_stct

struct aeron_mpsc_rb_stct
    buffer::Ptr{UInt8}
    descriptor::Ptr{aeron_rb_descriptor_t}
    capacity::Csize_t
    max_message_length::Csize_t
end

const aeron_mpsc_rb_t = aeron_mpsc_rb_stct

struct aeron_counters_reader_stct
    values::Ptr{UInt8}
    metadata::Ptr{UInt8}
    values_length::Csize_t
    metadata_length::Csize_t
    max_counter_id::Int32
end

const aeron_counters_reader_t = aeron_counters_reader_stct

struct aeron_int64_to_ptr_hash_map_stct
    keys::Ptr{Int64}
    values::Ptr{Ptr{Cvoid}}
    load_factor::Cfloat
    capacity::Csize_t
    size::Csize_t
    resize_threshold::Csize_t
end

const aeron_int64_to_ptr_hash_map_t = aeron_int64_to_ptr_hash_map_stct

struct aeron_on_available_counter_pair_stct
    handler::aeron_on_available_counter_t
    clientd::Ptr{Cvoid}
end

const aeron_on_available_counter_pair_t = aeron_on_available_counter_pair_stct

struct available_counter_handlers_stct
    length::Csize_t
    capacity::Csize_t
    array::Ptr{aeron_on_available_counter_pair_t}
end

struct aeron_on_unavailable_counter_pair_stct
    handler::aeron_on_unavailable_counter_t
    clientd::Ptr{Cvoid}
end

const aeron_on_unavailable_counter_pair_t = aeron_on_unavailable_counter_pair_stct

struct unavailable_counter_handlers_stct
    length::Csize_t
    capacity::Csize_t
    array::Ptr{aeron_on_unavailable_counter_pair_t}
end

struct aeron_on_close_client_pair_stct
    handler::aeron_on_close_client_t
    clientd::Ptr{Cvoid}
end

const aeron_on_close_client_pair_t = aeron_on_close_client_pair_stct

struct close_handlers_stct
    length::Csize_t
    capacity::Csize_t
    array::Ptr{aeron_on_close_client_pair_t}
end

struct aeron_client_managed_resource_un
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_client_managed_resource_un}, f::Symbol)
    f === :publication && return Ptr{Ptr{aeron_publication_t}}(x + 0)
    f === :exclusive_publication && return Ptr{Ptr{aeron_exclusive_publication_t}}(x + 0)
    f === :subscription && return Ptr{Ptr{aeron_subscription_t}}(x + 0)
    f === :image && return Ptr{Ptr{aeron_image_t}}(x + 0)
    f === :counter && return Ptr{Ptr{aeron_counter_t}}(x + 0)
    f === :log_buffer && return Ptr{Ptr{aeron_log_buffer_t}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_client_managed_resource_un, f::Symbol)
    r = Ref{aeron_client_managed_resource_un}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_client_managed_resource_un}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_client_managed_resource_un}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

@enum aeron_client_managed_resource_type_en::UInt32 begin
    AERON_CLIENT_TYPE_PUBLICATION = 0
    AERON_CLIENT_TYPE_EXCLUSIVE_PUBLICATION = 1
    AERON_CLIENT_TYPE_SUBSCRIPTION = 2
    AERON_CLIENT_TYPE_IMAGE = 3
    AERON_CLIENT_TYPE_LOGBUFFER = 4
    AERON_CLIENT_TYPE_COUNTER = 5
    AERON_CLIENT_TYPE_DESTINATION = 6
end

const aeron_client_managed_resource_type_t = aeron_client_managed_resource_type_en

struct aeron_client_managed_resource_stct
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{aeron_client_managed_resource_stct}, f::Symbol)
    f === :resource && return Ptr{aeron_client_managed_resource_un}(x + 0)
    f === :type && return Ptr{aeron_client_managed_resource_type_t}(x + 8)
    f === :time_of_last_state_change_ns && return Ptr{Clonglong}(x + 16)
    f === :registration_id && return Ptr{Int64}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_client_managed_resource_stct, f::Symbol)
    r = Ref{aeron_client_managed_resource_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_client_managed_resource_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_client_managed_resource_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_client_managed_resource_t = aeron_client_managed_resource_stct

struct lingering_resources_stct
    length::Csize_t
    capacity::Csize_t
    array::Ptr{aeron_client_managed_resource_t}
end

struct aeron_client_command_base_stct
    func::Ptr{Cvoid}
    item::Ptr{Cvoid}
    type::aeron_client_managed_resource_type_t
end

const aeron_client_command_base_t = aeron_client_command_base_stct

struct aeron_client_registering_resource_un
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_client_registering_resource_un}, f::Symbol)
    f === :publication && return Ptr{Ptr{aeron_publication_t}}(x + 0)
    f === :exclusive_publication && return Ptr{Ptr{aeron_exclusive_publication_t}}(x + 0)
    f === :subscription && return Ptr{Ptr{aeron_subscription_t}}(x + 0)
    f === :counter && return Ptr{Ptr{aeron_counter_t}}(x + 0)
    f === :base_resource && return Ptr{Ptr{aeron_client_command_base_t}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_client_registering_resource_un, f::Symbol)
    r = Ref{aeron_client_registering_resource_un}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_client_registering_resource_un}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_client_registering_resource_un}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct aeron_client_registering_counter_stct
    key_buffer::Ptr{UInt8}
    label_buffer::Cstring
    key_buffer_length::UInt64
    label_buffer_length::UInt64
    type_id::Int32
end

@enum aeron_client_registration_status_en::UInt32 begin
    AERON_CLIENT_AWAITING_MEDIA_DRIVER = 0
    AERON_CLIENT_REGISTERED_MEDIA_DRIVER = 1
    AERON_CLIENT_ERRORED_MEDIA_DRIVER = 2
    AERON_CLIENT_TIMEOUT_MEDIA_DRIVER = 3
end

const aeron_client_registration_status_t = aeron_client_registration_status_en

struct aeron_client_registering_resource_stct
    data::NTuple{160, UInt8}
end

function Base.getproperty(x::Ptr{aeron_client_registering_resource_stct}, f::Symbol)
    f === :command_base && return Ptr{aeron_client_command_base_t}(x + 0)
    f === :resource && return Ptr{aeron_client_registering_resource_un}(x + 24)
    f === :on_available_image && return Ptr{aeron_on_available_image_t}(x + 32)
    f === :on_available_image_clientd && return Ptr{Ptr{Cvoid}}(x + 40)
    f === :on_unavailable_image && return Ptr{aeron_on_unavailable_image_t}(x + 48)
    f === :on_unavailable_image_clientd && return Ptr{Ptr{Cvoid}}(x + 56)
    f === :error_message && return Ptr{Cstring}(x + 64)
    f === :uri && return Ptr{Cstring}(x + 72)
    f === :registration_id && return Ptr{Int64}(x + 80)
    f === :registration_deadline_ns && return Ptr{Clonglong}(x + 88)
    f === :error_code && return Ptr{Int32}(x + 96)
    f === :error_message_length && return Ptr{Int32}(x + 100)
    f === :uri_length && return Ptr{Int32}(x + 104)
    f === :stream_id && return Ptr{Int32}(x + 108)
    f === :counter && return Ptr{aeron_client_registering_counter_stct}(x + 112)
    f === :registration_status && return Ptr{aeron_client_registration_status_t}(x + 152)
    f === :type && return Ptr{aeron_client_managed_resource_type_t}(x + 156)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_client_registering_resource_stct, f::Symbol)
    r = Ref{aeron_client_registering_resource_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_client_registering_resource_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_client_registering_resource_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_client_registering_resource_t = aeron_client_registering_resource_stct

struct aeron_client_registering_resource_entry_stct
    resource::Ptr{aeron_client_registering_resource_t}
end

const aeron_client_registering_resource_entry_t = aeron_client_registering_resource_entry_stct

struct registering_resources_stct
    length::Csize_t
    capacity::Csize_t
    array::Ptr{aeron_client_registering_resource_entry_t}
end

struct heartbeat_timestamp_stct
    addr::Ptr{Int64}
    counter_id::Int32
end

struct aeron_client_conductor_stct
    to_client_buffer::aeron_broadcast_receiver_t
    to_driver_buffer::aeron_mpsc_rb_t
    counters_reader::aeron_counters_reader_t
    log_buffer_by_id_map::aeron_int64_to_ptr_hash_map_t
    resource_by_id_map::aeron_int64_to_ptr_hash_map_t
    image_by_id_map::aeron_int64_to_ptr_hash_map_t
    available_counter_handlers::available_counter_handlers_stct
    unavailable_counter_handlers::unavailable_counter_handlers_stct
    close_handlers::close_handlers_stct
    lingering_resources::lingering_resources_stct
    registering_resources::registering_resources_stct
    heartbeat_timestamp::heartbeat_timestamp_stct
    command_queue::Ptr{aeron_mpsc_concurrent_array_queue_t}
    driver_timeout_ms::UInt64
    driver_timeout_ns::UInt64
    inter_service_timeout_ns::UInt64
    keepalive_interval_ns::UInt64
    resource_linger_duration_ns::UInt64
    time_of_last_service_ns::Clonglong
    time_of_last_keepalive_ns::Clonglong
    client_id::Int64
    error_handler::aeron_error_handler_t
    error_handler_clientd::Ptr{Cvoid}
    on_new_publication::aeron_on_new_publication_t
    on_new_publication_clientd::Ptr{Cvoid}
    on_new_exclusive_publication::aeron_on_new_publication_t
    on_new_exclusive_publication_clientd::Ptr{Cvoid}
    on_new_subscription::aeron_on_new_subscription_t
    on_new_subscription_clientd::Ptr{Cvoid}
    nano_clock::aeron_clock_func_t
    epoch_clock::aeron_clock_func_t
    invoker_mode::Bool
    pre_touch::Bool
    is_terminating::Bool
    is_closed::Bool
end

const aeron_client_conductor_t = aeron_client_conductor_stct

# typedef int ( * aeron_agent_do_work_func_t ) ( void * )
const aeron_agent_do_work_func_t = Ptr{Cvoid}

# typedef void ( * aeron_agent_on_close_func_t ) ( void * )
const aeron_agent_on_close_func_t = Ptr{Cvoid}

const aeron_thread_t = pthread_t

struct aeron_agent_runner_stct
    role_name::Cstring
    agent_state::Ptr{Cvoid}
    idle_strategy_state::Ptr{Cvoid}
    on_start_state::Ptr{Cvoid}
    on_start::aeron_agent_on_start_func_t
    do_work::aeron_agent_do_work_func_t
    on_close::aeron_agent_on_close_func_t
    idle_strategy::aeron_idle_strategy_func_t
    thread::aeron_thread_t
    running::Bool
    state::UInt8
end

const aeron_agent_runner_t = aeron_agent_runner_stct

struct aeron_stct
    conductor::aeron_client_conductor_t
    runner::aeron_agent_runner_t
    context::Ptr{aeron_context_t}
end

const aeron_t = aeron_stct

struct aeron_buffer_claim_stct
    frame_header::Ptr{UInt8}
    data::Ptr{UInt8}
    length::Csize_t
end

const aeron_buffer_claim_t = aeron_buffer_claim_stct

struct aeron_mapped_buffer_stct
    addr::Ptr{UInt8}
    length::Csize_t
end

const aeron_mapped_buffer_t = aeron_mapped_buffer_stct

struct aeron_mapped_raw_log_stct
    term_buffers::NTuple{3, aeron_mapped_buffer_t}
    log_meta_data::aeron_mapped_buffer_t
    mapped_file::aeron_mapped_file_t
    term_length::Csize_t
end

const aeron_mapped_raw_log_t = aeron_mapped_raw_log_stct

struct aeron_log_buffer_stct
    mapped_raw_log::aeron_mapped_raw_log_t
    correlation_id::Int64
    refcnt::Int64
end

const aeron_log_buffer_t = aeron_log_buffer_stct

struct aeron_logbuffer_metadata_stct
    data::NTuple{320, UInt8}
end

function Base.getproperty(x::Ptr{aeron_logbuffer_metadata_stct}, f::Symbol)
    f === :term_tail_counters && return Ptr{NTuple{3, Int64}}(x + 0)
    f === :active_term_count && return Ptr{Int32}(x + 24)
    f === :pad1 && return Ptr{NTuple{100, UInt8}}(x + 28)
    f === :end_of_stream_position && return Ptr{Int64}(x + 128)
    f === :is_connected && return Ptr{Int32}(x + 136)
    f === :active_transport_count && return Ptr{Int32}(x + 140)
    f === :pad2 && return Ptr{NTuple{112, UInt8}}(x + 144)
    f === :correlation_id && return Ptr{Int64}(x + 256)
    f === :initial_term_id && return Ptr{Int32}(x + 264)
    f === :default_frame_header_length && return Ptr{Int32}(x + 268)
    f === :mtu_length && return Ptr{Int32}(x + 272)
    f === :term_length && return Ptr{Int32}(x + 276)
    f === :page_size && return Ptr{Int32}(x + 280)
    f === :pad3 && return Ptr{NTuple{36, UInt8}}(x + 284)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_logbuffer_metadata_stct, f::Symbol)
    r = Ref{aeron_logbuffer_metadata_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_logbuffer_metadata_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_logbuffer_metadata_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_logbuffer_metadata_t = aeron_logbuffer_metadata_stct

# typedef void ( * aeron_notification_t ) ( void * clientd )
const aeron_notification_t = Ptr{Cvoid}

struct aeron_publication_stct
    command_base::aeron_client_command_base_t
    conductor::Ptr{aeron_client_conductor_t}
    channel::Cstring
    log_buffer::Ptr{aeron_log_buffer_t}
    log_meta_data::Ptr{aeron_logbuffer_metadata_t}
    position_limit::Ptr{Int64}
    channel_status_indicator::Ptr{Int64}
    registration_id::Int64
    original_registration_id::Int64
    stream_id::Int32
    session_id::Int32
    max_possible_position::Int64
    max_payload_length::Csize_t
    max_message_length::Csize_t
    position_bits_to_shift::Csize_t
    initial_term_id::Int32
    position_limit_counter_id::Int32
    channel_status_indicator_id::Int32
    on_close_complete::aeron_notification_t
    on_close_complete_clientd::Ptr{Cvoid}
    is_closed::Bool
end

const aeron_publication_t = aeron_publication_stct

struct aeron_exclusive_publication_stct
    command_base::aeron_client_command_base_t
    conductor::Ptr{aeron_client_conductor_t}
    channel::Cstring
    log_buffer::Ptr{aeron_log_buffer_t}
    log_meta_data::Ptr{aeron_logbuffer_metadata_t}
    position_limit::Ptr{Int64}
    channel_status_indicator::Ptr{Int64}
    registration_id::Int64
    original_registration_id::Int64
    stream_id::Int32
    session_id::Int32
    max_possible_position::Int64
    max_payload_length::Csize_t
    max_message_length::Csize_t
    position_bits_to_shift::Csize_t
    initial_term_id::Int32
    term_buffer_length::Int32
    position_limit_counter_id::Int32
    channel_status_indicator_id::Int32
    on_close_complete::aeron_notification_t
    on_close_complete_clientd::Ptr{Cvoid}
    is_closed::Bool
    pre_fields_padding::NTuple{64, UInt8}
    term_begin_position::Int64
    term_offset::Int32
    term_id::Int32
    active_partition_index::Csize_t
    post_fields_padding::NTuple{64, UInt8}
end

const aeron_exclusive_publication_t = aeron_exclusive_publication_stct

struct aeron_frame_header_stct
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_frame_header_stct}, f::Symbol)
    f === :frame_length && return Ptr{Int32}(x + 0)
    f === :version && return Ptr{Int8}(x + 4)
    f === :flags && return Ptr{UInt8}(x + 5)
    f === :type && return Ptr{Int16}(x + 6)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_frame_header_stct, f::Symbol)
    r = Ref{aeron_frame_header_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_frame_header_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_frame_header_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_frame_header_t = aeron_frame_header_stct

struct aeron_data_header_stct
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{aeron_data_header_stct}, f::Symbol)
    f === :frame_header && return Ptr{aeron_frame_header_t}(x + 0)
    f === :term_offset && return Ptr{Int32}(x + 8)
    f === :session_id && return Ptr{Int32}(x + 12)
    f === :stream_id && return Ptr{Int32}(x + 16)
    f === :term_id && return Ptr{Int32}(x + 20)
    f === :reserved_value && return Ptr{Int64}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_data_header_stct, f::Symbol)
    r = Ref{aeron_data_header_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_data_header_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_data_header_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_data_header_t = aeron_data_header_stct

struct aeron_header_stct
    frame::Ptr{aeron_data_header_t}
    initial_term_id::Int32
    position_bits_to_shift::Csize_t
end

const aeron_header_t = aeron_header_stct

struct aeron_header_values_frame_stct
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{aeron_header_values_frame_stct}, f::Symbol)
    f === :frame_length && return Ptr{Int32}(x + 0)
    f === :version && return Ptr{Int8}(x + 4)
    f === :flags && return Ptr{UInt8}(x + 5)
    f === :type && return Ptr{Int16}(x + 6)
    f === :term_offset && return Ptr{Int32}(x + 8)
    f === :session_id && return Ptr{Int32}(x + 12)
    f === :stream_id && return Ptr{Int32}(x + 16)
    f === :term_id && return Ptr{Int32}(x + 20)
    f === :reserved_value && return Ptr{Int64}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_header_values_frame_stct, f::Symbol)
    r = Ref{aeron_header_values_frame_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_header_values_frame_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_header_values_frame_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_header_values_frame_t = aeron_header_values_frame_stct

struct aeron_header_values_stct
    data::NTuple{44, UInt8}
end

function Base.getproperty(x::Ptr{aeron_header_values_stct}, f::Symbol)
    f === :frame && return Ptr{aeron_header_values_frame_t}(x + 0)
    f === :initial_term_id && return Ptr{Int32}(x + 32)
    f === :position_bits_to_shift && return Ptr{Csize_t}(x + 36)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_header_values_stct, f::Symbol)
    r = Ref{aeron_header_values_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_header_values_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_header_values_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_header_values_t = aeron_header_values_stct

struct aeron_image_list_stct
    change_number::Int64
    length::UInt32
    next_list::Ptr{aeron_image_list_stct}
    array::Ptr{Ptr{Cvoid}} # array::Ptr{Ptr{aeron_image_t}}
end

function Base.getproperty(x::aeron_image_list_stct, f::Symbol)
    f === :array && return Ptr{Ptr{aeron_image_t}}(getfield(x, f))
    return getfield(x, f)
end

const aeron_image_list_t = aeron_image_list_stct

struct subscription_conductor_fields_stct
    pre_fields_padding::NTuple{64, UInt8}
    image_lists_head::aeron_image_list_t
    next_change_number::Int64
    post_fields_padding::NTuple{64, UInt8}
end

struct aeron_subscription_stct
    command_base::aeron_client_command_base_t
    conductor::Ptr{aeron_client_conductor_t}
    channel::Cstring
    conductor_fields::subscription_conductor_fields_stct
    channel_status_indicator::Ptr{Int64}
    last_image_list_change_number::Int64
    on_available_image::aeron_on_available_image_t
    on_available_image_clientd::Ptr{Cvoid}
    on_unavailable_image::aeron_on_unavailable_image_t
    on_unavailable_image_clientd::Ptr{Cvoid}
    on_close_complete::aeron_notification_t
    on_close_complete_clientd::Ptr{Cvoid}
    registration_id::Int64
    stream_id::Int32
    channel_status_indicator_id::Int32
    round_robin_index::Csize_t
    is_closed::Bool
    post_fields_padding::NTuple{64, UInt8}
end

const aeron_subscription_t = aeron_subscription_stct

struct aeron_image_stct
    command_base::aeron_client_command_base_t
    conductor::Ptr{aeron_client_conductor_t}
    source_identity::Cstring
    subscription::Ptr{aeron_subscription_t}
    log_buffer::Ptr{aeron_log_buffer_t}
    metadata::Ptr{aeron_logbuffer_metadata_t}
    subscriber_position::Ptr{Cvoid} # subscriber_position::Ptr{Int64}
    correlation_id::Int64
    removal_change_number::Int64
    join_position::Int64
    final_position::Int64
    refcnt::Int64
    session_id::Int32
    term_length_mask::Int32
    subscriber_position_id::Int32
    position_bits_to_shift::Csize_t
    is_closed::Bool
    is_eos::Bool
    is_lingering::Bool
end

function Base.getproperty(x::aeron_image_stct, f::Symbol)
    f === :subscriber_position && return Ptr{Int64}(getfield(x, f))
    return getfield(x, f)
end

const aeron_image_t = aeron_image_stct

struct aeron_counter_stct
    command_base::aeron_client_command_base_t
    conductor::Ptr{aeron_client_conductor_t}
    counter_addr::Ptr{Int64}
    registration_id::Int64
    counter_id::Int32
    on_close_complete::aeron_notification_t
    on_close_complete_clientd::Ptr{Cvoid}
    is_closed::Bool
end

const aeron_counter_t = aeron_counter_stct

const aeron_async_add_publication_t = aeron_client_registering_resource_stct

const aeron_async_add_exclusive_publication_t = aeron_client_registering_resource_stct

const aeron_async_add_subscription_t = aeron_client_registering_resource_stct

const aeron_async_add_counter_t = aeron_client_registering_resource_stct

const aeron_async_destination_t = aeron_client_registering_resource_stct

# typedef void ( * aeron_fragment_handler_t ) ( void * clientd , const uint8_t * buffer , size_t length , aeron_header_t * header )
const aeron_fragment_handler_t = Ptr{Cvoid}

struct aeron_buffer_builder_stct
    buffer::Ptr{UInt8}
    buffer_length::Csize_t
    limit::Csize_t
    next_term_offset::Int32
end

const aeron_buffer_builder_t = aeron_buffer_builder_stct

struct aeron_image_fragment_assembler_stct
    delegate::aeron_fragment_handler_t
    delegate_clientd::Ptr{Cvoid}
    buffer_builder::Ptr{aeron_buffer_builder_t}
end

const aeron_image_fragment_assembler_t = aeron_image_fragment_assembler_stct

# typedef aeron_controlled_fragment_handler_action_t ( * aeron_controlled_fragment_handler_t ) ( void * clientd , const uint8_t * buffer , size_t length , aeron_header_t * header )
const aeron_controlled_fragment_handler_t = Ptr{Cvoid}

struct aeron_image_controlled_fragment_assembler_stct
    delegate::aeron_controlled_fragment_handler_t
    delegate_clientd::Ptr{Cvoid}
    buffer_builder::Ptr{aeron_buffer_builder_t}
end

const aeron_image_controlled_fragment_assembler_t = aeron_image_controlled_fragment_assembler_stct

struct aeron_fragment_assembler_stct
    delegate::aeron_fragment_handler_t
    delegate_clientd::Ptr{Cvoid}
    builder_by_session_id_map::aeron_int64_to_ptr_hash_map_t
end

const aeron_fragment_assembler_t = aeron_fragment_assembler_stct

struct aeron_controlled_fragment_assembler_stct
    delegate::aeron_controlled_fragment_handler_t
    delegate_clientd::Ptr{Cvoid}
    builder_by_session_id_map::aeron_int64_to_ptr_hash_map_t
end

const aeron_controlled_fragment_assembler_t = aeron_controlled_fragment_assembler_stct

function aeron_context_set_dir(context, value)
    @ccall AeronClient.aeron_context_set_dir(context::Ptr{aeron_context_t}, value::Cstring)::Cint
end

function aeron_context_get_dir(context)
    @ccall AeronClient.aeron_context_get_dir(context::Ptr{aeron_context_t})::Cstring
end

function aeron_context_set_driver_timeout_ms(context, value)
    @ccall AeronClient.aeron_context_set_driver_timeout_ms(context::Ptr{aeron_context_t}, value::UInt64)::Cint
end

function aeron_context_get_driver_timeout_ms(context)
    @ccall AeronClient.aeron_context_get_driver_timeout_ms(context::Ptr{aeron_context_t})::UInt64
end

function aeron_context_set_keepalive_interval_ns(context, value)
    @ccall AeronClient.aeron_context_set_keepalive_interval_ns(context::Ptr{aeron_context_t}, value::UInt64)::Cint
end

function aeron_context_get_keepalive_interval_ns(context)
    @ccall AeronClient.aeron_context_get_keepalive_interval_ns(context::Ptr{aeron_context_t})::UInt64
end

function aeron_context_set_resource_linger_duration_ns(context, value)
    @ccall AeronClient.aeron_context_set_resource_linger_duration_ns(context::Ptr{aeron_context_t}, value::UInt64)::Cint
end

function aeron_context_get_resource_linger_duration_ns(context)
    @ccall AeronClient.aeron_context_get_resource_linger_duration_ns(context::Ptr{aeron_context_t})::UInt64
end

function aeron_context_set_pre_touch_mapped_memory(context, value)
    @ccall AeronClient.aeron_context_set_pre_touch_mapped_memory(context::Ptr{aeron_context_t}, value::Bool)::Cint
end

function aeron_context_get_pre_touch_mapped_memory(context)
    @ccall AeronClient.aeron_context_get_pre_touch_mapped_memory(context::Ptr{aeron_context_t})::Bool
end

function aeron_context_set_error_handler(context, handler, clientd)
    @ccall AeronClient.aeron_context_set_error_handler(context::Ptr{aeron_context_t}, handler::aeron_error_handler_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_context_get_error_handler(context)
    @ccall AeronClient.aeron_context_get_error_handler(context::Ptr{aeron_context_t})::aeron_error_handler_t
end

function aeron_context_get_error_handler_clientd(context)
    @ccall AeronClient.aeron_context_get_error_handler_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

function aeron_context_set_on_new_publication(context, handler, clientd)
    @ccall AeronClient.aeron_context_set_on_new_publication(context::Ptr{aeron_context_t}, handler::aeron_on_new_publication_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_context_get_on_new_publication(context)
    @ccall AeronClient.aeron_context_get_on_new_publication(context::Ptr{aeron_context_t})::aeron_on_new_publication_t
end

function aeron_context_get_on_new_publication_clientd(context)
    @ccall AeronClient.aeron_context_get_on_new_publication_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

function aeron_context_set_on_new_exclusive_publication(context, handler, clientd)
    @ccall AeronClient.aeron_context_set_on_new_exclusive_publication(context::Ptr{aeron_context_t}, handler::aeron_on_new_publication_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_context_get_on_new_exclusive_publication(context)
    @ccall AeronClient.aeron_context_get_on_new_exclusive_publication(context::Ptr{aeron_context_t})::aeron_on_new_publication_t
end

function aeron_context_get_on_new_exclusive_publication_clientd(context)
    @ccall AeronClient.aeron_context_get_on_new_exclusive_publication_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

function aeron_context_set_on_new_subscription(context, handler, clientd)
    @ccall AeronClient.aeron_context_set_on_new_subscription(context::Ptr{aeron_context_t}, handler::aeron_on_new_subscription_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_context_get_on_new_subscription(context)
    @ccall AeronClient.aeron_context_get_on_new_subscription(context::Ptr{aeron_context_t})::aeron_on_new_subscription_t
end

function aeron_context_get_on_new_subscription_clientd(context)
    @ccall AeronClient.aeron_context_get_on_new_subscription_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

function aeron_context_set_on_available_counter(context, handler, clientd)
    @ccall AeronClient.aeron_context_set_on_available_counter(context::Ptr{aeron_context_t}, handler::aeron_on_available_counter_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_context_get_on_available_counter(context)
    @ccall AeronClient.aeron_context_get_on_available_counter(context::Ptr{aeron_context_t})::aeron_on_available_counter_t
end

function aeron_context_get_on_available_counter_clientd(context)
    @ccall AeronClient.aeron_context_get_on_available_counter_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

function aeron_context_set_on_unavailable_counter(context, handler, clientd)
    @ccall AeronClient.aeron_context_set_on_unavailable_counter(context::Ptr{aeron_context_t}, handler::aeron_on_unavailable_counter_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_context_get_on_unavailable_counter(context)
    @ccall AeronClient.aeron_context_get_on_unavailable_counter(context::Ptr{aeron_context_t})::aeron_on_unavailable_counter_t
end

function aeron_context_get_on_unavailable_counter_clientd(context)
    @ccall AeronClient.aeron_context_get_on_unavailable_counter_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

function aeron_context_set_on_close_client(context, handler, clientd)
    @ccall AeronClient.aeron_context_set_on_close_client(context::Ptr{aeron_context_t}, handler::aeron_on_close_client_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_context_get_on_close_client(context)
    @ccall AeronClient.aeron_context_get_on_close_client(context::Ptr{aeron_context_t})::aeron_on_close_client_t
end

function aeron_context_get_on_close_client_clientd(context)
    @ccall AeronClient.aeron_context_get_on_close_client_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

function aeron_context_set_use_conductor_agent_invoker(context, value)
    @ccall AeronClient.aeron_context_set_use_conductor_agent_invoker(context::Ptr{aeron_context_t}, value::Bool)::Cint
end

function aeron_context_get_use_conductor_agent_invoker(context)
    @ccall AeronClient.aeron_context_get_use_conductor_agent_invoker(context::Ptr{aeron_context_t})::Bool
end

function aeron_context_set_agent_on_start_function(context, value, state)
    @ccall AeronClient.aeron_context_set_agent_on_start_function(context::Ptr{aeron_context_t}, value::aeron_agent_on_start_func_t, state::Ptr{Cvoid})::Cint
end

function aeron_context_get_agent_on_start_function(context)
    @ccall AeronClient.aeron_context_get_agent_on_start_function(context::Ptr{aeron_context_t})::aeron_agent_on_start_func_t
end

function aeron_context_get_agent_on_start_state(context)
    @ccall AeronClient.aeron_context_get_agent_on_start_state(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

function aeron_context_init(context)
    @ccall AeronClient.aeron_context_init(context::Ptr{Ptr{aeron_context_t}})::Cint
end

function aeron_context_close(context)
    @ccall AeronClient.aeron_context_close(context::Ptr{aeron_context_t})::Cint
end

function aeron_init(client, context)
    @ccall AeronClient.aeron_init(client::Ptr{Ptr{aeron_t}}, context::Ptr{aeron_context_t})::Cint
end

function aeron_start(client)
    @ccall AeronClient.aeron_start(client::Ptr{aeron_t})::Cint
end

function aeron_main_do_work(client)
    @ccall AeronClient.aeron_main_do_work(client::Ptr{aeron_t})::Cint
end

function aeron_main_idle_strategy(client, work_count)
    @ccall AeronClient.aeron_main_idle_strategy(client::Ptr{aeron_t}, work_count::Cint)::Cvoid
end

function aeron_close(client)
    @ccall AeronClient.aeron_close(client::Ptr{aeron_t})::Cint
end

function aeron_is_closed(client)
    @ccall AeronClient.aeron_is_closed(client::Ptr{aeron_t})::Bool
end

function aeron_print_counters(client, stream_out)
    @ccall AeronClient.aeron_print_counters(client::Ptr{aeron_t}, stream_out::Ptr{Cvoid})::Cvoid
end

function aeron_context(client)
    @ccall AeronClient.aeron_context(client::Ptr{aeron_t})::Ptr{aeron_context_t}
end

function aeron_client_id(client)
    @ccall AeronClient.aeron_client_id(client::Ptr{aeron_t})::Int64
end

function aeron_next_correlation_id(client)
    @ccall AeronClient.aeron_next_correlation_id(client::Ptr{aeron_t})::Int64
end

function aeron_async_add_publication(async, client, uri, stream_id)
    @ccall AeronClient.aeron_async_add_publication(async::Ptr{Ptr{aeron_async_add_publication_t}}, client::Ptr{aeron_t}, uri::Cstring, stream_id::Int32)::Cint
end

function aeron_async_add_publication_poll(publication, async)
    @ccall AeronClient.aeron_async_add_publication_poll(publication::Ptr{Ptr{aeron_publication_t}}, async::Ptr{aeron_async_add_publication_t})::Cint
end

function aeron_async_add_exclusive_publication(async, client, uri, stream_id)
    @ccall AeronClient.aeron_async_add_exclusive_publication(async::Ptr{Ptr{aeron_async_add_exclusive_publication_t}}, client::Ptr{aeron_t}, uri::Cstring, stream_id::Int32)::Cint
end

function aeron_async_add_exclusive_publication_poll(publication, async)
    @ccall AeronClient.aeron_async_add_exclusive_publication_poll(publication::Ptr{Ptr{aeron_exclusive_publication_t}}, async::Ptr{aeron_async_add_exclusive_publication_t})::Cint
end

function aeron_async_add_subscription(async, client, uri, stream_id, on_available_image_handler, on_available_image_clientd, on_unavailable_image_handler, on_unavailable_image_clientd)
    @ccall AeronClient.aeron_async_add_subscription(async::Ptr{Ptr{aeron_async_add_subscription_t}}, client::Ptr{aeron_t}, uri::Cstring, stream_id::Int32, on_available_image_handler::aeron_on_available_image_t, on_available_image_clientd::Ptr{Cvoid}, on_unavailable_image_handler::aeron_on_unavailable_image_t, on_unavailable_image_clientd::Ptr{Cvoid})::Cint
end

function aeron_async_add_subscription_poll(subscription, async)
    @ccall AeronClient.aeron_async_add_subscription_poll(subscription::Ptr{Ptr{aeron_subscription_t}}, async::Ptr{aeron_async_add_subscription_t})::Cint
end

function aeron_counters_reader(client)
    @ccall AeronClient.aeron_counters_reader(client::Ptr{aeron_t})::Ptr{aeron_counters_reader_t}
end

function aeron_async_add_counter(async, client, type_id, key_buffer, key_buffer_length, label_buffer, label_buffer_length)
    @ccall AeronClient.aeron_async_add_counter(async::Ptr{Ptr{aeron_async_add_counter_t}}, client::Ptr{aeron_t}, type_id::Int32, key_buffer::Ptr{UInt8}, key_buffer_length::Csize_t, label_buffer::Cstring, label_buffer_length::Csize_t)::Cint
end

function aeron_async_add_counter_poll(counter, async)
    @ccall AeronClient.aeron_async_add_counter_poll(counter::Ptr{Ptr{aeron_counter_t}}, async::Ptr{aeron_async_add_counter_t})::Cint
end

function aeron_add_available_counter_handler(client, pair)
    @ccall AeronClient.aeron_add_available_counter_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_available_counter_pair_t})::Cint
end

function aeron_remove_available_counter_handler(client, pair)
    @ccall AeronClient.aeron_remove_available_counter_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_available_counter_pair_t})::Cint
end

function aeron_add_unavailable_counter_handler(client, pair)
    @ccall AeronClient.aeron_add_unavailable_counter_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_unavailable_counter_pair_t})::Cint
end

function aeron_remove_unavailable_counter_handler(client, pair)
    @ccall AeronClient.aeron_remove_unavailable_counter_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_unavailable_counter_pair_t})::Cint
end

function aeron_add_close_handler(client, pair)
    @ccall AeronClient.aeron_add_close_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_close_client_pair_t})::Cint
end

function aeron_remove_close_handler(client, pair)
    @ccall AeronClient.aeron_remove_close_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_close_client_pair_t})::Cint
end

struct aeron_counters_reader_buffers_stct
    values::Ptr{UInt8}
    metadata::Ptr{UInt8}
    values_length::Csize_t
    metadata_length::Csize_t
end

const aeron_counters_reader_buffers_t = aeron_counters_reader_buffers_stct

function aeron_counters_reader_get_buffers(reader, buffers)
    @ccall AeronClient.aeron_counters_reader_get_buffers(reader::Ptr{aeron_counters_reader_t}, buffers::Ptr{aeron_counters_reader_buffers_t})::Cint
end

# typedef void ( * aeron_counters_reader_foreach_counter_func_t ) ( int64_t value , int32_t id , int32_t type_id , const uint8_t * key , size_t key_length , const char * label , size_t label_length , void * clientd )
const aeron_counters_reader_foreach_counter_func_t = Ptr{Cvoid}

function aeron_counters_reader_foreach_counter(counters_reader, func, clientd)
    @ccall AeronClient.aeron_counters_reader_foreach_counter(counters_reader::Ptr{aeron_counters_reader_t}, func::aeron_counters_reader_foreach_counter_func_t, clientd::Ptr{Cvoid})::Cvoid
end

function aeron_counters_reader_max_counter_id(reader)
    @ccall AeronClient.aeron_counters_reader_max_counter_id(reader::Ptr{aeron_counters_reader_t})::Int32
end

function aeron_counters_reader_addr(counters_reader, counter_id)
    @ccall AeronClient.aeron_counters_reader_addr(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32)::Ptr{Int64}
end

function aeron_counters_reader_counter_registration_id(counters_reader, counter_id, registration_id)
    @ccall AeronClient.aeron_counters_reader_counter_registration_id(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, registration_id::Ptr{Int64})::Cint
end

function aeron_counters_reader_counter_owner_id(counters_reader, counter_id, owner_id)
    @ccall AeronClient.aeron_counters_reader_counter_owner_id(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, owner_id::Ptr{Int64})::Cint
end

function aeron_counters_reader_counter_state(counters_reader, counter_id, state)
    @ccall AeronClient.aeron_counters_reader_counter_state(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, state::Ptr{Int32})::Cint
end

function aeron_counters_reader_counter_type_id(counters_reader, counter_id, type_id)
    @ccall AeronClient.aeron_counters_reader_counter_type_id(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, type_id::Ptr{Int32})::Cint
end

function aeron_counters_reader_counter_label(counters_reader, counter_id, buffer, buffer_length)
    @ccall AeronClient.aeron_counters_reader_counter_label(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, buffer::Cstring, buffer_length::Csize_t)::Cint
end

function aeron_counters_reader_free_for_reuse_deadline_ms(counters_reader, counter_id, deadline_ms)
    @ccall AeronClient.aeron_counters_reader_free_for_reuse_deadline_ms(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, deadline_ms::Ptr{Int64})::Cint
end

# typedef int64_t ( * aeron_reserved_value_supplier_t ) ( void * clientd , uint8_t * buffer , size_t frame_length )
const aeron_reserved_value_supplier_t = Ptr{Cvoid}

struct aeron_iovec_stct
    iov_base::Ptr{UInt8}
    iov_len::Csize_t
end

const aeron_iovec_t = aeron_iovec_stct

function aeron_buffer_claim_commit(buffer_claim)
    @ccall AeronClient.aeron_buffer_claim_commit(buffer_claim::Ptr{aeron_buffer_claim_t})::Cint
end

function aeron_buffer_claim_abort(buffer_claim)
    @ccall AeronClient.aeron_buffer_claim_abort(buffer_claim::Ptr{aeron_buffer_claim_t})::Cint
end

struct aeron_publication_constants_stct
    channel::Cstring
    original_registration_id::Int64
    registration_id::Int64
    max_possible_position::Int64
    position_bits_to_shift::Csize_t
    term_buffer_length::Csize_t
    max_message_length::Csize_t
    max_payload_length::Csize_t
    stream_id::Int32
    session_id::Int32
    initial_term_id::Int32
    publication_limit_counter_id::Int32
    channel_status_indicator_id::Int32
end

const aeron_publication_constants_t = aeron_publication_constants_stct

function aeron_publication_offer(publication, buffer, length, reserved_value_supplier, clientd)
    @ccall AeronClient.aeron_publication_offer(publication::Ptr{aeron_publication_t}, buffer::Ptr{UInt8}, length::Csize_t, reserved_value_supplier::aeron_reserved_value_supplier_t, clientd::Ptr{Cvoid})::Int64
end

function aeron_publication_offerv(publication, iov, iovcnt, reserved_value_supplier, clientd)
    @ccall AeronClient.aeron_publication_offerv(publication::Ptr{aeron_publication_t}, iov::Ptr{aeron_iovec_t}, iovcnt::Csize_t, reserved_value_supplier::aeron_reserved_value_supplier_t, clientd::Ptr{Cvoid})::Int64
end

function aeron_publication_try_claim(publication, length, buffer_claim)
    @ccall AeronClient.aeron_publication_try_claim(publication::Ptr{aeron_publication_t}, length::Csize_t, buffer_claim::Ptr{aeron_buffer_claim_t})::Int64
end

function aeron_publication_channel_status(publication)
    @ccall AeronClient.aeron_publication_channel_status(publication::Ptr{aeron_publication_t})::Int64
end

function aeron_publication_is_closed(publication)
    @ccall AeronClient.aeron_publication_is_closed(publication::Ptr{aeron_publication_t})::Bool
end

function aeron_publication_is_connected(publication)
    @ccall AeronClient.aeron_publication_is_connected(publication::Ptr{aeron_publication_t})::Bool
end

function aeron_publication_constants(publication, constants)
    @ccall AeronClient.aeron_publication_constants(publication::Ptr{aeron_publication_t}, constants::Ptr{aeron_publication_constants_t})::Cint
end

function aeron_publication_position(publication)
    @ccall AeronClient.aeron_publication_position(publication::Ptr{aeron_publication_t})::Int64
end

function aeron_publication_position_limit(publication)
    @ccall AeronClient.aeron_publication_position_limit(publication::Ptr{aeron_publication_t})::Int64
end

function aeron_publication_async_add_destination(async, client, publication, uri)
    @ccall AeronClient.aeron_publication_async_add_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, publication::Ptr{aeron_publication_t}, uri::Cstring)::Cint
end

function aeron_publication_async_remove_destination(async, client, publication, uri)
    @ccall AeronClient.aeron_publication_async_remove_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, publication::Ptr{aeron_publication_t}, uri::Cstring)::Cint
end

function aeron_publication_async_destination_poll(async)
    @ccall AeronClient.aeron_publication_async_destination_poll(async::Ptr{aeron_async_destination_t})::Cint
end

function aeron_exclusive_publication_async_add_destination(async, client, publication, uri)
    @ccall AeronClient.aeron_exclusive_publication_async_add_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, publication::Ptr{aeron_exclusive_publication_t}, uri::Cstring)::Cint
end

function aeron_exclusive_publication_async_remove_destination(async, client, publication, uri)
    @ccall AeronClient.aeron_exclusive_publication_async_remove_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, publication::Ptr{aeron_exclusive_publication_t}, uri::Cstring)::Cint
end

function aeron_exclusive_publication_async_destination_poll(async)
    @ccall AeronClient.aeron_exclusive_publication_async_destination_poll(async::Ptr{aeron_async_destination_t})::Cint
end

function aeron_publication_close(publication, on_close_complete, on_close_complete_clientd)
    @ccall AeronClient.aeron_publication_close(publication::Ptr{aeron_publication_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

function aeron_publication_channel(publication)
    @ccall AeronClient.aeron_publication_channel(publication::Ptr{aeron_publication_t})::Cstring
end

function aeron_publication_stream_id(publication)
    @ccall AeronClient.aeron_publication_stream_id(publication::Ptr{aeron_publication_t})::Int32
end

function aeron_publication_session_id(publication)
    @ccall AeronClient.aeron_publication_session_id(publication::Ptr{aeron_publication_t})::Int32
end

function aeron_publication_local_sockaddrs(publication, address_vec, address_vec_len)
    @ccall AeronClient.aeron_publication_local_sockaddrs(publication::Ptr{aeron_publication_t}, address_vec::Ptr{aeron_iovec_t}, address_vec_len::Csize_t)::Cint
end

function aeron_exclusive_publication_offer(publication, buffer, length, reserved_value_supplier, clientd)
    @ccall AeronClient.aeron_exclusive_publication_offer(publication::Ptr{aeron_exclusive_publication_t}, buffer::Ptr{UInt8}, length::Csize_t, reserved_value_supplier::aeron_reserved_value_supplier_t, clientd::Ptr{Cvoid})::Int64
end

function aeron_exclusive_publication_offerv(publication, iov, iovcnt, reserved_value_supplier, clientd)
    @ccall AeronClient.aeron_exclusive_publication_offerv(publication::Ptr{aeron_exclusive_publication_t}, iov::Ptr{aeron_iovec_t}, iovcnt::Csize_t, reserved_value_supplier::aeron_reserved_value_supplier_t, clientd::Ptr{Cvoid})::Int64
end

function aeron_exclusive_publication_try_claim(publication, length, buffer_claim)
    @ccall AeronClient.aeron_exclusive_publication_try_claim(publication::Ptr{aeron_exclusive_publication_t}, length::Csize_t, buffer_claim::Ptr{aeron_buffer_claim_t})::Int64
end

function aeron_exclusive_publication_append_padding(publication, length)
    @ccall AeronClient.aeron_exclusive_publication_append_padding(publication::Ptr{aeron_exclusive_publication_t}, length::Csize_t)::Int64
end

function aeron_exclusive_publication_offer_block(publication, buffer, length)
    @ccall AeronClient.aeron_exclusive_publication_offer_block(publication::Ptr{aeron_exclusive_publication_t}, buffer::Ptr{UInt8}, length::Csize_t)::Int64
end

function aeron_exclusive_publication_channel_status(publication)
    @ccall AeronClient.aeron_exclusive_publication_channel_status(publication::Ptr{aeron_exclusive_publication_t})::Int64
end

function aeron_exclusive_publication_constants(publication, constants)
    @ccall AeronClient.aeron_exclusive_publication_constants(publication::Ptr{aeron_exclusive_publication_t}, constants::Ptr{aeron_publication_constants_t})::Cint
end

function aeron_exclusive_publication_position(publication)
    @ccall AeronClient.aeron_exclusive_publication_position(publication::Ptr{aeron_exclusive_publication_t})::Int64
end

function aeron_exclusive_publication_position_limit(publication)
    @ccall AeronClient.aeron_exclusive_publication_position_limit(publication::Ptr{aeron_exclusive_publication_t})::Int64
end

function aeron_exclusive_publication_close(publication, on_close_complete, on_close_complete_clientd)
    @ccall AeronClient.aeron_exclusive_publication_close(publication::Ptr{aeron_exclusive_publication_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

function aeron_exclusive_publication_is_closed(publication)
    @ccall AeronClient.aeron_exclusive_publication_is_closed(publication::Ptr{aeron_exclusive_publication_t})::Bool
end

function aeron_exclusive_publication_is_connected(publication)
    @ccall AeronClient.aeron_exclusive_publication_is_connected(publication::Ptr{aeron_exclusive_publication_t})::Bool
end

function aeron_exclusive_publication_local_sockaddrs(publication, address_vec, address_vec_len)
    @ccall AeronClient.aeron_exclusive_publication_local_sockaddrs(publication::Ptr{aeron_exclusive_publication_t}, address_vec::Ptr{aeron_iovec_t}, address_vec_len::Csize_t)::Cint
end

@enum aeron_controlled_fragment_handler_action_en::UInt32 begin
    AERON_ACTION_ABORT = 1
    AERON_ACTION_BREAK = 2
    AERON_ACTION_COMMIT = 3
    AERON_ACTION_CONTINUE = 4
end

const aeron_controlled_fragment_handler_action_t = aeron_controlled_fragment_handler_action_en

# typedef void ( * aeron_block_handler_t ) ( void * clientd , const uint8_t * buffer , size_t length , int32_t session_id , int32_t term_id )
const aeron_block_handler_t = Ptr{Cvoid}

function aeron_header_values(header, values)
    @ccall AeronClient.aeron_header_values(header::Ptr{aeron_header_t}, values::Ptr{aeron_header_values_t})::Cint
end

function aeron_header_position(header)
    @ccall AeronClient.aeron_header_position(header::Ptr{aeron_header_t})::Int64
end

function aeron_header_position_bits_to_shift(header)
    @ccall AeronClient.aeron_header_position_bits_to_shift(header::Ptr{aeron_header_t})::Csize_t
end

struct aeron_subscription_constants_stct
    channel::Cstring
    on_available_image::aeron_on_available_image_t
    on_unavailable_image::aeron_on_unavailable_image_t
    registration_id::Int64
    stream_id::Int32
    channel_status_indicator_id::Int32
end

const aeron_subscription_constants_t = aeron_subscription_constants_stct

function aeron_subscription_poll(subscription, handler, clientd, fragment_limit)
    @ccall AeronClient.aeron_subscription_poll(subscription::Ptr{aeron_subscription_t}, handler::aeron_fragment_handler_t, clientd::Ptr{Cvoid}, fragment_limit::Csize_t)::Cint
end

function aeron_subscription_controlled_poll(subscription, handler, clientd, fragment_limit)
    @ccall AeronClient.aeron_subscription_controlled_poll(subscription::Ptr{aeron_subscription_t}, handler::aeron_controlled_fragment_handler_t, clientd::Ptr{Cvoid}, fragment_limit::Csize_t)::Cint
end

function aeron_subscription_block_poll(subscription, handler, clientd, block_length_limit)
    @ccall AeronClient.aeron_subscription_block_poll(subscription::Ptr{aeron_subscription_t}, handler::aeron_block_handler_t, clientd::Ptr{Cvoid}, block_length_limit::Csize_t)::Clong
end

function aeron_subscription_is_connected(subscription)
    @ccall AeronClient.aeron_subscription_is_connected(subscription::Ptr{aeron_subscription_t})::Bool
end

function aeron_subscription_constants(subscription, constants)
    @ccall AeronClient.aeron_subscription_constants(subscription::Ptr{aeron_subscription_t}, constants::Ptr{aeron_subscription_constants_t})::Cint
end

function aeron_subscription_image_count(subscription)
    @ccall AeronClient.aeron_subscription_image_count(subscription::Ptr{aeron_subscription_t})::Cint
end

function aeron_subscription_image_by_session_id(subscription, session_id)
    @ccall AeronClient.aeron_subscription_image_by_session_id(subscription::Ptr{aeron_subscription_t}, session_id::Int32)::Ptr{aeron_image_t}
end

function aeron_subscription_image_at_index(subscription, index)
    @ccall AeronClient.aeron_subscription_image_at_index(subscription::Ptr{aeron_subscription_t}, index::Csize_t)::Ptr{aeron_image_t}
end

function aeron_subscription_for_each_image(subscription, handler, clientd)
    @ccall AeronClient.aeron_subscription_for_each_image(subscription::Ptr{aeron_subscription_t}, handler::Ptr{Cvoid}, clientd::Ptr{Cvoid})::Cvoid
end

function aeron_subscription_image_retain(subscription, image)
    @ccall AeronClient.aeron_subscription_image_retain(subscription::Ptr{aeron_subscription_t}, image::Ptr{aeron_image_t})::Cint
end

function aeron_subscription_image_release(subscription, image)
    @ccall AeronClient.aeron_subscription_image_release(subscription::Ptr{aeron_subscription_t}, image::Ptr{aeron_image_t})::Cint
end

function aeron_subscription_is_closed(subscription)
    @ccall AeronClient.aeron_subscription_is_closed(subscription::Ptr{aeron_subscription_t})::Bool
end

function aeron_subscription_channel_status(subscription)
    @ccall AeronClient.aeron_subscription_channel_status(subscription::Ptr{aeron_subscription_t})::Int64
end

function aeron_subscription_async_add_destination(async, client, subscription, uri)
    @ccall AeronClient.aeron_subscription_async_add_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, subscription::Ptr{aeron_subscription_t}, uri::Cstring)::Cint
end

function aeron_subscription_async_remove_destination(async, client, subscription, uri)
    @ccall AeronClient.aeron_subscription_async_remove_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, subscription::Ptr{aeron_subscription_t}, uri::Cstring)::Cint
end

function aeron_subscription_async_destination_poll(async)
    @ccall AeronClient.aeron_subscription_async_destination_poll(async::Ptr{aeron_async_destination_t})::Cint
end

function aeron_subscription_close(subscription, on_close_complete, on_close_complete_clientd)
    @ccall AeronClient.aeron_subscription_close(subscription::Ptr{aeron_subscription_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

function aeron_subscription_local_sockaddrs(subscription, address_vec, address_vec_len)
    @ccall AeronClient.aeron_subscription_local_sockaddrs(subscription::Ptr{aeron_subscription_t}, address_vec::Ptr{aeron_iovec_t}, address_vec_len::Csize_t)::Cint
end

function aeron_subscription_resolved_endpoint(subscription, address, address_len)
    @ccall AeronClient.aeron_subscription_resolved_endpoint(subscription::Ptr{aeron_subscription_t}, address::Cstring, address_len::Csize_t)::Cint
end

function aeron_subscription_try_resolve_channel_endpoint_port(subscription, uri, uri_len)
    @ccall AeronClient.aeron_subscription_try_resolve_channel_endpoint_port(subscription::Ptr{aeron_subscription_t}, uri::Cstring, uri_len::Csize_t)::Cint
end

struct aeron_image_constants_stct
    subscription::Ptr{aeron_subscription_t}
    source_identity::Cstring
    correlation_id::Int64
    join_position::Int64
    position_bits_to_shift::Csize_t
    term_buffer_length::Csize_t
    mtu_length::Csize_t
    session_id::Int32
    initial_term_id::Int32
    subscriber_position_id::Int32
end

const aeron_image_constants_t = aeron_image_constants_stct

function aeron_image_constants(image, constants)
    @ccall AeronClient.aeron_image_constants(image::Ptr{aeron_image_t}, constants::Ptr{aeron_image_constants_t})::Cint
end

function aeron_image_position(image)
    @ccall AeronClient.aeron_image_position(image::Ptr{aeron_image_t})::Int64
end

function aeron_image_set_position(image, position)
    @ccall AeronClient.aeron_image_set_position(image::Ptr{aeron_image_t}, position::Int64)::Cint
end

function aeron_image_is_end_of_stream(image)
    @ccall AeronClient.aeron_image_is_end_of_stream(image::Ptr{aeron_image_t})::Bool
end

function aeron_image_active_transport_count(image)
    @ccall AeronClient.aeron_image_active_transport_count(image::Ptr{aeron_image_t})::Cint
end

function aeron_image_poll(image, handler, clientd, fragment_limit)
    @ccall AeronClient.aeron_image_poll(image::Ptr{aeron_image_t}, handler::aeron_fragment_handler_t, clientd::Ptr{Cvoid}, fragment_limit::Csize_t)::Cint
end

function aeron_image_controlled_poll(image, handler, clientd, fragment_limit)
    @ccall AeronClient.aeron_image_controlled_poll(image::Ptr{aeron_image_t}, handler::aeron_controlled_fragment_handler_t, clientd::Ptr{Cvoid}, fragment_limit::Csize_t)::Cint
end

function aeron_image_bounded_poll(image, handler, clientd, limit_position, fragment_limit)
    @ccall AeronClient.aeron_image_bounded_poll(image::Ptr{aeron_image_t}, handler::aeron_fragment_handler_t, clientd::Ptr{Cvoid}, limit_position::Int64, fragment_limit::Csize_t)::Cint
end

function aeron_image_bounded_controlled_poll(image, handler, clientd, limit_position, fragment_limit)
    @ccall AeronClient.aeron_image_bounded_controlled_poll(image::Ptr{aeron_image_t}, handler::aeron_controlled_fragment_handler_t, clientd::Ptr{Cvoid}, limit_position::Int64, fragment_limit::Csize_t)::Cint
end

function aeron_image_controlled_peek(image, initial_position, handler, clientd, limit_position)
    @ccall AeronClient.aeron_image_controlled_peek(image::Ptr{aeron_image_t}, initial_position::Int64, handler::aeron_controlled_fragment_handler_t, clientd::Ptr{Cvoid}, limit_position::Int64)::Int64
end

function aeron_image_block_poll(image, handler, clientd, block_length_limit)
    @ccall AeronClient.aeron_image_block_poll(image::Ptr{aeron_image_t}, handler::aeron_block_handler_t, clientd::Ptr{Cvoid}, block_length_limit::Csize_t)::Cint
end

function aeron_image_is_closed(image)
    @ccall AeronClient.aeron_image_is_closed(image::Ptr{aeron_image_t})::Bool
end

function aeron_image_fragment_assembler_create(assembler, delegate, delegate_clientd)
    @ccall AeronClient.aeron_image_fragment_assembler_create(assembler::Ptr{Ptr{aeron_image_fragment_assembler_t}}, delegate::aeron_fragment_handler_t, delegate_clientd::Ptr{Cvoid})::Cint
end

function aeron_image_fragment_assembler_delete(assembler)
    @ccall AeronClient.aeron_image_fragment_assembler_delete(assembler::Ptr{aeron_image_fragment_assembler_t})::Cint
end

function aeron_image_fragment_assembler_handler(clientd, buffer, length, header)
    @ccall AeronClient.aeron_image_fragment_assembler_handler(clientd::Ptr{Cvoid}, buffer::Ptr{UInt8}, length::Csize_t, header::Ptr{aeron_header_t})::Cvoid
end

function aeron_image_controlled_fragment_assembler_create(assembler, delegate, delegate_clientd)
    @ccall AeronClient.aeron_image_controlled_fragment_assembler_create(assembler::Ptr{Ptr{aeron_image_controlled_fragment_assembler_t}}, delegate::aeron_controlled_fragment_handler_t, delegate_clientd::Ptr{Cvoid})::Cint
end

function aeron_image_controlled_fragment_assembler_delete(assembler)
    @ccall AeronClient.aeron_image_controlled_fragment_assembler_delete(assembler::Ptr{aeron_image_controlled_fragment_assembler_t})::Cint
end

function aeron_controlled_image_fragment_assembler_handler(clientd, buffer, length, header)
    @ccall AeronClient.aeron_controlled_image_fragment_assembler_handler(clientd::Ptr{Cvoid}, buffer::Ptr{UInt8}, length::Csize_t, header::Ptr{aeron_header_t})::aeron_controlled_fragment_handler_action_t
end

function aeron_fragment_assembler_create(assembler, delegate, delegate_clientd)
    @ccall AeronClient.aeron_fragment_assembler_create(assembler::Ptr{Ptr{aeron_fragment_assembler_t}}, delegate::aeron_fragment_handler_t, delegate_clientd::Ptr{Cvoid})::Cint
end

function aeron_fragment_assembler_delete(assembler)
    @ccall AeronClient.aeron_fragment_assembler_delete(assembler::Ptr{aeron_fragment_assembler_t})::Cint
end

function aeron_fragment_assembler_handler(clientd, buffer, length, header)
    @ccall AeronClient.aeron_fragment_assembler_handler(clientd::Ptr{Cvoid}, buffer::Ptr{UInt8}, length::Csize_t, header::Ptr{aeron_header_t})::Cvoid
end

function aeron_controlled_fragment_assembler_create(assembler, delegate, delegate_clientd)
    @ccall AeronClient.aeron_controlled_fragment_assembler_create(assembler::Ptr{Ptr{aeron_controlled_fragment_assembler_t}}, delegate::aeron_controlled_fragment_handler_t, delegate_clientd::Ptr{Cvoid})::Cint
end

function aeron_controlled_fragment_assembler_delete(assembler)
    @ccall AeronClient.aeron_controlled_fragment_assembler_delete(assembler::Ptr{aeron_controlled_fragment_assembler_t})::Cint
end

function aeron_controlled_fragment_assembler_handler(clientd, buffer, length, header)
    @ccall AeronClient.aeron_controlled_fragment_assembler_handler(clientd::Ptr{Cvoid}, buffer::Ptr{UInt8}, length::Csize_t, header::Ptr{aeron_header_t})::aeron_controlled_fragment_handler_action_t
end

function aeron_counter_addr(counter)
    @ccall AeronClient.aeron_counter_addr(counter::Ptr{aeron_counter_t})::Ptr{Int64}
end

struct aeron_counter_constants_stct
    registration_id::Int64
    counter_id::Int32
end

const aeron_counter_constants_t = aeron_counter_constants_stct

function aeron_counter_constants(counter, constants)
    @ccall AeronClient.aeron_counter_constants(counter::Ptr{aeron_counter_t}, constants::Ptr{aeron_counter_constants_t})::Cint
end

function aeron_counter_close(counter, on_close_complete, on_close_complete_clientd)
    @ccall AeronClient.aeron_counter_close(counter::Ptr{aeron_counter_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

function aeron_counter_is_closed(counter)
    @ccall AeronClient.aeron_counter_is_closed(counter::Ptr{aeron_counter_t})::Bool
end

function aeron_version_full()
    @ccall AeronClient.aeron_version_full()::Cstring
end

function aeron_version_major()
    @ccall AeronClient.aeron_version_major()::Cint
end

function aeron_version_minor()
    @ccall AeronClient.aeron_version_minor()::Cint
end

function aeron_version_patch()
    @ccall AeronClient.aeron_version_patch()::Cint
end

function aeron_nano_clock()
    @ccall AeronClient.aeron_nano_clock()::Int64
end

function aeron_epoch_clock()
    @ccall AeronClient.aeron_epoch_clock()::Int64
end

# typedef void ( * aeron_log_func_t ) ( const char * )
const aeron_log_func_t = Ptr{Cvoid}

function aeron_is_driver_active(dirname, timeout_ms, log_func)
    @ccall AeronClient.aeron_is_driver_active(dirname::Cstring, timeout_ms::Int64, log_func::aeron_log_func_t)::Bool
end

function aeron_properties_buffer_load(buffer)
    @ccall AeronClient.aeron_properties_buffer_load(buffer::Cstring)::Cint
end

function aeron_properties_file_load(filename)
    @ccall AeronClient.aeron_properties_file_load(filename::Cstring)::Cint
end

function aeron_properties_http_load(url)
    @ccall AeronClient.aeron_properties_http_load(url::Cstring)::Cint
end

function aeron_properties_load(url_or_filename)
    @ccall AeronClient.aeron_properties_load(url_or_filename::Cstring)::Cint
end

function aeron_errcode()
    @ccall AeronClient.aeron_errcode()::Cint
end

function aeron_errmsg()
    @ccall AeronClient.aeron_errmsg()::Cstring
end

function aeron_default_path(path, path_length)
    @ccall AeronClient.aeron_default_path(path::Cstring, path_length::Csize_t)::Cint
end

function aeron_async_add_counter_get_registration_id(add_counter)
    @ccall AeronClient.aeron_async_add_counter_get_registration_id(add_counter::Ptr{aeron_async_add_counter_t})::Int64
end

function aeron_async_add_publication_get_registration_id(add_publication)
    @ccall AeronClient.aeron_async_add_publication_get_registration_id(add_publication::Ptr{aeron_async_add_publication_t})::Int64
end

function aeron_async_add_exclusive_exclusive_publication_get_registration_id(add_exclusive_publication)
    @ccall AeronClient.aeron_async_add_exclusive_exclusive_publication_get_registration_id(add_exclusive_publication::Ptr{aeron_async_add_exclusive_publication_t})::Int64
end

function aeron_async_add_subscription_get_registration_id(add_subscription)
    @ccall AeronClient.aeron_async_add_subscription_get_registration_id(add_subscription::Ptr{aeron_async_add_subscription_t})::Int64
end

function aeron_async_destination_get_registration_id(async_destination)
    @ccall AeronClient.aeron_async_destination_get_registration_id(async_destination::Ptr{aeron_async_destination_t})::Int64
end

function aeron_context_request_driver_termination(directory, token_buffer, token_length)
    @ccall AeronClient.aeron_context_request_driver_termination(directory::Cstring, token_buffer::Ptr{UInt8}, token_length::Csize_t)::Cint
end

const aeron_cnc_stct = Cvoid

const aeron_cnc_t = aeron_cnc_stct

struct aeron_cnc_constants_stct
    data::NTuple{48, UInt8}
end

function Base.getproperty(x::Ptr{aeron_cnc_constants_stct}, f::Symbol)
    f === :cnc_version && return Ptr{Int32}(x + 0)
    f === :to_driver_buffer_length && return Ptr{Int32}(x + 4)
    f === :to_clients_buffer_length && return Ptr{Int32}(x + 8)
    f === :counter_metadata_buffer_length && return Ptr{Int32}(x + 12)
    f === :counter_values_buffer_length && return Ptr{Int32}(x + 16)
    f === :error_log_buffer_length && return Ptr{Int32}(x + 20)
    f === :client_liveness_timeout && return Ptr{Int64}(x + 24)
    f === :start_timestamp && return Ptr{Int64}(x + 32)
    f === :pid && return Ptr{Int64}(x + 40)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_cnc_constants_stct, f::Symbol)
    r = Ref{aeron_cnc_constants_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_cnc_constants_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_cnc_constants_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_cnc_constants_t = aeron_cnc_constants_stct

function aeron_cnc_init(aeron_cnc, base_path, timeout_ms)
    @ccall AeronClient.aeron_cnc_init(aeron_cnc::Ptr{Ptr{aeron_cnc_t}}, base_path::Cstring, timeout_ms::Int64)::Cint
end

function aeron_cnc_constants(aeron_cnc, constants)
    @ccall AeronClient.aeron_cnc_constants(aeron_cnc::Ptr{aeron_cnc_t}, constants::Ptr{aeron_cnc_constants_t})::Cint
end

function aeron_cnc_filename(aeron_cnc)
    @ccall AeronClient.aeron_cnc_filename(aeron_cnc::Ptr{aeron_cnc_t})::Cstring
end

function aeron_cnc_to_driver_heartbeat(aeron_cnc)
    @ccall AeronClient.aeron_cnc_to_driver_heartbeat(aeron_cnc::Ptr{aeron_cnc_t})::Int64
end

# typedef void ( * aeron_error_log_reader_func_t ) ( int32_t observation_count , int64_t first_observation_timestamp , int64_t last_observation_timestamp , const char * error , size_t error_length , void * clientd )
const aeron_error_log_reader_func_t = Ptr{Cvoid}

function aeron_cnc_error_log_read(aeron_cnc, callback, clientd, since_timestamp)
    @ccall AeronClient.aeron_cnc_error_log_read(aeron_cnc::Ptr{aeron_cnc_t}, callback::aeron_error_log_reader_func_t, clientd::Ptr{Cvoid}, since_timestamp::Int64)::Csize_t
end

function aeron_cnc_counters_reader(aeron_cnc)
    @ccall AeronClient.aeron_cnc_counters_reader(aeron_cnc::Ptr{aeron_cnc_t})::Ptr{aeron_counters_reader_t}
end

# typedef void ( * aeron_loss_reporter_read_entry_func_t ) ( void * clientd , int64_t observation_count , int64_t total_bytes_lost , int64_t first_observation_timestamp , int64_t last_observation_timestamp , int32_t session_id , int32_t stream_id , const char * channel , int32_t channel_length , const char * source , int32_t source_length )
const aeron_loss_reporter_read_entry_func_t = Ptr{Cvoid}

function aeron_cnc_loss_reporter_read(aeron_cnc, entry_func, clientd)
    @ccall AeronClient.aeron_cnc_loss_reporter_read(aeron_cnc::Ptr{aeron_cnc_t}, entry_func::aeron_loss_reporter_read_entry_func_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_cnc_close(aeron_cnc)
    @ccall AeronClient.aeron_cnc_close(aeron_cnc::Ptr{aeron_cnc_t})::Cvoid
end

function aeron_cache_line_align_buffer(buffer)
    @ccall AeronClient.aeron_cache_line_align_buffer(buffer::Ptr{UInt8})::Ptr{UInt8}
end

function aeron_number_of_trailing_zeroes(value)
    @ccall AeronClient.aeron_number_of_trailing_zeroes(value::Int32)::Cint
end

function aeron_number_of_trailing_zeroes_u64(value)
    @ccall AeronClient.aeron_number_of_trailing_zeroes_u64(value::UInt64)::Cint
end

function aeron_number_of_leading_zeroes(value)
    @ccall AeronClient.aeron_number_of_leading_zeroes(value::Int32)::Cint
end

function aeron_find_next_power_of_two(value)
    @ccall AeronClient.aeron_find_next_power_of_two(value::Int32)::Int32
end

function aeron_randomised_int32()
    @ccall AeronClient.aeron_randomised_int32()::Int32
end

struct aeron_clock_cache_stct
    pre_pad::NTuple{56, UInt8}
    cached_epoch_time::Int64
    cached_nano_time::Int64
    post_pad::NTuple{56, UInt8}
end

const aeron_clock_cache_t = aeron_clock_cache_stct

function aeron_clock_update_cached_time(cached_clock, epoch_time, nano_time)
    @ccall AeronClient.aeron_clock_update_cached_time(cached_clock::Ptr{aeron_clock_cache_t}, epoch_time::Int64, nano_time::Int64)::Cvoid
end

function aeron_clock_update_cached_epoch_time(cached_clock, epoch_time)
    @ccall AeronClient.aeron_clock_update_cached_epoch_time(cached_clock::Ptr{aeron_clock_cache_t}, epoch_time::Int64)::Cvoid
end

function aeron_clock_update_cached_nano_time(cached_clock, nano_time)
    @ccall AeronClient.aeron_clock_update_cached_nano_time(cached_clock::Ptr{aeron_clock_cache_t}, nano_time::Int64)::Cvoid
end

function aeron_clock_cached_epoch_time(cached_clock)
    @ccall AeronClient.aeron_clock_cached_epoch_time(cached_clock::Ptr{aeron_clock_cache_t})::Int64
end

function aeron_clock_cached_nano_time(cached_clock)
    @ccall AeronClient.aeron_clock_cached_nano_time(cached_clock::Ptr{aeron_clock_cache_t})::Int64
end

function aeron_clock_cache_alloc(cached_clock)
    @ccall AeronClient.aeron_clock_cache_alloc(cached_clock::Ptr{Ptr{aeron_clock_cache_t}})::Cint
end

function aeron_clock_gettime_realtime(time)
    @ccall AeronClient.aeron_clock_gettime_realtime(time::Ptr{Cvoid})::Cint
end

function aeron_thread_set_name(role_name)
    @ccall AeronClient.aeron_thread_set_name(role_name::Cstring)::Cvoid
end

function aeron_nano_sleep(nanoseconds)
    @ccall AeronClient.aeron_nano_sleep(nanoseconds::UInt64)::Cvoid
end

function aeron_micro_sleep(microseconds)
    @ccall AeronClient.aeron_micro_sleep(microseconds::Cuint)::Cvoid
end

function aeron_thread_set_affinity(role_name, cpu_affinity_no)
    @ccall AeronClient.aeron_thread_set_affinity(role_name::Cstring, cpu_affinity_no::UInt8)::Cint
end

const aeron_mutex_t = pthread_mutex_t

function proc_yield()
    @ccall AeronClient.proc_yield()::Cvoid
end

function aeron_cas_int64(dst, expected, desired)
    @ccall AeronClient.aeron_cas_int64(dst::Ptr{Int64}, expected::Int64, desired::Int64)::Bool
end

function aeron_cas_uint64(dst, expected, desired)
    @ccall AeronClient.aeron_cas_uint64(dst::Ptr{UInt64}, expected::UInt64, desired::UInt64)::Bool
end

function aeron_cas_int32(dst, expected, desired)
    @ccall AeronClient.aeron_cas_int32(dst::Ptr{Int32}, expected::Int32, desired::Int32)::Bool
end

function aeron_acquire()
    @ccall AeronClient.aeron_acquire()::Cvoid
end

function aeron_release()
    @ccall AeronClient.aeron_release()::Cvoid
end

struct aeron_distinct_observation_stct
    description::Cstring
    error_code::Cint
    offset::Csize_t
    description_length::Csize_t
end

const aeron_distinct_observation_t = aeron_distinct_observation_stct

struct aeron_distinct_error_log_observation_list_stct
    num_observations::UInt64
    observations::Ptr{aeron_distinct_observation_t}
end

const aeron_distinct_error_log_observation_list_t = aeron_distinct_error_log_observation_list_stct

struct aeron_distinct_error_log_stct
    buffer::Ptr{UInt8}
    observation_list::Ptr{aeron_distinct_error_log_observation_list_t}
    buffer_capacity::Csize_t
    next_offset::Csize_t
    clock::aeron_clock_func_t
    mutex::aeron_mutex_t
end

const aeron_distinct_error_log_t = aeron_distinct_error_log_stct

function aeron_distinct_error_log_init(log, buffer, buffer_size, clock)
    @ccall AeronClient.aeron_distinct_error_log_init(log::Ptr{aeron_distinct_error_log_t}, buffer::Ptr{UInt8}, buffer_size::Csize_t, clock::aeron_clock_func_t)::Cint
end

function aeron_distinct_error_log_close(log)
    @ccall AeronClient.aeron_distinct_error_log_close(log::Ptr{aeron_distinct_error_log_t})::Cvoid
end

function aeron_distinct_error_log_record(log, error_code, description)
    @ccall AeronClient.aeron_distinct_error_log_record(log::Ptr{aeron_distinct_error_log_t}, error_code::Cint, description::Cstring)::Cint
end

function aeron_error_log_exists(buffer, buffer_size)
    @ccall AeronClient.aeron_error_log_exists(buffer::Ptr{UInt8}, buffer_size::Csize_t)::Bool
end

function aeron_error_log_read(buffer, buffer_size, reader, clientd, since_timestamp)
    @ccall AeronClient.aeron_error_log_read(buffer::Ptr{UInt8}, buffer_size::Csize_t, reader::aeron_error_log_reader_func_t, clientd::Ptr{Cvoid}, since_timestamp::Int64)::Csize_t
end

function aeron_distinct_error_log_num_observations(log)
    @ccall AeronClient.aeron_distinct_error_log_num_observations(log::Ptr{aeron_distinct_error_log_t})::Csize_t
end

# typedef int ( * aeron_idle_strategy_init_func_t ) ( void * * state , const char * env_var , const char * init_args )
const aeron_idle_strategy_init_func_t = Ptr{Cvoid}

function aeron_semantic_version_compose(major, minor, patch)
    @ccall AeronClient.aeron_semantic_version_compose(major::UInt8, minor::UInt8, patch::UInt8)::Int32
end

function aeron_semantic_version_major(version)
    @ccall AeronClient.aeron_semantic_version_major(version::Int32)::UInt8
end

function aeron_semantic_version_minor(version)
    @ccall AeronClient.aeron_semantic_version_minor(version::Int32)::UInt8
end

function aeron_semantic_version_patch(version)
    @ccall AeronClient.aeron_semantic_version_patch(version::Int32)::UInt8
end

# typedef void ( * aeron_fptr_t ) ( void )
const aeron_fptr_t = Ptr{Cvoid}

struct aeron_per_thread_error_stct
    errcode::Cint
    offset::Csize_t
    errmsg::NTuple{8192, Cchar}
end

const aeron_per_thread_error_t = aeron_per_thread_error_stct

function aeron_set_errno(errcode)
    @ccall AeronClient.aeron_set_errno(errcode::Cint)::Cvoid
end

function aeron_error_code_str(errcode)
    @ccall AeronClient.aeron_error_code_str(errcode::Cint)::Cstring
end

function aeron_err_clear()
    @ccall AeronClient.aeron_err_clear()::Cvoid
end

struct aeron_bit_set_stct
    bit_set_length::Csize_t
    bits::Ptr{UInt64}
    static_array::Ptr{UInt64}
end

const aeron_bit_set_t = aeron_bit_set_stct

function aeron_bit_set_init(bit_set, initial_value)
    @ccall AeronClient.aeron_bit_set_init(bit_set::Ptr{aeron_bit_set_t}, initial_value::Bool)::Cint
end

function aeron_bit_set_stack_alloc(bit_set_length, static_array, static_array_len, bit_set)
    @ccall AeronClient.aeron_bit_set_stack_alloc(bit_set_length::Csize_t, static_array::Ptr{UInt64}, static_array_len::Csize_t, bit_set::Ptr{aeron_bit_set_t})::Cint
end

function aeron_bit_set_heap_alloc(bit_set_length, bit_set)
    @ccall AeronClient.aeron_bit_set_heap_alloc(bit_set_length::Csize_t, bit_set::Ptr{Ptr{aeron_bit_set_t}})::Cint
end

function aeron_bit_set_stack_init(bit_set_length, static_array, static_array_len, initial_value, bit_set)
    @ccall AeronClient.aeron_bit_set_stack_init(bit_set_length::Csize_t, static_array::Ptr{UInt64}, static_array_len::Csize_t, initial_value::Bool, bit_set::Ptr{aeron_bit_set_t})::Cint
end

function aeron_bit_set_heap_init(bit_set_length, initial_value, bit_set)
    @ccall AeronClient.aeron_bit_set_heap_init(bit_set_length::Csize_t, initial_value::Bool, bit_set::Ptr{Ptr{aeron_bit_set_t}})::Cint
end

function aeron_bit_set_stack_free(bit_set)
    @ccall AeronClient.aeron_bit_set_stack_free(bit_set::Ptr{aeron_bit_set_t})::Cvoid
end

function aeron_bit_set_heap_free(bit_set)
    @ccall AeronClient.aeron_bit_set_heap_free(bit_set::Ptr{aeron_bit_set_t})::Cvoid
end

function aeron_bit_set_get(bit_set, bit_index, value)
    @ccall AeronClient.aeron_bit_set_get(bit_set::Ptr{aeron_bit_set_t}, bit_index::Csize_t, value::Ptr{Bool})::Cint
end

function aeron_bit_set_set(bit_set, bit_index, value)
    @ccall AeronClient.aeron_bit_set_set(bit_set::Ptr{aeron_bit_set_t}, bit_index::Csize_t, value::Bool)::Cint
end

function aeron_bit_set_find_first(bit_set, value, bit_index)
    @ccall AeronClient.aeron_bit_set_find_first(bit_set::Ptr{aeron_bit_set_t}, value::Bool, bit_index::Ptr{Csize_t})::Cint
end

struct aeron_setup_header_stct
    data::NTuple{40, UInt8}
end

function Base.getproperty(x::Ptr{aeron_setup_header_stct}, f::Symbol)
    f === :frame_header && return Ptr{aeron_frame_header_t}(x + 0)
    f === :term_offset && return Ptr{Int32}(x + 8)
    f === :session_id && return Ptr{Int32}(x + 12)
    f === :stream_id && return Ptr{Int32}(x + 16)
    f === :initial_term_id && return Ptr{Int32}(x + 20)
    f === :active_term_id && return Ptr{Int32}(x + 24)
    f === :term_length && return Ptr{Int32}(x + 28)
    f === :mtu && return Ptr{Int32}(x + 32)
    f === :ttl && return Ptr{Int32}(x + 36)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_setup_header_stct, f::Symbol)
    r = Ref{aeron_setup_header_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_setup_header_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_setup_header_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_setup_header_t = aeron_setup_header_stct

struct aeron_nak_header_stct
    data::NTuple{28, UInt8}
end

function Base.getproperty(x::Ptr{aeron_nak_header_stct}, f::Symbol)
    f === :frame_header && return Ptr{aeron_frame_header_t}(x + 0)
    f === :session_id && return Ptr{Int32}(x + 8)
    f === :stream_id && return Ptr{Int32}(x + 12)
    f === :term_id && return Ptr{Int32}(x + 16)
    f === :term_offset && return Ptr{Int32}(x + 20)
    f === :length && return Ptr{Int32}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_nak_header_stct, f::Symbol)
    r = Ref{aeron_nak_header_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_nak_header_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_nak_header_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_nak_header_t = aeron_nak_header_stct

struct aeron_status_message_header_stct
    data::NTuple{36, UInt8}
end

function Base.getproperty(x::Ptr{aeron_status_message_header_stct}, f::Symbol)
    f === :frame_header && return Ptr{aeron_frame_header_t}(x + 0)
    f === :session_id && return Ptr{Int32}(x + 8)
    f === :stream_id && return Ptr{Int32}(x + 12)
    f === :consumption_term_id && return Ptr{Int32}(x + 16)
    f === :consumption_term_offset && return Ptr{Int32}(x + 20)
    f === :receiver_window && return Ptr{Int32}(x + 24)
    f === :receiver_id && return Ptr{Int64}(x + 28)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_status_message_header_stct, f::Symbol)
    r = Ref{aeron_status_message_header_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_status_message_header_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_status_message_header_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_status_message_header_t = aeron_status_message_header_stct

struct aeron_status_message_optional_header_stct
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_status_message_optional_header_stct}, f::Symbol)
    f === :group_tag && return Ptr{Int64}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_status_message_optional_header_stct, f::Symbol)
    r = Ref{aeron_status_message_optional_header_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_status_message_optional_header_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_status_message_optional_header_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_status_message_optional_header_t = aeron_status_message_optional_header_stct

struct aeron_rttm_header_stct
    data::NTuple{40, UInt8}
end

function Base.getproperty(x::Ptr{aeron_rttm_header_stct}, f::Symbol)
    f === :frame_header && return Ptr{aeron_frame_header_t}(x + 0)
    f === :session_id && return Ptr{Int32}(x + 8)
    f === :stream_id && return Ptr{Int32}(x + 12)
    f === :echo_timestamp && return Ptr{Int64}(x + 16)
    f === :reception_delta && return Ptr{Int64}(x + 24)
    f === :receiver_id && return Ptr{Int64}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_rttm_header_stct, f::Symbol)
    r = Ref{aeron_rttm_header_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_rttm_header_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_rttm_header_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_rttm_header_t = aeron_rttm_header_stct

struct aeron_resolution_header_stct
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_resolution_header_stct}, f::Symbol)
    f === :res_type && return Ptr{Int8}(x + 0)
    f === :res_flags && return Ptr{UInt8}(x + 1)
    f === :udp_port && return Ptr{UInt16}(x + 2)
    f === :age_in_ms && return Ptr{Int32}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_resolution_header_stct, f::Symbol)
    r = Ref{aeron_resolution_header_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_resolution_header_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_resolution_header_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_resolution_header_t = aeron_resolution_header_stct

struct aeron_resolution_header_ipv4_stct
    data::NTuple{14, UInt8}
end

function Base.getproperty(x::Ptr{aeron_resolution_header_ipv4_stct}, f::Symbol)
    f === :resolution_header && return Ptr{aeron_resolution_header_t}(x + 0)
    f === :addr && return Ptr{NTuple{4, UInt8}}(x + 8)
    f === :name_length && return Ptr{Int16}(x + 12)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_resolution_header_ipv4_stct, f::Symbol)
    r = Ref{aeron_resolution_header_ipv4_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_resolution_header_ipv4_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_resolution_header_ipv4_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_resolution_header_ipv4_t = aeron_resolution_header_ipv4_stct

struct aeron_resolution_header_ipv6_stct
    data::NTuple{26, UInt8}
end

function Base.getproperty(x::Ptr{aeron_resolution_header_ipv6_stct}, f::Symbol)
    f === :resolution_header && return Ptr{aeron_resolution_header_t}(x + 0)
    f === :addr && return Ptr{NTuple{16, UInt8}}(x + 8)
    f === :name_length && return Ptr{Int16}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_resolution_header_ipv6_stct, f::Symbol)
    r = Ref{aeron_resolution_header_ipv6_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_resolution_header_ipv6_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_resolution_header_ipv6_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_resolution_header_ipv6_t = aeron_resolution_header_ipv6_stct

struct aeron_option_hdeader_stct
    data::NTuple{4, UInt8}
end

function Base.getproperty(x::Ptr{aeron_option_hdeader_stct}, f::Symbol)
    f === :option_length && return Ptr{UInt16}(x + 0)
    f === :type && return Ptr{UInt16}(x + 2)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_option_hdeader_stct, f::Symbol)
    r = Ref{aeron_option_hdeader_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_option_hdeader_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_option_hdeader_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_option_header_t = aeron_option_hdeader_stct

function aeron_udp_protocol_group_tag(sm, group_tag)
    @ccall AeronClient.aeron_udp_protocol_group_tag(sm::Ptr{aeron_status_message_header_t}, group_tag::Ptr{Int64})::Cint
end

function aeron_res_header_address_length(res_type)
    @ccall AeronClient.aeron_res_header_address_length(res_type::Int8)::Csize_t
end

function aeron_compute_max_message_length(term_length)
    @ccall AeronClient.aeron_compute_max_message_length(term_length::Csize_t)::Csize_t
end

function aeron_res_header_entry_length_ipv4(header)
    @ccall AeronClient.aeron_res_header_entry_length_ipv4(header::Ptr{aeron_resolution_header_ipv4_t})::Csize_t
end

function aeron_res_header_entry_length_ipv6(header)
    @ccall AeronClient.aeron_res_header_entry_length_ipv6(header::Ptr{aeron_resolution_header_ipv6_t})::Csize_t
end

function aeron_res_header_entry_length(res, remaining)
    @ccall AeronClient.aeron_res_header_entry_length(res::Ptr{Cvoid}, remaining::Csize_t)::Cint
end

function aeron_add_wrap_i32(a, b)
    @ccall AeronClient.aeron_add_wrap_i32(a::Int32, b::Int32)::Int32
end

function aeron_sub_wrap_i32(a, b)
    @ccall AeronClient.aeron_sub_wrap_i32(a::Int32, b::Int32)::Int32
end

function aeron_mul_wrap_i32(a, b)
    @ccall AeronClient.aeron_mul_wrap_i32(a::Int32, b::Int32)::Int32
end

function aeron_logbuffer_check_term_length(term_length)
    @ccall AeronClient.aeron_logbuffer_check_term_length(term_length::UInt64)::Cint
end

function aeron_logbuffer_check_page_size(page_size)
    @ccall AeronClient.aeron_logbuffer_check_page_size(page_size::UInt64)::Cint
end

function aeron_logbuffer_compute_log_length(term_length, page_size)
    @ccall AeronClient.aeron_logbuffer_compute_log_length(term_length::UInt64, page_size::UInt64)::UInt64
end

function aeron_logbuffer_term_offset(raw_tail, term_length)
    @ccall AeronClient.aeron_logbuffer_term_offset(raw_tail::Int64, term_length::Int32)::Int32
end

function aeron_logbuffer_term_id(raw_tail)
    @ccall AeronClient.aeron_logbuffer_term_id(raw_tail::Int64)::Int32
end

function aeron_logbuffer_compute_term_count(term_id, initial_term_id)
    @ccall AeronClient.aeron_logbuffer_compute_term_count(term_id::Int32, initial_term_id::Int32)::Int32
end

function aeron_logbuffer_index_by_position(position, position_bits_to_shift)
    @ccall AeronClient.aeron_logbuffer_index_by_position(position::Int64, position_bits_to_shift::Csize_t)::Csize_t
end

function aeron_logbuffer_index_by_term(initial_term_id, active_term_id)
    @ccall AeronClient.aeron_logbuffer_index_by_term(initial_term_id::Int32, active_term_id::Int32)::Csize_t
end

function aeron_logbuffer_index_by_term_count(term_count)
    @ccall AeronClient.aeron_logbuffer_index_by_term_count(term_count::Int32)::Csize_t
end

function aeron_logbuffer_compute_position(active_term_id, term_offset, position_bits_to_shift, initial_term_id)
    @ccall AeronClient.aeron_logbuffer_compute_position(active_term_id::Int32, term_offset::Int32, position_bits_to_shift::Csize_t, initial_term_id::Int32)::Int64
end

function aeron_logbuffer_compute_term_begin_position(active_term_id, position_bits_to_shift, initial_term_id)
    @ccall AeronClient.aeron_logbuffer_compute_term_begin_position(active_term_id::Int32, position_bits_to_shift::Csize_t, initial_term_id::Int32)::Int64
end

function aeron_logbuffer_compute_term_id_from_position(position, position_bits_to_shift, initial_term_id)
    @ccall AeronClient.aeron_logbuffer_compute_term_id_from_position(position::Int64, position_bits_to_shift::Csize_t, initial_term_id::Int32)::Int32
end

function aeron_logbuffer_compute_term_offset_from_position(position, position_bits_to_shift)
    @ccall AeronClient.aeron_logbuffer_compute_term_offset_from_position(position::Int64, position_bits_to_shift::Csize_t)::Int32
end

function aeron_logbuffer_cas_raw_tail(log_meta_data, partition_index, expected_raw_tail, update_raw_tail)
    @ccall AeronClient.aeron_logbuffer_cas_raw_tail(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, partition_index::Csize_t, expected_raw_tail::Int64, update_raw_tail::Int64)::Bool
end

function aeron_logbuffer_active_term_count(log_meta_data)
    @ccall AeronClient.aeron_logbuffer_active_term_count(log_meta_data::Ptr{aeron_logbuffer_metadata_t})::Int32
end

function aeron_logbuffer_cas_active_term_count(log_meta_data, expected_term_count, update_term_count)
    @ccall AeronClient.aeron_logbuffer_cas_active_term_count(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, expected_term_count::Int32, update_term_count::Int32)::Bool
end

function aeron_logbuffer_rotate_log(log_meta_data, current_term_count, current_term_id)
    @ccall AeronClient.aeron_logbuffer_rotate_log(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, current_term_count::Int32, current_term_id::Int32)::Bool
end

function aeron_logbuffer_fill_default_header(log_meta_data_buffer, session_id, stream_id, initial_term_id)
    @ccall AeronClient.aeron_logbuffer_fill_default_header(log_meta_data_buffer::Ptr{UInt8}, session_id::Int32, stream_id::Int32, initial_term_id::Int32)::Cvoid
end

function aeron_logbuffer_apply_default_header(log_meta_data_buffer, buffer)
    @ccall AeronClient.aeron_logbuffer_apply_default_header(log_meta_data_buffer::Ptr{UInt8}, buffer::Ptr{UInt8})::Cvoid
end

function aeron_term_gap_filler_try_fill_gap(log_meta_data, buffer, term_id, gap_offset, gap_length)
    @ccall AeronClient.aeron_term_gap_filler_try_fill_gap(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, buffer::Ptr{UInt8}, term_id::Int32, gap_offset::Int32, gap_length::Int32)::Bool
end

function aeron_hash_code(value)
    @ccall AeronClient.aeron_hash_code(value::UInt64)::UInt64
end

function aeron_hash(value, mask)
    @ccall AeronClient.aeron_hash(value::UInt64, mask::Csize_t)::Csize_t
end

function aeron_even_hash(value, mask)
    @ccall AeronClient.aeron_even_hash(value::UInt64, mask::Csize_t)::Csize_t
end

function aeron_map_compound_key(high, low)
    @ccall AeronClient.aeron_map_compound_key(high::Int32, low::Int32)::Int64
end

struct aeron_int64_counter_map_stct
    entries::Ptr{Int64}
    load_factor::Cfloat
    entries_length::Csize_t
    size::Csize_t
    resize_threshold::Csize_t
    initial_value::Int64
end

const aeron_int64_counter_map_t = aeron_int64_counter_map_stct

function aeron_int64_counter_map_hash_key(key, mask)
    @ccall AeronClient.aeron_int64_counter_map_hash_key(key::Int64, mask::Csize_t)::Csize_t
end

function aeron_int64_counter_map_init(map, initial_value, initial_capacity, load_factor)
    @ccall AeronClient.aeron_int64_counter_map_init(map::Ptr{aeron_int64_counter_map_t}, initial_value::Int64, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

function aeron_int64_counter_map_delete(map)
    @ccall AeronClient.aeron_int64_counter_map_delete(map::Ptr{aeron_int64_counter_map_t})::Cvoid
end

function aeron_int64_counter_map_rehash(map, new_entries_length)
    @ccall AeronClient.aeron_int64_counter_map_rehash(map::Ptr{aeron_int64_counter_map_t}, new_entries_length::Csize_t)::Cint
end

function aeron_int64_counter_map_compact_chain(map, delete_index)
    @ccall AeronClient.aeron_int64_counter_map_compact_chain(map::Ptr{aeron_int64_counter_map_t}, delete_index::Csize_t)::Cvoid
end

function aeron_int64_counter_map_remove(map, key)
    @ccall AeronClient.aeron_int64_counter_map_remove(map::Ptr{aeron_int64_counter_map_t}, key::Int64)::Int64
end

function aeron_int64_counter_map_put(map, key, value, existing_value)
    @ccall AeronClient.aeron_int64_counter_map_put(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Int64, existing_value::Ptr{Int64})::Cint
end

function aeron_int64_counter_map_get(map, key)
    @ccall AeronClient.aeron_int64_counter_map_get(map::Ptr{aeron_int64_counter_map_t}, key::Int64)::Int64
end

function aeron_int64_counter_map_get_and_add(map, key, delta, value)
    @ccall AeronClient.aeron_int64_counter_map_get_and_add(map::Ptr{aeron_int64_counter_map_t}, key::Int64, delta::Int64, value::Ptr{Int64})::Cint
end

function aeron_int64_counter_map_add_and_get(map, key, delta, value)
    @ccall AeronClient.aeron_int64_counter_map_add_and_get(map::Ptr{aeron_int64_counter_map_t}, key::Int64, delta::Int64, value::Ptr{Int64})::Cint
end

function aeron_int64_counter_map_inc_and_get(map, key, value)
    @ccall AeronClient.aeron_int64_counter_map_inc_and_get(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Ptr{Int64})::Cint
end

function aeron_int64_counter_map_dec_and_get(map, key, value)
    @ccall AeronClient.aeron_int64_counter_map_dec_and_get(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Ptr{Int64})::Cint
end

function aeron_int64_counter_map_get_and_inc(map, key, value)
    @ccall AeronClient.aeron_int64_counter_map_get_and_inc(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Ptr{Int64})::Cint
end

function aeron_int64_counter_map_get_and_dec(map, key, value)
    @ccall AeronClient.aeron_int64_counter_map_get_and_dec(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Ptr{Int64})::Cint
end

# typedef void ( * aeron_int64_counter_map_for_each_func_t ) ( void * clientd , int64_t key , int64_t value )
const aeron_int64_counter_map_for_each_func_t = Ptr{Cvoid}

function aeron_int64_counter_map_for_each(map, func, clientd)
    @ccall AeronClient.aeron_int64_counter_map_for_each(map::Ptr{aeron_int64_counter_map_t}, func::aeron_int64_counter_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

struct aeron_properties_parser_state_stct
    property_str::NTuple{2048, Cchar}
    name_end::Csize_t
    value_end::Csize_t
end

const aeron_properties_parser_state_t = aeron_properties_parser_state_stct

# typedef int ( * aeron_properties_file_handler_func_t ) ( void * clientd , const char * property_name , const char * property_value )
const aeron_properties_file_handler_func_t = Ptr{Cvoid}

function aeron_properties_parse_init(state)
    @ccall AeronClient.aeron_properties_parse_init(state::Ptr{aeron_properties_parser_state_t})::Cvoid
end

function aeron_properties_parse_line(state, line, length, handler, clientd)
    @ccall AeronClient.aeron_properties_parse_line(state::Ptr{aeron_properties_parser_state_t}, line::Cstring, length::Csize_t, handler::aeron_properties_file_handler_func_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_properties_parse_file(filename, handler, clientd)
    @ccall AeronClient.aeron_properties_parse_file(filename::Cstring, handler::aeron_properties_file_handler_func_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_properties_setenv(name, value)
    @ccall AeronClient.aeron_properties_setenv(name::Cstring, value::Cstring)::Cint
end

struct aeron_loss_reporter_entry_stct
    data::NTuple{40, UInt8}
end

function Base.getproperty(x::Ptr{aeron_loss_reporter_entry_stct}, f::Symbol)
    f === :observation_count && return Ptr{Int64}(x + 0)
    f === :total_bytes_lost && return Ptr{Int64}(x + 8)
    f === :first_observation_timestamp && return Ptr{Int64}(x + 16)
    f === :last_observation_timestamp && return Ptr{Int64}(x + 24)
    f === :session_id && return Ptr{Int32}(x + 32)
    f === :stream_id && return Ptr{Int32}(x + 36)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_loss_reporter_entry_stct, f::Symbol)
    r = Ref{aeron_loss_reporter_entry_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_loss_reporter_entry_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_loss_reporter_entry_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_loss_reporter_entry_t = aeron_loss_reporter_entry_stct

struct aeron_loss_reporter_stct
    buffer::Ptr{UInt8}
    next_record_offset::Csize_t
    capacity::Csize_t
end

const aeron_loss_reporter_t = aeron_loss_reporter_stct

const aeron_loss_reporter_entry_offset_t = Int64

function aeron_loss_reporter_init(reporter, buffer, length)
    @ccall AeronClient.aeron_loss_reporter_init(reporter::Ptr{aeron_loss_reporter_t}, buffer::Ptr{UInt8}, length::Csize_t)::Cint
end

function aeron_loss_reporter_create_entry(reporter, initial_bytes_lost, timestamp_ms, session_id, stream_id, channel, channel_length, source, source_length)
    @ccall AeronClient.aeron_loss_reporter_create_entry(reporter::Ptr{aeron_loss_reporter_t}, initial_bytes_lost::Int64, timestamp_ms::Int64, session_id::Int32, stream_id::Int32, channel::Cstring, channel_length::Csize_t, source::Cstring, source_length::Csize_t)::aeron_loss_reporter_entry_offset_t
end

function aeron_loss_reporter_record_observation(reporter, offset, bytes_lost, timestamp_ms)
    @ccall AeronClient.aeron_loss_reporter_record_observation(reporter::Ptr{aeron_loss_reporter_t}, offset::aeron_loss_reporter_entry_offset_t, bytes_lost::Int64, timestamp_ms::Int64)::Cvoid
end

function aeron_loss_reporter_resolve_filename(directory, filename_buffer, filename_buffer_length)
    @ccall AeronClient.aeron_loss_reporter_resolve_filename(directory::Cstring, filename_buffer::Cstring, filename_buffer_length::Csize_t)::Cint
end

function aeron_loss_reporter_read(buffer, capacity, entry_func, clientd)
    @ccall AeronClient.aeron_loss_reporter_read(buffer::Ptr{UInt8}, capacity::Csize_t, entry_func::aeron_loss_reporter_read_entry_func_t, clientd::Ptr{Cvoid})::Csize_t
end

function aeron_dlinfo(arg1, buffer, max_buffer_length)
    @ccall AeronClient.aeron_dlinfo(arg1::Ptr{Cvoid}, buffer::Cstring, max_buffer_length::Csize_t)::Cstring
end

function aeron_dlinfo_func(func, buffer, max_buffer_length)
    @ccall AeronClient.aeron_dlinfo_func(func::Ptr{Cvoid}, buffer::Cstring, max_buffer_length::Csize_t)::Cstring
end

struct aeron_dl_loaded_lib_state_stct
    handle::Ptr{Cvoid}
end

const aeron_dl_loaded_lib_state_t = aeron_dl_loaded_lib_state_stct

struct aeron_dl_loaded_libs_state_stct
    libs::Ptr{aeron_dl_loaded_lib_state_t}
    num_libs::Csize_t
end

const aeron_dl_loaded_libs_state_t = aeron_dl_loaded_libs_state_stct

function aeron_dl_load_libs(state, libs)
    @ccall AeronClient.aeron_dl_load_libs(state::Ptr{Ptr{aeron_dl_loaded_libs_state_t}}, libs::Cstring)::Cint
end

function aeron_dl_load_libs_delete(state)
    @ccall AeronClient.aeron_dl_load_libs_delete(state::Ptr{aeron_dl_loaded_libs_state_t})::Cint
end

function aeron_local_sockaddr_find_addrs(reader, channel_status_indicator_id, address_vec, address_vec_len)
    @ccall AeronClient.aeron_local_sockaddr_find_addrs(reader::Ptr{aeron_counters_reader_t}, channel_status_indicator_id::Int32, address_vec::Ptr{aeron_iovec_t}, address_vec_len::Csize_t)::Cint
end

struct aeron_broadcast_record_descriptor_stct
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_broadcast_record_descriptor_stct}, f::Symbol)
    f === :length && return Ptr{Int32}(x + 0)
    f === :msg_type_id && return Ptr{Int32}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_broadcast_record_descriptor_stct, f::Symbol)
    r = Ref{aeron_broadcast_record_descriptor_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_broadcast_record_descriptor_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_broadcast_record_descriptor_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_broadcast_record_descriptor_t = aeron_broadcast_record_descriptor_stct

struct aeron_rb_record_descriptor_stct
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_rb_record_descriptor_stct}, f::Symbol)
    f === :length && return Ptr{Int32}(x + 0)
    f === :msg_type_id && return Ptr{Int32}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_rb_record_descriptor_stct, f::Symbol)
    r = Ref{aeron_rb_record_descriptor_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_rb_record_descriptor_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_rb_record_descriptor_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_rb_record_descriptor_t = aeron_rb_record_descriptor_stct

struct aeron_idle_strategy_stct
    idle::aeron_idle_strategy_func_t
    init::aeron_idle_strategy_init_func_t
end

const aeron_idle_strategy_t = aeron_idle_strategy_stct

function aeron_idle_strategy_sleeping_idle(state, work_count)
    @ccall AeronClient.aeron_idle_strategy_sleeping_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

function aeron_idle_strategy_yielding_idle(state, work_count)
    @ccall AeronClient.aeron_idle_strategy_yielding_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

function aeron_idle_strategy_busy_spinning_idle(state, work_count)
    @ccall AeronClient.aeron_idle_strategy_busy_spinning_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

function aeron_idle_strategy_noop_idle(state, work_count)
    @ccall AeronClient.aeron_idle_strategy_noop_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

function aeron_idle_strategy_backoff_idle(state, work_count)
    @ccall AeronClient.aeron_idle_strategy_backoff_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

function aeron_idle_strategy_backoff_state_init(state, max_spins, max_yields, min_park_period_ns, max_park_period_ns)
    @ccall AeronClient.aeron_idle_strategy_backoff_state_init(state::Ptr{Ptr{Cvoid}}, max_spins::UInt64, max_yields::UInt64, min_park_period_ns::UInt64, max_park_period_ns::UInt64)::Cint
end

function aeron_idle_strategy_init_null(state, env_var, load_args)
    @ccall AeronClient.aeron_idle_strategy_init_null(state::Ptr{Ptr{Cvoid}}, env_var::Cstring, load_args::Cstring)::Cint
end

function aeron_idle_strategy_load(idle_strategy_name, idle_strategy_state, env_var, load_args)
    @ccall AeronClient.aeron_idle_strategy_load(idle_strategy_name::Cstring, idle_strategy_state::Ptr{Ptr{Cvoid}}, env_var::Cstring, load_args::Cstring)::aeron_idle_strategy_func_t
end

function aeron_agent_on_start_load(name)
    @ccall AeronClient.aeron_agent_on_start_load(name::Cstring)::aeron_agent_on_start_func_t
end

function aeron_agent_init(runner, role_name, state, on_start, on_start_state, do_work, on_close, idle_strategy_func, idle_strategy_state)
    @ccall AeronClient.aeron_agent_init(runner::Ptr{aeron_agent_runner_t}, role_name::Cstring, state::Ptr{Cvoid}, on_start::aeron_agent_on_start_func_t, on_start_state::Ptr{Cvoid}, do_work::aeron_agent_do_work_func_t, on_close::aeron_agent_on_close_func_t, idle_strategy_func::aeron_idle_strategy_func_t, idle_strategy_state::Ptr{Cvoid})::Cint
end

function aeron_agent_start(runner)
    @ccall AeronClient.aeron_agent_start(runner::Ptr{aeron_agent_runner_t})::Cint
end

function aeron_agent_do_work(runner)
    @ccall AeronClient.aeron_agent_do_work(runner::Ptr{aeron_agent_runner_t})::Cint
end

function aeron_agent_is_running(runner)
    @ccall AeronClient.aeron_agent_is_running(runner::Ptr{aeron_agent_runner_t})::Bool
end

function aeron_agent_idle(runner, work_count)
    @ccall AeronClient.aeron_agent_idle(runner::Ptr{aeron_agent_runner_t}, work_count::Cint)::Cvoid
end

function aeron_agent_stop(runner)
    @ccall AeronClient.aeron_agent_stop(runner::Ptr{aeron_agent_runner_t})::Cint
end

function aeron_agent_close(runner)
    @ccall AeronClient.aeron_agent_close(runner::Ptr{aeron_agent_runner_t})::Cint
end

function aeron_is_directory(path)
    @ccall AeronClient.aeron_is_directory(path::Cstring)::Cint
end

function aeron_delete_directory(directory)
    @ccall AeronClient.aeron_delete_directory(directory::Cstring)::Cint
end

function aeron_map_new_file(mapped_file, path, fill_with_zeroes)
    @ccall AeronClient.aeron_map_new_file(mapped_file::Ptr{aeron_mapped_file_t}, path::Cstring, fill_with_zeroes::Bool)::Cint
end

function aeron_map_existing_file(mapped_file, path)
    @ccall AeronClient.aeron_map_existing_file(mapped_file::Ptr{aeron_mapped_file_t}, path::Cstring)::Cint
end

function aeron_unmap(mapped_file)
    @ccall AeronClient.aeron_unmap(mapped_file::Ptr{aeron_mapped_file_t})::Cint
end

# typedef uint64_t ( * aeron_usable_fs_space_func_t ) ( const char * path )
const aeron_usable_fs_space_func_t = Ptr{Cvoid}

function aeron_file_length(path)
    @ccall AeronClient.aeron_file_length(path::Cstring)::Int64
end

function aeron_usable_fs_space(path)
    @ccall AeronClient.aeron_usable_fs_space(path::Cstring)::UInt64
end

function aeron_usable_fs_space_disabled(path)
    @ccall AeronClient.aeron_usable_fs_space_disabled(path::Cstring)::UInt64
end

function aeron_ipc_publication_location(dst, length, aeron_dir, correlation_id)
    @ccall AeronClient.aeron_ipc_publication_location(dst::Cstring, length::Csize_t, aeron_dir::Cstring, correlation_id::Int64)::Cint
end

function aeron_network_publication_location(dst, length, aeron_dir, correlation_id)
    @ccall AeronClient.aeron_network_publication_location(dst::Cstring, length::Csize_t, aeron_dir::Cstring, correlation_id::Int64)::Cint
end

function aeron_publication_image_location(dst, length, aeron_dir, correlation_id)
    @ccall AeronClient.aeron_publication_image_location(dst::Cstring, length::Csize_t, aeron_dir::Cstring, correlation_id::Int64)::Cint
end

function aeron_temp_filename(filename, length)
    @ccall AeronClient.aeron_temp_filename(filename::Cstring, length::Csize_t)::Csize_t
end

# typedef int ( * aeron_raw_log_map_func_t ) ( aeron_mapped_raw_log_t * , const char * , bool , uint64_t , uint64_t )
const aeron_raw_log_map_func_t = Ptr{Cvoid}

# typedef int ( * aeron_raw_log_close_func_t ) ( aeron_mapped_raw_log_t * , const char * filename )
const aeron_raw_log_close_func_t = Ptr{Cvoid}

# typedef bool ( * aeron_raw_log_free_func_t ) ( aeron_mapped_raw_log_t * , const char * filename )
const aeron_raw_log_free_func_t = Ptr{Cvoid}

function aeron_raw_log_map(mapped_raw_log, path, use_sparse_files, term_length, page_size)
    @ccall AeronClient.aeron_raw_log_map(mapped_raw_log::Ptr{aeron_mapped_raw_log_t}, path::Cstring, use_sparse_files::Bool, term_length::UInt64, page_size::UInt64)::Cint
end

function aeron_raw_log_map_existing(mapped_raw_log, path, pre_touch)
    @ccall AeronClient.aeron_raw_log_map_existing(mapped_raw_log::Ptr{aeron_mapped_raw_log_t}, path::Cstring, pre_touch::Bool)::Cint
end

function aeron_raw_log_close(mapped_raw_log, filename)
    @ccall AeronClient.aeron_raw_log_close(mapped_raw_log::Ptr{aeron_mapped_raw_log_t}, filename::Cstring)::Cint
end

function aeron_raw_log_free(mapped_raw_log, filename)
    @ccall AeronClient.aeron_raw_log_free(mapped_raw_log::Ptr{aeron_mapped_raw_log_t}, filename::Cstring)::Bool
end

function aeron_file_resolve(parent, child, buffer, buffer_len)
    @ccall AeronClient.aeron_file_resolve(parent::Cstring, child::Cstring, buffer::Cstring, buffer_len::Csize_t)::Cint
end

@enum aeron_queue_offer_result_stct::Int32 begin
    AERON_OFFER_SUCCESS = 0
    AERON_OFFER_ERROR = -2
    AERON_OFFER_FULL = -1
end

const aeron_queue_offer_result_t = aeron_queue_offer_result_stct

# typedef void ( * aeron_queue_drain_func_t ) ( void * clientd , void * item )
const aeron_queue_drain_func_t = Ptr{Cvoid}

function aeron_mpsc_concurrent_array_queue_init(queue, length)
    @ccall AeronClient.aeron_mpsc_concurrent_array_queue_init(queue::Ptr{aeron_mpsc_concurrent_array_queue_t}, length::Csize_t)::Cint
end

function aeron_mpsc_concurrent_array_queue_close(queue)
    @ccall AeronClient.aeron_mpsc_concurrent_array_queue_close(queue::Ptr{aeron_mpsc_concurrent_array_queue_t})::Cint
end

function aeron_mpsc_concurrent_array_queue_offer(queue, element)
    @ccall AeronClient.aeron_mpsc_concurrent_array_queue_offer(queue::Ptr{aeron_mpsc_concurrent_array_queue_t}, element::Ptr{Cvoid})::aeron_queue_offer_result_t
end

function aeron_mpsc_concurrent_array_queue_drain(queue, func, clientd, limit)
    @ccall AeronClient.aeron_mpsc_concurrent_array_queue_drain(queue::Ptr{aeron_mpsc_concurrent_array_queue_t}, func::aeron_queue_drain_func_t, clientd::Ptr{Cvoid}, limit::Csize_t)::Csize_t
end

function aeron_mpsc_concurrent_array_queue_drain_all(queue, func, clientd)
    @ccall AeronClient.aeron_mpsc_concurrent_array_queue_drain_all(queue::Ptr{aeron_mpsc_concurrent_array_queue_t}, func::aeron_queue_drain_func_t, clientd::Ptr{Cvoid})::Csize_t
end

function aeron_mpsc_concurrent_array_queue_size(queue)
    @ccall AeronClient.aeron_mpsc_concurrent_array_queue_size(queue::Ptr{aeron_mpsc_concurrent_array_queue_t})::Csize_t
end

# typedef void ( * aeron_broadcast_receiver_handler_t ) ( int32_t type_id , uint8_t * buffer , size_t length , void * clientd )
const aeron_broadcast_receiver_handler_t = Ptr{Cvoid}

function aeron_broadcast_receiver_init(receiver, buffer, length)
    @ccall AeronClient.aeron_broadcast_receiver_init(receiver::Ptr{aeron_broadcast_receiver_t}, buffer::Ptr{Cvoid}, length::Csize_t)::Cint
end

function aeron_broadcast_receiver_validate_at(receiver, cursor)
    @ccall AeronClient.aeron_broadcast_receiver_validate_at(receiver::Ptr{aeron_broadcast_receiver_t}, cursor::Int64)::Bool
end

function aeron_broadcast_receiver_validate(receiver)
    @ccall AeronClient.aeron_broadcast_receiver_validate(receiver::Ptr{aeron_broadcast_receiver_t})::Bool
end

function aeron_broadcast_receiver_receive_next(receiver)
    @ccall AeronClient.aeron_broadcast_receiver_receive_next(receiver::Ptr{aeron_broadcast_receiver_t})::Bool
end

function aeron_broadcast_receiver_receive(receiver, handler, clientd)
    @ccall AeronClient.aeron_broadcast_receiver_receive(receiver::Ptr{aeron_broadcast_receiver_t}, handler::aeron_broadcast_receiver_handler_t, clientd::Ptr{Cvoid})::Cint
end

@enum aeron_rb_write_result_stct::Int32 begin
    AERON_RB_SUCCESS = 0
    AERON_RB_ERROR = -2
    AERON_RB_FULL = -1
end

const aeron_rb_write_result_t = aeron_rb_write_result_stct

# typedef void ( * aeron_rb_handler_t ) ( int32_t , const void * , size_t , void * )
const aeron_rb_handler_t = Ptr{Cvoid}

function aeron_mpsc_rb_init(ring_buffer, buffer, length)
    @ccall AeronClient.aeron_mpsc_rb_init(ring_buffer::Ptr{aeron_mpsc_rb_t}, buffer::Ptr{Cvoid}, length::Csize_t)::Cint
end

function aeron_mpsc_rb_write(ring_buffer, msg_type_id, msg, length)
    @ccall AeronClient.aeron_mpsc_rb_write(ring_buffer::Ptr{aeron_mpsc_rb_t}, msg_type_id::Int32, msg::Ptr{Cvoid}, length::Csize_t)::aeron_rb_write_result_t
end

function aeron_mpsc_rb_try_claim(ring_buffer, msg_type_id, length)
    @ccall AeronClient.aeron_mpsc_rb_try_claim(ring_buffer::Ptr{aeron_mpsc_rb_t}, msg_type_id::Int32, length::Csize_t)::Int32
end

function aeron_mpsc_rb_commit(ring_buffer, offset)
    @ccall AeronClient.aeron_mpsc_rb_commit(ring_buffer::Ptr{aeron_mpsc_rb_t}, offset::Int32)::Cint
end

function aeron_mpsc_rb_abort(ring_buffer, offset)
    @ccall AeronClient.aeron_mpsc_rb_abort(ring_buffer::Ptr{aeron_mpsc_rb_t}, offset::Int32)::Cint
end

function aeron_mpsc_rb_read(ring_buffer, handler, clientd, message_count_limit)
    @ccall AeronClient.aeron_mpsc_rb_read(ring_buffer::Ptr{aeron_mpsc_rb_t}, handler::aeron_rb_handler_t, clientd::Ptr{Cvoid}, message_count_limit::Csize_t)::Csize_t
end

function aeron_mpsc_rb_next_correlation_id(ring_buffer)
    @ccall AeronClient.aeron_mpsc_rb_next_correlation_id(ring_buffer::Ptr{aeron_mpsc_rb_t})::Int64
end

function aeron_mpsc_rb_consumer_heartbeat_time(ring_buffer, now_ms)
    @ccall AeronClient.aeron_mpsc_rb_consumer_heartbeat_time(ring_buffer::Ptr{aeron_mpsc_rb_t}, now_ms::Int64)::Cvoid
end

function aeron_mpsc_rb_consumer_heartbeat_time_value(ring_buffer)
    @ccall AeronClient.aeron_mpsc_rb_consumer_heartbeat_time_value(ring_buffer::Ptr{aeron_mpsc_rb_t})::Int64
end

function aeron_mpsc_rb_unblock(ring_buffer)
    @ccall AeronClient.aeron_mpsc_rb_unblock(ring_buffer::Ptr{aeron_mpsc_rb_t})::Bool
end

function aeron_mpsc_rb_consumer_position(ring_buffer)
    @ccall AeronClient.aeron_mpsc_rb_consumer_position(ring_buffer::Ptr{aeron_mpsc_rb_t})::Int64
end

function aeron_mpsc_rb_producer_position(ring_buffer)
    @ccall AeronClient.aeron_mpsc_rb_producer_position(ring_buffer::Ptr{aeron_mpsc_rb_t})::Int64
end

struct aeron_correlated_command_stct
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{aeron_correlated_command_stct}, f::Symbol)
    f === :client_id && return Ptr{Int64}(x + 0)
    f === :correlation_id && return Ptr{Int64}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_correlated_command_stct, f::Symbol)
    r = Ref{aeron_correlated_command_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_correlated_command_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_correlated_command_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_correlated_command_t = aeron_correlated_command_stct

struct aeron_publication_command_stct
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{aeron_publication_command_stct}, f::Symbol)
    f === :correlated && return Ptr{aeron_correlated_command_t}(x + 0)
    f === :stream_id && return Ptr{Int32}(x + 16)
    f === :channel_length && return Ptr{Int32}(x + 20)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_publication_command_stct, f::Symbol)
    r = Ref{aeron_publication_command_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_publication_command_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_publication_command_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_publication_command_t = aeron_publication_command_stct

struct aeron_publication_buffers_ready_stct
    data::NTuple{36, UInt8}
end

function Base.getproperty(x::Ptr{aeron_publication_buffers_ready_stct}, f::Symbol)
    f === :correlation_id && return Ptr{Int64}(x + 0)
    f === :registration_id && return Ptr{Int64}(x + 8)
    f === :session_id && return Ptr{Int32}(x + 16)
    f === :stream_id && return Ptr{Int32}(x + 20)
    f === :position_limit_counter_id && return Ptr{Int32}(x + 24)
    f === :channel_status_indicator_id && return Ptr{Int32}(x + 28)
    f === :log_file_length && return Ptr{Int32}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_publication_buffers_ready_stct, f::Symbol)
    r = Ref{aeron_publication_buffers_ready_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_publication_buffers_ready_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_publication_buffers_ready_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_publication_buffers_ready_t = aeron_publication_buffers_ready_stct

struct aeron_subscription_command_stct
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{aeron_subscription_command_stct}, f::Symbol)
    f === :correlated && return Ptr{aeron_correlated_command_t}(x + 0)
    f === :registration_correlation_id && return Ptr{Int64}(x + 16)
    f === :stream_id && return Ptr{Int32}(x + 24)
    f === :channel_length && return Ptr{Int32}(x + 28)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_subscription_command_stct, f::Symbol)
    r = Ref{aeron_subscription_command_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_subscription_command_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_subscription_command_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_subscription_command_t = aeron_subscription_command_stct

struct aeron_subscription_ready_stct
    data::NTuple{12, UInt8}
end

function Base.getproperty(x::Ptr{aeron_subscription_ready_stct}, f::Symbol)
    f === :correlation_id && return Ptr{Int64}(x + 0)
    f === :channel_status_indicator_id && return Ptr{Int32}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_subscription_ready_stct, f::Symbol)
    r = Ref{aeron_subscription_ready_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_subscription_ready_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_subscription_ready_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_subscription_ready_t = aeron_subscription_ready_stct

struct aeron_image_buffers_ready_stct
    data::NTuple{28, UInt8}
end

function Base.getproperty(x::Ptr{aeron_image_buffers_ready_stct}, f::Symbol)
    f === :correlation_id && return Ptr{Int64}(x + 0)
    f === :session_id && return Ptr{Int32}(x + 8)
    f === :stream_id && return Ptr{Int32}(x + 12)
    f === :subscriber_registration_id && return Ptr{Int64}(x + 16)
    f === :subscriber_position_id && return Ptr{Int32}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_image_buffers_ready_stct, f::Symbol)
    r = Ref{aeron_image_buffers_ready_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_image_buffers_ready_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_image_buffers_ready_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_image_buffers_ready_t = aeron_image_buffers_ready_stct

struct aeron_operation_succeeded_stct
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_operation_succeeded_stct}, f::Symbol)
    f === :correlation_id && return Ptr{Int64}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_operation_succeeded_stct, f::Symbol)
    r = Ref{aeron_operation_succeeded_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_operation_succeeded_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_operation_succeeded_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_operation_succeeded_t = aeron_operation_succeeded_stct

struct aeron_error_response_stct
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{aeron_error_response_stct}, f::Symbol)
    f === :offending_command_correlation_id && return Ptr{Int64}(x + 0)
    f === :error_code && return Ptr{Int32}(x + 8)
    f === :error_message_length && return Ptr{Int32}(x + 12)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_error_response_stct, f::Symbol)
    r = Ref{aeron_error_response_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_error_response_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_error_response_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_error_response_t = aeron_error_response_stct

struct aeron_remove_command_stct
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{aeron_remove_command_stct}, f::Symbol)
    f === :correlated && return Ptr{aeron_correlated_command_t}(x + 0)
    f === :registration_id && return Ptr{Int64}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_remove_command_stct, f::Symbol)
    r = Ref{aeron_remove_command_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_remove_command_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_remove_command_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_remove_command_t = aeron_remove_command_stct

struct aeron_image_message_stct
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{aeron_image_message_stct}, f::Symbol)
    f === :correlation_id && return Ptr{Int64}(x + 0)
    f === :subscription_registration_id && return Ptr{Int64}(x + 8)
    f === :stream_id && return Ptr{Int32}(x + 16)
    f === :channel_length && return Ptr{Int32}(x + 20)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_image_message_stct, f::Symbol)
    r = Ref{aeron_image_message_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_image_message_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_image_message_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_image_message_t = aeron_image_message_stct

struct aeron_destination_command_stct
    data::NTuple{28, UInt8}
end

function Base.getproperty(x::Ptr{aeron_destination_command_stct}, f::Symbol)
    f === :correlated && return Ptr{aeron_correlated_command_t}(x + 0)
    f === :registration_id && return Ptr{Int64}(x + 16)
    f === :channel_length && return Ptr{Int32}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_destination_command_stct, f::Symbol)
    r = Ref{aeron_destination_command_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_destination_command_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_destination_command_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_destination_command_t = aeron_destination_command_stct

struct aeron_counter_command_stct
    data::NTuple{20, UInt8}
end

function Base.getproperty(x::Ptr{aeron_counter_command_stct}, f::Symbol)
    f === :correlated && return Ptr{aeron_correlated_command_t}(x + 0)
    f === :type_id && return Ptr{Int32}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_counter_command_stct, f::Symbol)
    r = Ref{aeron_counter_command_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_counter_command_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_counter_command_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_counter_command_t = aeron_counter_command_stct

struct aeron_counter_update_stct
    data::NTuple{12, UInt8}
end

function Base.getproperty(x::Ptr{aeron_counter_update_stct}, f::Symbol)
    f === :correlation_id && return Ptr{Int64}(x + 0)
    f === :counter_id && return Ptr{Int32}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_counter_update_stct, f::Symbol)
    r = Ref{aeron_counter_update_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_counter_update_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_counter_update_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_counter_update_t = aeron_counter_update_stct

struct aeron_client_timeout_stct
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_client_timeout_stct}, f::Symbol)
    f === :client_id && return Ptr{Int64}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_client_timeout_stct, f::Symbol)
    r = Ref{aeron_client_timeout_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_client_timeout_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_client_timeout_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_client_timeout_t = aeron_client_timeout_stct

struct aeron_terminate_driver_command_stct
    data::NTuple{20, UInt8}
end

function Base.getproperty(x::Ptr{aeron_terminate_driver_command_stct}, f::Symbol)
    f === :correlated && return Ptr{aeron_correlated_command_t}(x + 0)
    f === :token_length && return Ptr{Int32}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_terminate_driver_command_stct, f::Symbol)
    r = Ref{aeron_terminate_driver_command_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_terminate_driver_command_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_terminate_driver_command_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_terminate_driver_command_t = aeron_terminate_driver_command_stct

struct aeron_stream_position_counter_key_layout_stct
    data::NTuple{112, UInt8}
end

function Base.getproperty(x::Ptr{aeron_stream_position_counter_key_layout_stct}, f::Symbol)
    f === :registration_id && return Ptr{Int64}(x + 0)
    f === :session_id && return Ptr{Int32}(x + 8)
    f === :stream_id && return Ptr{Int32}(x + 12)
    f === :channel_length && return Ptr{Int32}(x + 16)
    f === :channel && return Ptr{NTuple{92, Cchar}}(x + 20)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_stream_position_counter_key_layout_stct, f::Symbol)
    r = Ref{aeron_stream_position_counter_key_layout_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_stream_position_counter_key_layout_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_stream_position_counter_key_layout_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_stream_position_counter_key_layout_t = aeron_stream_position_counter_key_layout_stct

struct aeron_channel_endpoint_status_key_layout_stct
    data::NTuple{112, UInt8}
end

function Base.getproperty(x::Ptr{aeron_channel_endpoint_status_key_layout_stct}, f::Symbol)
    f === :channel_length && return Ptr{Int32}(x + 0)
    f === :channel && return Ptr{NTuple{108, Cchar}}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_channel_endpoint_status_key_layout_stct, f::Symbol)
    r = Ref{aeron_channel_endpoint_status_key_layout_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_channel_endpoint_status_key_layout_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_channel_endpoint_status_key_layout_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_channel_endpoint_status_key_layout_t = aeron_channel_endpoint_status_key_layout_stct

struct aeron_heartbeat_timestamp_key_layout_stct
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_heartbeat_timestamp_key_layout_stct}, f::Symbol)
    f === :registration_id && return Ptr{Int64}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_heartbeat_timestamp_key_layout_stct, f::Symbol)
    r = Ref{aeron_heartbeat_timestamp_key_layout_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_heartbeat_timestamp_key_layout_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_heartbeat_timestamp_key_layout_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_heartbeat_timestamp_key_layout_t = aeron_heartbeat_timestamp_key_layout_stct

struct aeron_local_sockaddr_key_layout_stct
    data::NTuple{112, UInt8}
end

function Base.getproperty(x::Ptr{aeron_local_sockaddr_key_layout_stct}, f::Symbol)
    f === :channel_status_id && return Ptr{Int32}(x + 0)
    f === :local_sockaddr_len && return Ptr{Int32}(x + 4)
    f === :local_sockaddr && return Ptr{NTuple{104, Cchar}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_local_sockaddr_key_layout_stct, f::Symbol)
    r = Ref{aeron_local_sockaddr_key_layout_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_local_sockaddr_key_layout_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_local_sockaddr_key_layout_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_local_sockaddr_key_layout_t = aeron_local_sockaddr_key_layout_stct

struct aeron_counters_manager_stct
    values::Ptr{UInt8}
    metadata::Ptr{UInt8}
    values_length::Csize_t
    metadata_length::Csize_t
    max_counter_id::Int32
    id_high_water_mark::Int32
    free_list::Ptr{Int32}
    free_list_index::Int32
    free_list_length::Csize_t
    cached_clock::Ptr{aeron_clock_cache_t}
    free_to_reuse_timeout_ms::Int64
end

const aeron_counters_manager_t = aeron_counters_manager_stct

function aeron_counters_manager_init(manager, metadata_buffer, metadata_length, values_buffer, values_length, cached_clock, free_to_reuse_timeout_ms)
    @ccall AeronClient.aeron_counters_manager_init(manager::Ptr{aeron_counters_manager_t}, metadata_buffer::Ptr{UInt8}, metadata_length::Csize_t, values_buffer::Ptr{UInt8}, values_length::Csize_t, cached_clock::Ptr{aeron_clock_cache_t}, free_to_reuse_timeout_ms::Int64)::Cint
end

function aeron_counters_manager_close(manager)
    @ccall AeronClient.aeron_counters_manager_close(manager::Ptr{aeron_counters_manager_t})::Cvoid
end

function aeron_counters_manager_allocate(manager, type_id, key, key_length, label, label_length)
    @ccall AeronClient.aeron_counters_manager_allocate(manager::Ptr{aeron_counters_manager_t}, type_id::Int32, key::Ptr{UInt8}, key_length::Csize_t, label::Cstring, label_length::Csize_t)::Int32
end

function aeron_counters_manager_counter_registration_id(manager, counter_id, registration_id)
    @ccall AeronClient.aeron_counters_manager_counter_registration_id(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32, registration_id::Int64)::Cvoid
end

function aeron_counters_manager_counter_owner_id(manager, counter_id, owner_id)
    @ccall AeronClient.aeron_counters_manager_counter_owner_id(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32, owner_id::Int64)::Cvoid
end

function aeron_counters_manager_update_label(manager, counter_id, label_length, label)
    @ccall AeronClient.aeron_counters_manager_update_label(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32, label_length::Csize_t, label::Cstring)::Cvoid
end

function aeron_counters_manager_append_to_label(manager, counter_id, length, value)
    @ccall AeronClient.aeron_counters_manager_append_to_label(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32, length::Csize_t, value::Cstring)::Cvoid
end

function aeron_counters_manager_next_counter_id(manager)
    @ccall AeronClient.aeron_counters_manager_next_counter_id(manager::Ptr{aeron_counters_manager_t})::Int32
end

function aeron_counters_manager_free(manager, counter_id)
    @ccall AeronClient.aeron_counters_manager_free(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32)::Cint
end

# typedef void ( * aeron_counters_reader_foreach_metadata_func_t ) ( int32_t id , int32_t type_id , const uint8_t * key , size_t key_length , const uint8_t * label , size_t label_length , void * clientd )
const aeron_counters_reader_foreach_metadata_func_t = Ptr{Cvoid}

function aeron_counters_reader_foreach_metadata(metadata_buffer, metadata_length, func, clientd)
    @ccall AeronClient.aeron_counters_reader_foreach_metadata(metadata_buffer::Ptr{UInt8}, metadata_length::Csize_t, func::aeron_counters_reader_foreach_metadata_func_t, clientd::Ptr{Cvoid})::Cvoid
end

function aeron_counters_manager_addr(counters_manager, counter_id)
    @ccall AeronClient.aeron_counters_manager_addr(counters_manager::Ptr{aeron_counters_manager_t}, counter_id::Int32)::Ptr{Int64}
end

function aeron_counters_reader_init(reader, metadata_buffer, metadata_length, values_buffer, values_length)
    @ccall AeronClient.aeron_counters_reader_init(reader::Ptr{aeron_counters_reader_t}, metadata_buffer::Ptr{UInt8}, metadata_length::Csize_t, values_buffer::Ptr{UInt8}, values_length::Csize_t)::Cint
end

function aeron_counter_set_ordered(addr, value)
    @ccall AeronClient.aeron_counter_set_ordered(addr::Ptr{Int64}, value::Int64)::Cvoid
end

function aeron_counter_get(addr)
    @ccall AeronClient.aeron_counter_get(addr::Ptr{Int64})::Int64
end

function aeron_counter_get_volatile(addr)
    @ccall AeronClient.aeron_counter_get_volatile(addr::Ptr{Int64})::Int64
end

function aeron_counter_increment(addr, value)
    @ccall AeronClient.aeron_counter_increment(addr::Ptr{Int64}, value::Int64)::Int64
end

function aeron_counter_ordered_increment(addr, value)
    @ccall AeronClient.aeron_counter_ordered_increment(addr::Ptr{Int64}, value::Int64)::Int64
end

function aeron_counter_add_ordered(addr, value)
    @ccall AeronClient.aeron_counter_add_ordered(addr::Ptr{Int64}, value::Int64)::Int64
end

function aeron_counter_propose_max_ordered(addr, proposed_value)
    @ccall AeronClient.aeron_counter_propose_max_ordered(addr::Ptr{Int64}, proposed_value::Int64)::Bool
end

function aeron_int64_to_ptr_hash_map_hash_key(key, mask)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_hash_key(key::Int64, mask::Csize_t)::Csize_t
end

function aeron_int64_to_ptr_hash_map_init(map, initial_capacity, load_factor)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_init(map::Ptr{aeron_int64_to_ptr_hash_map_t}, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

function aeron_int64_to_ptr_hash_map_delete(map)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_delete(map::Ptr{aeron_int64_to_ptr_hash_map_t})::Cvoid
end

function aeron_int64_to_ptr_hash_map_rehash(map, new_capacity)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_rehash(map::Ptr{aeron_int64_to_ptr_hash_map_t}, new_capacity::Csize_t)::Cint
end

function aeron_int64_to_ptr_hash_map_put(map, key, value)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_put(map::Ptr{aeron_int64_to_ptr_hash_map_t}, key::Int64, value::Ptr{Cvoid})::Cint
end

function aeron_int64_to_ptr_hash_map_get(map, key)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_get(map::Ptr{aeron_int64_to_ptr_hash_map_t}, key::Int64)::Ptr{Cvoid}
end

function aeron_int64_to_ptr_hash_map_compact_chain(map, delete_index)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_compact_chain(map::Ptr{aeron_int64_to_ptr_hash_map_t}, delete_index::Csize_t)::Cvoid
end

function aeron_int64_to_ptr_hash_map_remove(map, key)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_remove(map::Ptr{aeron_int64_to_ptr_hash_map_t}, key::Int64)::Ptr{Cvoid}
end

# typedef void ( * aeron_int64_to_ptr_hash_map_for_each_func_t ) ( void * clientd , int64_t key , void * value )
const aeron_int64_to_ptr_hash_map_for_each_func_t = Ptr{Cvoid}

# typedef bool ( * aeron_int64_to_ptr_hash_map_predicate_func_t ) ( void * clientd , int64_t key , void * value )
const aeron_int64_to_ptr_hash_map_predicate_func_t = Ptr{Cvoid}

function aeron_int64_to_ptr_hash_map_for_each(map, func, clientd)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_for_each(map::Ptr{aeron_int64_to_ptr_hash_map_t}, func::aeron_int64_to_ptr_hash_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

function aeron_int64_to_ptr_hash_map_remove_if(map, func, clientd)
    @ccall AeronClient.aeron_int64_to_ptr_hash_map_remove_if(map::Ptr{aeron_int64_to_ptr_hash_map_t}, func::aeron_int64_to_ptr_hash_map_predicate_func_t, clientd::Ptr{Cvoid})::Cvoid
end

@enum aeron_client_handler_cmd_type_en::UInt32 begin
    AERON_CLIENT_HANDLER_ADD_AVAILABLE_COUNTER = 0
    AERON_CLIENT_HANDLER_REMOVE_AVAILABLE_COUNTER = 1
    AERON_CLIENT_HANDLER_ADD_UNAVAILABLE_COUNTER = 2
    AERON_CLIENT_HANDLER_REMOVE_UNAVAILABLE_COUNTER = 3
    AERON_CLIENT_HANDLER_ADD_CLOSE_HANDLER = 4
    AERON_CLIENT_HANDLER_REMOVE_CLOSE_HANDLER = 5
end

const aeron_client_handler_cmd_type_t = aeron_client_handler_cmd_type_en

struct aeron_client_handler_un
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{aeron_client_handler_un}, f::Symbol)
    f === :on_available_counter && return Ptr{aeron_on_available_counter_t}(x + 0)
    f === :on_unavailable_counter && return Ptr{aeron_on_unavailable_counter_t}(x + 0)
    f === :on_close_handler && return Ptr{aeron_on_close_client_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_client_handler_un, f::Symbol)
    r = Ref{aeron_client_handler_un}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_client_handler_un}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_client_handler_un}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct aeron_client_handler_cmd_stct
    data::NTuple{48, UInt8}
end

function Base.getproperty(x::Ptr{aeron_client_handler_cmd_stct}, f::Symbol)
    f === :command_base && return Ptr{aeron_client_command_base_t}(x + 0)
    f === :handler && return Ptr{aeron_client_handler_un}(x + 24)
    f === :clientd && return Ptr{Ptr{Cvoid}}(x + 32)
    f === :type && return Ptr{aeron_client_handler_cmd_type_t}(x + 40)
    f === :processed && return Ptr{Bool}(x + 44)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_client_handler_cmd_stct, f::Symbol)
    r = Ref{aeron_client_handler_cmd_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_client_handler_cmd_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_client_handler_cmd_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_client_handler_cmd_t = aeron_client_handler_cmd_stct

function aeron_client_conductor_init(conductor, context)
    @ccall AeronClient.aeron_client_conductor_init(conductor::Ptr{aeron_client_conductor_t}, context::Ptr{aeron_context_t})::Cint
end

function aeron_client_conductor_do_work(conductor)
    @ccall AeronClient.aeron_client_conductor_do_work(conductor::Ptr{aeron_client_conductor_t})::Cint
end

function aeron_client_conductor_on_close(conductor)
    @ccall AeronClient.aeron_client_conductor_on_close(conductor::Ptr{aeron_client_conductor_t})::Cvoid
end

function aeron_client_conductor_force_close_resources(conductor)
    @ccall AeronClient.aeron_client_conductor_force_close_resources(conductor::Ptr{aeron_client_conductor_t})::Cvoid
end

function aeron_client_conductor_on_cmd_add_publication(clientd, item)
    @ccall AeronClient.aeron_client_conductor_on_cmd_add_publication(clientd::Ptr{Cvoid}, item::Ptr{Cvoid})::Cvoid
end

function aeron_client_conductor_on_cmd_close_publication(clientd, item)
    @ccall AeronClient.aeron_client_conductor_on_cmd_close_publication(clientd::Ptr{Cvoid}, item::Ptr{Cvoid})::Cvoid
end

function aeron_client_conductor_async_add_publication(async, conductor, uri, stream_id)
    @ccall AeronClient.aeron_client_conductor_async_add_publication(async::Ptr{Ptr{aeron_async_add_publication_t}}, conductor::Ptr{aeron_client_conductor_t}, uri::Cstring, stream_id::Int32)::Cint
end

function aeron_client_conductor_async_close_publication(conductor, publication, on_close_complete, on_close_complete_clientd)
    @ccall AeronClient.aeron_client_conductor_async_close_publication(conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_publication_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

function aeron_client_conductor_async_add_exclusive_publication(async, conductor, uri, stream_id)
    @ccall AeronClient.aeron_client_conductor_async_add_exclusive_publication(async::Ptr{Ptr{aeron_async_add_exclusive_publication_t}}, conductor::Ptr{aeron_client_conductor_t}, uri::Cstring, stream_id::Int32)::Cint
end

function aeron_client_conductor_async_close_exclusive_publication(conductor, publication, on_close_complete, on_close_complete_clientd)
    @ccall AeronClient.aeron_client_conductor_async_close_exclusive_publication(conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_exclusive_publication_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

function aeron_client_conductor_async_add_subscription(async, conductor, uri, stream_id, on_available_image_handler, on_available_image_clientd, on_unavailable_image_handler, on_unavailable_image_clientd)
    @ccall AeronClient.aeron_client_conductor_async_add_subscription(async::Ptr{Ptr{aeron_async_add_subscription_t}}, conductor::Ptr{aeron_client_conductor_t}, uri::Cstring, stream_id::Int32, on_available_image_handler::aeron_on_available_image_t, on_available_image_clientd::Ptr{Cvoid}, on_unavailable_image_handler::aeron_on_unavailable_image_t, on_unavailable_image_clientd::Ptr{Cvoid})::Cint
end

function aeron_client_conductor_async_close_subscription(conductor, subscription, on_close_complete, on_close_complete_clientd)
    @ccall AeronClient.aeron_client_conductor_async_close_subscription(conductor::Ptr{aeron_client_conductor_t}, subscription::Ptr{aeron_subscription_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

function aeron_client_conductor_async_add_counter(async, conductor, type_id, key_buffer, key_buffer_length, label_buffer, label_buffer_length)
    @ccall AeronClient.aeron_client_conductor_async_add_counter(async::Ptr{Ptr{aeron_async_add_counter_t}}, conductor::Ptr{aeron_client_conductor_t}, type_id::Int32, key_buffer::Ptr{UInt8}, key_buffer_length::Csize_t, label_buffer::Cstring, label_buffer_length::Csize_t)::Cint
end

function aeron_client_conductor_async_close_counter(conductor, counter, on_close_complete, on_close_complete_clientd)
    @ccall AeronClient.aeron_client_conductor_async_close_counter(conductor::Ptr{aeron_client_conductor_t}, counter::Ptr{aeron_counter_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

function aeron_client_conductor_async_add_publication_destination(async, conductor, publication, uri)
    @ccall AeronClient.aeron_client_conductor_async_add_publication_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_publication_t}, uri::Cstring)::Cint
end

function aeron_client_conductor_async_remove_publication_destination(async, conductor, publication, uri)
    @ccall AeronClient.aeron_client_conductor_async_remove_publication_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_publication_t}, uri::Cstring)::Cint
end

function aeron_client_conductor_async_add_exclusive_publication_destination(async, conductor, publication, uri)
    @ccall AeronClient.aeron_client_conductor_async_add_exclusive_publication_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_exclusive_publication_t}, uri::Cstring)::Cint
end

function aeron_client_conductor_async_remove_exclusive_publication_destination(async, conductor, publication, uri)
    @ccall AeronClient.aeron_client_conductor_async_remove_exclusive_publication_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_exclusive_publication_t}, uri::Cstring)::Cint
end

function aeron_client_conductor_async_add_subscription_destination(async, conductor, subscription, uri)
    @ccall AeronClient.aeron_client_conductor_async_add_subscription_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, subscription::Ptr{aeron_subscription_t}, uri::Cstring)::Cint
end

function aeron_client_conductor_async_remove_subscription_destination(async, conductor, subscription, uri)
    @ccall AeronClient.aeron_client_conductor_async_remove_subscription_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, subscription::Ptr{aeron_subscription_t}, uri::Cstring)::Cint
end

function aeron_client_conductor_async_handler(conductor, cmd)
    @ccall AeronClient.aeron_client_conductor_async_handler(conductor::Ptr{aeron_client_conductor_t}, cmd::Ptr{aeron_client_handler_cmd_t})::Cint
end

function aeron_client_conductor_on_error(conductor, response)
    @ccall AeronClient.aeron_client_conductor_on_error(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_error_response_t})::Cint
end

function aeron_client_conductor_on_publication_ready(conductor, response)
    @ccall AeronClient.aeron_client_conductor_on_publication_ready(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_publication_buffers_ready_t})::Cint
end

function aeron_client_conductor_on_subscription_ready(conductor, response)
    @ccall AeronClient.aeron_client_conductor_on_subscription_ready(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_subscription_ready_t})::Cint
end

function aeron_client_conductor_on_operation_success(conductor, response)
    @ccall AeronClient.aeron_client_conductor_on_operation_success(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_operation_succeeded_t})::Cint
end

function aeron_client_conductor_on_available_image(conductor, response, log_file_length, log_file, source_identity_length, source_identity)
    @ccall AeronClient.aeron_client_conductor_on_available_image(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_image_buffers_ready_t}, log_file_length::Int32, log_file::Cstring, source_identity_length::Int32, source_identity::Cstring)::Cint
end

function aeron_client_conductor_on_unavailable_image(conductor, response)
    @ccall AeronClient.aeron_client_conductor_on_unavailable_image(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_image_message_t})::Cint
end

function aeron_client_conductor_on_counter_ready(conductor, response)
    @ccall AeronClient.aeron_client_conductor_on_counter_ready(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_counter_update_t})::Cint
end

function aeron_client_conductor_on_unavailable_counter(conductor, response)
    @ccall AeronClient.aeron_client_conductor_on_unavailable_counter(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_counter_update_t})::Cint
end

function aeron_client_conductor_on_client_timeout(conductor, response)
    @ccall AeronClient.aeron_client_conductor_on_client_timeout(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_client_timeout_t})::Cint
end

function aeron_client_conductor_get_or_create_log_buffer(conductor, log_buffer, log_file, original_registration_id, pre_touch)
    @ccall AeronClient.aeron_client_conductor_get_or_create_log_buffer(conductor::Ptr{aeron_client_conductor_t}, log_buffer::Ptr{Ptr{aeron_log_buffer_t}}, log_file::Cstring, original_registration_id::Int64, pre_touch::Bool)::Cint
end

function aeron_client_conductor_release_log_buffer(conductor, log_buffer)
    @ccall AeronClient.aeron_client_conductor_release_log_buffer(conductor::Ptr{aeron_client_conductor_t}, log_buffer::Ptr{aeron_log_buffer_t})::Cint
end

function aeron_client_conductor_linger_image(conductor, image)
    @ccall AeronClient.aeron_client_conductor_linger_image(conductor::Ptr{aeron_client_conductor_t}, image::Ptr{aeron_image_t})::Cint
end

function aeron_client_conductor_offer_remove_command(conductor, registration_id, command_type)
    @ccall AeronClient.aeron_client_conductor_offer_remove_command(conductor::Ptr{aeron_client_conductor_t}, registration_id::Int64, command_type::Int32)::Cint
end

function aeron_client_conductor_offer_destination_command(conductor, registration_id, command_type, uri, correlation_id)
    @ccall AeronClient.aeron_client_conductor_offer_destination_command(conductor::Ptr{aeron_client_conductor_t}, registration_id::Int64, command_type::Int32, uri::Cstring, correlation_id::Ptr{Int64})::Cint
end

function aeron_counter_heartbeat_timestamp_find_counter_id_by_registration_id(counters_reader, type_id, registration_id)
    @ccall AeronClient.aeron_counter_heartbeat_timestamp_find_counter_id_by_registration_id(counters_reader::Ptr{aeron_counters_reader_t}, type_id::Int32, registration_id::Int64)::Cint
end

function aeron_counter_heartbeat_timestamp_is_active(counters_reader, counter_id, type_id, registration_id)
    @ccall AeronClient.aeron_counter_heartbeat_timestamp_is_active(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, type_id::Int32, registration_id::Int64)::Bool
end

function aeron_client_conductor_notify_close_handlers(conductor)
    @ccall AeronClient.aeron_client_conductor_notify_close_handlers(conductor::Ptr{aeron_client_conductor_t})::Cvoid
end

function aeron_client_conductor_is_closed(conductor)
    @ccall AeronClient.aeron_client_conductor_is_closed(conductor::Ptr{aeron_client_conductor_t})::Bool
end

function aeron_subscription_create(subscription, conductor, channel, stream_id, registration_id, channel_status_indicator_id, channel_status_indicator_addr, on_available_image, on_available_image_clientd, on_unavailable_image, on_unavailable_image_clientd)
    @ccall AeronClient.aeron_subscription_create(subscription::Ptr{Ptr{aeron_subscription_t}}, conductor::Ptr{aeron_client_conductor_t}, channel::Cstring, stream_id::Int32, registration_id::Int64, channel_status_indicator_id::Int32, channel_status_indicator_addr::Ptr{Int64}, on_available_image::aeron_on_available_image_t, on_available_image_clientd::Ptr{Cvoid}, on_unavailable_image::aeron_on_unavailable_image_t, on_unavailable_image_clientd::Ptr{Cvoid})::Cint
end

function aeron_subscription_delete(subscription)
    @ccall AeronClient.aeron_subscription_delete(subscription::Ptr{aeron_subscription_t})::Cint
end

function aeron_subscription_force_close(subscription)
    @ccall AeronClient.aeron_subscription_force_close(subscription::Ptr{aeron_subscription_t})::Cvoid
end

function aeron_subscription_alloc_image_list(image_list, length)
    @ccall AeronClient.aeron_subscription_alloc_image_list(image_list::Ptr{Ptr{aeron_image_list_t}}, length::Csize_t)::Cint
end

function aeron_client_conductor_subscription_add_image(subscription, image)
    @ccall AeronClient.aeron_client_conductor_subscription_add_image(subscription::Ptr{aeron_subscription_t}, image::Ptr{aeron_image_t})::Cint
end

function aeron_client_conductor_subscription_remove_image(subscription, image)
    @ccall AeronClient.aeron_client_conductor_subscription_remove_image(subscription::Ptr{aeron_subscription_t}, image::Ptr{aeron_image_t})::Cint
end

function aeron_client_conductor_subscription_image_list(subscription)
    @ccall AeronClient.aeron_client_conductor_subscription_image_list(subscription::Ptr{aeron_subscription_t})::Ptr{aeron_image_list_t}
end

function aeron_client_conductor_subscription_install_new_image_list(subscription, image_list)
    @ccall AeronClient.aeron_client_conductor_subscription_install_new_image_list(subscription::Ptr{aeron_subscription_t}, image_list::Ptr{aeron_image_list_t})::Cint
end

function aeron_client_conductor_subscription_prune_image_lists(subscription)
    @ccall AeronClient.aeron_client_conductor_subscription_prune_image_lists(subscription::Ptr{aeron_subscription_t})::Cint
end

function aeron_subscription_find_image_index(image_list, image)
    @ccall AeronClient.aeron_subscription_find_image_index(image_list::Ptr{aeron_image_list_t}, image::Ptr{aeron_image_t})::Cint
end

function aeron_subscription_last_image_list_change_number(subscription)
    @ccall AeronClient.aeron_subscription_last_image_list_change_number(subscription::Ptr{aeron_subscription_t})::Int64
end

function aeron_subscription_propose_last_image_change_number(subscription, change_number)
    @ccall AeronClient.aeron_subscription_propose_last_image_change_number(subscription::Ptr{aeron_subscription_t}, change_number::Int64)::Cvoid
end

function aeron_format_date(str, count, timestamp)
    @ccall AeronClient.aeron_format_date(str::Cstring, count::Csize_t, timestamp::Int64)::Cvoid
end

function aeron_format_number_to_locale(value, buffer, buffer_len)
    @ccall AeronClient.aeron_format_number_to_locale(value::Clonglong, buffer::Cstring, buffer_len::Csize_t)::Cstring
end

function aeron_format_to_hex(str, str_length, data, data_len)
    @ccall AeronClient.aeron_format_to_hex(str::Cstring, str_length::Csize_t, data::Ptr{UInt8}, data_len::Csize_t)::Cvoid
end

function aeron_fnv_64a_buf(buf, len)
    @ccall AeronClient.aeron_fnv_64a_buf(buf::Ptr{UInt8}, len::Csize_t)::UInt64
end

function aeron_tokenise(input, delimiter, max_tokens, tokens)
    @ccall AeronClient.aeron_tokenise(input::Cstring, delimiter::Cchar, max_tokens::Cint, tokens::Ptr{Cstring})::Cint
end

function aeron_str_length(str, length_bound, length)
    @ccall AeronClient.aeron_str_length(str::Cstring, length_bound::Csize_t, length::Ptr{Csize_t})::Bool
end

struct aeron_array_to_ptr_hash_map_key_stct
    arr::Ptr{UInt8}
    hash_code::UInt64
    arr_length::Csize_t
end

const aeron_array_to_ptr_hash_map_key_t = aeron_array_to_ptr_hash_map_key_stct

struct aeron_array_to_ptr_hash_map_stct
    keys::Ptr{aeron_array_to_ptr_hash_map_key_t}
    values::Ptr{Ptr{Cvoid}}
    load_factor::Cfloat
    capacity::Csize_t
    size::Csize_t
    resize_threshold::Csize_t
end

const aeron_array_to_ptr_hash_map_t = aeron_array_to_ptr_hash_map_stct

function aeron_array_hash(arr, length)
    @ccall AeronClient.aeron_array_hash(arr::Ptr{UInt8}, length::Csize_t)::UInt64
end

function aeron_array_to_ptr_hash_map_hash_key(key_hash_code, mask)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_hash_key(key_hash_code::UInt64, mask::Csize_t)::Csize_t
end

function aeron_array_to_ptr_hash_map_compare(key, key_arr, key_arr_len, key_hash_code)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_compare(key::Ptr{aeron_array_to_ptr_hash_map_key_t}, key_arr::Ptr{UInt8}, key_arr_len::Csize_t, key_hash_code::UInt64)::Bool
end

function aeron_array_to_ptr_hash_map_init(map, initial_capacity, load_factor)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_init(map::Ptr{aeron_array_to_ptr_hash_map_t}, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

function aeron_array_to_ptr_hash_map_delete(map)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_delete(map::Ptr{aeron_array_to_ptr_hash_map_t})::Cvoid
end

function aeron_array_to_ptr_hash_map_rehash(map, new_capacity)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_rehash(map::Ptr{aeron_array_to_ptr_hash_map_t}, new_capacity::Csize_t)::Cint
end

function aeron_array_to_ptr_hash_map_put(map, key, key_len, value)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_put(map::Ptr{aeron_array_to_ptr_hash_map_t}, key::Ptr{UInt8}, key_len::Csize_t, value::Ptr{Cvoid})::Cint
end

function aeron_array_to_ptr_hash_map_get(map, key, key_len)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_get(map::Ptr{aeron_array_to_ptr_hash_map_t}, key::Ptr{UInt8}, key_len::Csize_t)::Ptr{Cvoid}
end

function aeron_array_to_ptr_hash_map_compact_chain(map, delete_index)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_compact_chain(map::Ptr{aeron_array_to_ptr_hash_map_t}, delete_index::Csize_t)::Cvoid
end

function aeron_array_to_ptr_hash_map_remove(map, key, key_len)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_remove(map::Ptr{aeron_array_to_ptr_hash_map_t}, key::Ptr{UInt8}, key_len::Csize_t)::Ptr{Cvoid}
end

# typedef void ( * aeron_array_to_ptr_hash_map_for_each_func_t ) ( void * clientd , const uint8_t * key , size_t key_len , void * value )
const aeron_array_to_ptr_hash_map_for_each_func_t = Ptr{Cvoid}

function aeron_array_to_ptr_hash_map_for_each(map, func, clientd)
    @ccall AeronClient.aeron_array_to_ptr_hash_map_for_each(map::Ptr{aeron_array_to_ptr_hash_map_t}, func::aeron_array_to_ptr_hash_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

@enum aeron_term_unblocker_status_enum::UInt32 begin
    AERON_TERM_UNBLOCKER_STATUS_NO_ACTION = 0
    AERON_TERM_UNBLOCKER_STATUS_UNBLOCKED = 1
    AERON_TERM_UNBLOCKER_STATUS_UNBLOCKED_TO_END = 2
end

const aeron_term_unblocker_status_t = aeron_term_unblocker_status_enum

function aeron_term_unblocker_unblock(log_meta_data, buffer, term_length, blocked_offset, tail_offset, term_id)
    @ccall AeronClient.aeron_term_unblocker_unblock(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, buffer::Ptr{UInt8}, term_length::Csize_t, blocked_offset::Int32, tail_offset::Int32, term_id::Int32)::aeron_term_unblocker_status_t
end

function aeron_env_set(key, val)
    @ccall AeronClient.aeron_env_set(key::Cstring, val::Cstring)::Cint
end

function aeron_env_unset(key)
    @ccall AeronClient.aeron_env_unset(key::Cstring)::Cint
end

struct var"##Ctag#7689"
    tail::UInt64
    head_cache::UInt64
    padding::NTuple{48, Int8}
end
function Base.getproperty(x::Ptr{var"##Ctag#7689"}, f::Symbol)
    f === :tail && return Ptr{UInt64}(x + 0)
    f === :head_cache && return Ptr{UInt64}(x + 8)
    f === :padding && return Ptr{NTuple{48, Int8}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#7689", f::Symbol)
    r = Ref{var"##Ctag#7689"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#7689"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#7689"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct aeron_spsc_concurrent_array_queue_stct
    data::NTuple{208, UInt8}
end

function Base.getproperty(x::Ptr{aeron_spsc_concurrent_array_queue_stct}, f::Symbol)
    f === :padding && return Ptr{NTuple{56, Int8}}(x + 0)
    f === :producer && return Ptr{var"##Ctag#7689"}(x + 56)
    f === :consumer && return Ptr{var"##Ctag#7690"}(x + 120)
    f === :capacity && return Ptr{Csize_t}(x + 184)
    f === :mask && return Ptr{Csize_t}(x + 192)
    f === :buffer && return Ptr{Ptr{Ptr{Cvoid}}}(x + 200)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_spsc_concurrent_array_queue_stct, f::Symbol)
    r = Ref{aeron_spsc_concurrent_array_queue_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_spsc_concurrent_array_queue_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_spsc_concurrent_array_queue_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_spsc_concurrent_array_queue_t = aeron_spsc_concurrent_array_queue_stct

function aeron_spsc_concurrent_array_queue_init(queue, length)
    @ccall AeronClient.aeron_spsc_concurrent_array_queue_init(queue::Ptr{aeron_spsc_concurrent_array_queue_t}, length::Csize_t)::Cint
end

function aeron_spsc_concurrent_array_queue_close(queue)
    @ccall AeronClient.aeron_spsc_concurrent_array_queue_close(queue::Ptr{aeron_spsc_concurrent_array_queue_t})::Cint
end

function aeron_spsc_concurrent_array_queue_offer(queue, element)
    @ccall AeronClient.aeron_spsc_concurrent_array_queue_offer(queue::Ptr{aeron_spsc_concurrent_array_queue_t}, element::Ptr{Cvoid})::aeron_queue_offer_result_t
end

function aeron_spsc_concurrent_array_queue_poll(queue)
    @ccall AeronClient.aeron_spsc_concurrent_array_queue_poll(queue::Ptr{aeron_spsc_concurrent_array_queue_t})::Ptr{Cvoid}
end

function aeron_spsc_concurrent_array_queue_drain(queue, func, clientd, limit)
    @ccall AeronClient.aeron_spsc_concurrent_array_queue_drain(queue::Ptr{aeron_spsc_concurrent_array_queue_t}, func::aeron_queue_drain_func_t, clientd::Ptr{Cvoid}, limit::Csize_t)::Csize_t
end

function aeron_spsc_concurrent_array_queue_drain_all(queue, func, clientd)
    @ccall AeronClient.aeron_spsc_concurrent_array_queue_drain_all(queue::Ptr{aeron_spsc_concurrent_array_queue_t}, func::aeron_queue_drain_func_t, clientd::Ptr{Cvoid})::Csize_t
end

function aeron_spsc_concurrent_array_queue_size(queue)
    @ccall AeronClient.aeron_spsc_concurrent_array_queue_size(queue::Ptr{aeron_spsc_concurrent_array_queue_t})::Csize_t
end

struct aeron_broadcast_transmitter_stct
    buffer::Ptr{UInt8}
    descriptor::Ptr{aeron_broadcast_descriptor_t}
    capacity::Csize_t
    max_message_length::Csize_t
end

const aeron_broadcast_transmitter_t = aeron_broadcast_transmitter_stct

function aeron_broadcast_transmitter_init(transmitter, buffer, length)
    @ccall AeronClient.aeron_broadcast_transmitter_init(transmitter::Ptr{aeron_broadcast_transmitter_t}, buffer::Ptr{Cvoid}, length::Csize_t)::Cint
end

function aeron_broadcast_transmitter_transmit(transmitter, msg_type_id, msg, length)
    @ccall AeronClient.aeron_broadcast_transmitter_transmit(transmitter::Ptr{aeron_broadcast_transmitter_t}, msg_type_id::Int32, msg::Ptr{Cvoid}, length::Csize_t)::Cint
end

function aeron_exclusive_publication_create(publication, conductor, channel, stream_id, session_id, position_limit_counter_id, position_limit_addr, channel_status_indicator_id, channel_status_addr, log_buffer, original_registration_id, registration_id)
    @ccall AeronClient.aeron_exclusive_publication_create(publication::Ptr{Ptr{aeron_exclusive_publication_t}}, conductor::Ptr{aeron_client_conductor_t}, channel::Cstring, stream_id::Int32, session_id::Int32, position_limit_counter_id::Int32, position_limit_addr::Ptr{Int64}, channel_status_indicator_id::Int32, channel_status_addr::Ptr{Int64}, log_buffer::Ptr{aeron_log_buffer_t}, original_registration_id::Int64, registration_id::Int64)::Cint
end

function aeron_exclusive_publication_delete(publication)
    @ccall AeronClient.aeron_exclusive_publication_delete(publication::Ptr{aeron_exclusive_publication_t})::Cint
end

function aeron_exclusive_publication_force_close(publication)
    @ccall AeronClient.aeron_exclusive_publication_force_close(publication::Ptr{aeron_exclusive_publication_t})::Cvoid
end

function aeron_exclusive_publication_rotate_term(publication)
    @ccall AeronClient.aeron_exclusive_publication_rotate_term(publication::Ptr{aeron_exclusive_publication_t})::Cvoid
end

function aeron_exclusive_publication_new_position(publication, resulting_offset)
    @ccall AeronClient.aeron_exclusive_publication_new_position(publication::Ptr{aeron_exclusive_publication_t}, resulting_offset::Int32)::Int64
end

function aeron_exclusive_publication_back_pressure_status(publication, current_position, message_length)
    @ccall AeronClient.aeron_exclusive_publication_back_pressure_status(publication::Ptr{aeron_exclusive_publication_t}, current_position::Int64, message_length::Int32)::Int64
end

const aeron_socket_t = Cint

function aeron_set_socket_non_blocking(fd)
    @ccall AeronClient.aeron_set_socket_non_blocking(fd::aeron_socket_t)::Cint
end

function aeron_socket(domain, type, protocol)
    @ccall AeronClient.aeron_socket(domain::Cint, type::Cint, protocol::Cint)::aeron_socket_t
end

function aeron_close_socket(socket)
    @ccall AeronClient.aeron_close_socket(socket::aeron_socket_t)::Cvoid
end

function aeron_connect(fd, address, address_length)
    @ccall AeronClient.aeron_connect(fd::aeron_socket_t, address::Ptr{sockaddr}, address_length::socklen_t)::Cint
end

function aeron_bind(fd, address, address_length)
    @ccall AeronClient.aeron_bind(fd::aeron_socket_t, address::Ptr{sockaddr}, address_length::socklen_t)::Cint
end

function aeron_net_init()
    @ccall AeronClient.aeron_net_init()::Cint
end

function aeron_getsockopt(fd, level, optname, optval, optlen)
    @ccall AeronClient.aeron_getsockopt(fd::aeron_socket_t, level::Cint, optname::Cint, optval::Ptr{Cvoid}, optlen::Ptr{socklen_t})::Cint
end

function aeron_setsockopt(fd, level, optname, optval, optlen)
    @ccall AeronClient.aeron_setsockopt(fd::aeron_socket_t, level::Cint, optname::Cint, optval::Ptr{Cvoid}, optlen::socklen_t)::Cint
end

function aeron_getifaddrs(ifap)
    @ccall AeronClient.aeron_getifaddrs(ifap::Ptr{Ptr{ifaddrs}})::Cint
end

function aeron_freeifaddrs(ifa)
    @ccall AeronClient.aeron_freeifaddrs(ifa::Ptr{ifaddrs})::Cvoid
end

function aeron_sendmsg(fd, msghdr, flags)
    @ccall AeronClient.aeron_sendmsg(fd::aeron_socket_t, msghdr::Ptr{Cvoid}, flags::Cint)::Cssize_t
end

function aeron_send(fd, buf, len, flags)
    @ccall AeronClient.aeron_send(fd::aeron_socket_t, buf::Ptr{Cvoid}, len::Csize_t, flags::Cint)::Cssize_t
end

function aeron_recvmsg(fd, msghdr, flags)
    @ccall AeronClient.aeron_recvmsg(fd::aeron_socket_t, msghdr::Ptr{Cvoid}, flags::Cint)::Cssize_t
end

function aeron_poll(fds, nfds, timeout)
    @ccall AeronClient.aeron_poll(fds::Ptr{Cvoid}, nfds::Culong, timeout::Cint)::Cint
end

struct aeron_parsed_address_stct
    host::NTuple{384, Cchar}
    port::NTuple{8, Cchar}
    ip_version_hint::Cint
end

const aeron_parsed_address_t = aeron_parsed_address_stct

struct aeron_parsed_interface_stct
    host::NTuple{384, Cchar}
    port::NTuple{8, Cchar}
    prefix::NTuple{8, Cchar}
    ip_version_hint::Cint
end

const aeron_parsed_interface_t = aeron_parsed_interface_stct

function aeron_parse_size64(str, result)
    @ccall AeronClient.aeron_parse_size64(str::Cstring, result::Ptr{UInt64})::Cint
end

function aeron_parse_duration_ns(str, result)
    @ccall AeronClient.aeron_parse_duration_ns(str::Cstring, result::Ptr{UInt64})::Cint
end

function aeron_parse_bool(str, def)
    @ccall AeronClient.aeron_parse_bool(str::Cstring, def::Bool)::Bool
end

function aeron_address_split(address_str, parsed_address)
    @ccall AeronClient.aeron_address_split(address_str::Cstring, parsed_address::Ptr{aeron_parsed_address_t})::Cint
end

function aeron_interface_split(interface_str, parsed_interface)
    @ccall AeronClient.aeron_interface_split(interface_str::Cstring, parsed_interface::Ptr{aeron_parsed_interface_t})::Cint
end

function aeron_parse_get_line(line, max_length, buffer)
    @ccall AeronClient.aeron_parse_get_line(line::Cstring, max_length::Csize_t, buffer::Cstring)::Cint
end

struct aeron_http_parsed_url_stct
    userinfo::NTuple{384, Cchar}
    host_and_port::NTuple{393, Cchar}
    path_and_query::NTuple{512, Cchar}
    address::sockaddr_storage
    ip_version_hint::Cint
end

const aeron_http_parsed_url_t = aeron_http_parsed_url_stct

function aeron_http_parse_url(url, parsed_url)
    @ccall AeronClient.aeron_http_parse_url(url::Cstring, parsed_url::Ptr{aeron_http_parsed_url_t})::Cint
end

struct aeron_http_response_stct
    buffer::Cstring
    cursor::Csize_t
    headers_offset::Csize_t
    body_offset::Csize_t
    length::Csize_t
    capacity::Csize_t
    status_code::Csize_t
    content_length::Csize_t
    is_complete::Bool
    parse_err::Bool
end

const aeron_http_response_t = aeron_http_response_stct

function aeron_http_response_delete(response)
    @ccall AeronClient.aeron_http_response_delete(response::Ptr{aeron_http_response_t})::Cvoid
end

function aeron_http_retrieve(response, url, timeout_ns)
    @ccall AeronClient.aeron_http_retrieve(response::Ptr{Ptr{aeron_http_response_t}}, url::Cstring, timeout_ns::Int64)::Cint
end

function aeron_http_header_get(response, header_name, line, max_length)
    @ccall AeronClient.aeron_http_header_get(response::Ptr{aeron_http_response_t}, header_name::Cstring, line::Cstring, max_length::Csize_t)::Cint
end

function aeron_array_ensure_capacity(array, element_size, old_capacity, new_capacity)
    @ccall AeronClient.aeron_array_ensure_capacity(array::Ptr{Ptr{UInt8}}, element_size::Csize_t, old_capacity::Csize_t, new_capacity::Csize_t)::Cint
end

function aeron_array_fast_unordered_remove(array, element_size, index, last_index)
    @ccall AeronClient.aeron_array_fast_unordered_remove(array::Ptr{UInt8}, element_size::Csize_t, index::Csize_t, last_index::Csize_t)::Cvoid
end

function aeron_array_add(array, element_size, new_length, element_to_add)
    @ccall AeronClient.aeron_array_add(array::Ptr{Ptr{UInt8}}, element_size::Csize_t, new_length::Csize_t, element_to_add::Ptr{UInt8})::Cint
end

function aeron_array_remove(array, element_size, index, old_length)
    @ccall AeronClient.aeron_array_remove(array::Ptr{Ptr{UInt8}}, element_size::Csize_t, index::Csize_t, old_length::Csize_t)::Cint
end

function aeron_log_buffer_create(log_buffer, log_file, correlation_id, pre_touch)
    @ccall AeronClient.aeron_log_buffer_create(log_buffer::Ptr{Ptr{aeron_log_buffer_t}}, log_file::Cstring, correlation_id::Int64, pre_touch::Bool)::Cint
end

function aeron_log_buffer_delete(log_buffer)
    @ccall AeronClient.aeron_log_buffer_delete(log_buffer::Ptr{aeron_log_buffer_t})::Cint
end

function aeron_term_scanner_scan_for_availability(buffer, term_length_left, max_length, padding)
    @ccall AeronClient.aeron_term_scanner_scan_for_availability(buffer::Ptr{UInt8}, term_length_left::Csize_t, max_length::Csize_t, padding::Ptr{Csize_t})::Csize_t
end

function aeron_buffer_builder_create(buffer_builder)
    @ccall AeronClient.aeron_buffer_builder_create(buffer_builder::Ptr{Ptr{aeron_buffer_builder_t}})::Cint
end

function aeron_buffer_builder_find_suitable_capacity(current_capacity, required_capacity)
    @ccall AeronClient.aeron_buffer_builder_find_suitable_capacity(current_capacity::Csize_t, required_capacity::Csize_t)::Cint
end

function aeron_buffer_builder_ensure_capacity(buffer_builder, additional_capacity)
    @ccall AeronClient.aeron_buffer_builder_ensure_capacity(buffer_builder::Ptr{aeron_buffer_builder_t}, additional_capacity::Csize_t)::Cint
end

function aeron_buffer_builder_delete(buffer_builder)
    @ccall AeronClient.aeron_buffer_builder_delete(buffer_builder::Ptr{aeron_buffer_builder_t})::Cvoid
end

function aeron_buffer_builder_reset(buffer_builder)
    @ccall AeronClient.aeron_buffer_builder_reset(buffer_builder::Ptr{aeron_buffer_builder_t})::Cvoid
end

function aeron_buffer_builder_append(buffer_builder, buffer, length)
    @ccall AeronClient.aeron_buffer_builder_append(buffer_builder::Ptr{aeron_buffer_builder_t}, buffer::Ptr{UInt8}, length::Csize_t)::Cint
end

struct aeron_data_header_as_longs_stct
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{aeron_data_header_as_longs_stct}, f::Symbol)
    f === :hdr && return Ptr{NTuple{4, UInt64}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_data_header_as_longs_stct, f::Symbol)
    r = Ref{aeron_data_header_as_longs_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_data_header_as_longs_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_data_header_as_longs_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_data_header_as_longs_t = aeron_data_header_as_longs_stct

function aeron_term_rebuilder_insert(dest, src, length)
    @ccall AeronClient.aeron_term_rebuilder_insert(dest::Ptr{UInt8}, src::Ptr{UInt8}, length::Csize_t)::Cvoid
end

struct aeron_spsc_rb_stct
    buffer::Ptr{UInt8}
    descriptor::Ptr{aeron_rb_descriptor_t}
    capacity::Csize_t
    max_message_length::Csize_t
end

const aeron_spsc_rb_t = aeron_spsc_rb_stct

function aeron_spsc_rb_init(ring_buffer, buffer, length)
    @ccall AeronClient.aeron_spsc_rb_init(ring_buffer::Ptr{aeron_spsc_rb_t}, buffer::Ptr{Cvoid}, length::Csize_t)::Cint
end

function aeron_spsc_rb_write(ring_buffer, msg_type_id, msg, length)
    @ccall AeronClient.aeron_spsc_rb_write(ring_buffer::Ptr{aeron_spsc_rb_t}, msg_type_id::Int32, msg::Ptr{Cvoid}, length::Csize_t)::aeron_rb_write_result_t
end

function aeron_spsc_rb_writev(ring_buffer, msg_type_id, iov, iovcnt)
    @ccall AeronClient.aeron_spsc_rb_writev(ring_buffer::Ptr{aeron_spsc_rb_t}, msg_type_id::Int32, iov::Ptr{Cvoid}, iovcnt::Cint)::aeron_rb_write_result_t
end

function aeron_spsc_rb_try_claim(ring_buffer, msg_type_id, length)
    @ccall AeronClient.aeron_spsc_rb_try_claim(ring_buffer::Ptr{aeron_spsc_rb_t}, msg_type_id::Int32, length::Csize_t)::Int32
end

function aeron_spsc_rb_commit(ring_buffer, offset)
    @ccall AeronClient.aeron_spsc_rb_commit(ring_buffer::Ptr{aeron_spsc_rb_t}, offset::Int32)::Cint
end

function aeron_spsc_rb_abort(ring_buffer, offset)
    @ccall AeronClient.aeron_spsc_rb_abort(ring_buffer::Ptr{aeron_spsc_rb_t}, offset::Int32)::Cint
end

function aeron_spsc_rb_read(ring_buffer, handler, clientd, message_count_limit)
    @ccall AeronClient.aeron_spsc_rb_read(ring_buffer::Ptr{aeron_spsc_rb_t}, handler::aeron_rb_handler_t, clientd::Ptr{Cvoid}, message_count_limit::Csize_t)::Csize_t
end

function aeron_spsc_rb_next_correlation_id(ring_buffer)
    @ccall AeronClient.aeron_spsc_rb_next_correlation_id(ring_buffer::Ptr{aeron_spsc_rb_t})::Int64
end

function aeron_spsc_rb_consumer_heartbeat_time(ring_buffer, time_ms)
    @ccall AeronClient.aeron_spsc_rb_consumer_heartbeat_time(ring_buffer::Ptr{aeron_spsc_rb_t}, time_ms::Int64)::Cvoid
end

function aeron_client_connect_to_driver(cnc_mmap, context)
    @ccall AeronClient.aeron_client_connect_to_driver(cnc_mmap::Ptr{aeron_mapped_file_t}, context::Ptr{aeron_context_t})::Cint
end

struct aeron_str_to_ptr_hash_map_key_stct
    str::Cstring
    hash_code::UInt64
    str_length::Csize_t
end

const aeron_str_to_ptr_hash_map_key_t = aeron_str_to_ptr_hash_map_key_stct

struct aeron_str_to_ptr_hash_map_stct
    keys::Ptr{aeron_str_to_ptr_hash_map_key_t}
    values::Ptr{Ptr{Cvoid}}
    load_factor::Cfloat
    capacity::Csize_t
    size::Csize_t
    resize_threshold::Csize_t
end

const aeron_str_to_ptr_hash_map_t = aeron_str_to_ptr_hash_map_stct

function aeron_str_to_ptr_hash_map_hash_key(key_hash_code, mask)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_hash_key(key_hash_code::UInt64, mask::Csize_t)::Csize_t
end

function aeron_str_to_ptr_hash_map_compare(key, key_str, key_str_len, key_hash_code)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_compare(key::Ptr{aeron_str_to_ptr_hash_map_key_t}, key_str::Cstring, key_str_len::Csize_t, key_hash_code::UInt64)::Bool
end

function aeron_str_to_ptr_hash_map_init(map, initial_capacity, load_factor)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_init(map::Ptr{aeron_str_to_ptr_hash_map_t}, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

function aeron_str_to_ptr_hash_map_delete(map)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_delete(map::Ptr{aeron_str_to_ptr_hash_map_t})::Cvoid
end

function aeron_str_to_ptr_hash_map_rehash(map, new_capacity)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_rehash(map::Ptr{aeron_str_to_ptr_hash_map_t}, new_capacity::Csize_t)::Cint
end

function aeron_str_to_ptr_hash_map_put(map, key, key_len, value)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_put(map::Ptr{aeron_str_to_ptr_hash_map_t}, key::Cstring, key_len::Csize_t, value::Ptr{Cvoid})::Cint
end

function aeron_str_to_ptr_hash_map_get(map, key, key_len)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_get(map::Ptr{aeron_str_to_ptr_hash_map_t}, key::Cstring, key_len::Csize_t)::Ptr{Cvoid}
end

function aeron_str_to_ptr_hash_map_compact_chain(map, delete_index)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_compact_chain(map::Ptr{aeron_str_to_ptr_hash_map_t}, delete_index::Csize_t)::Cvoid
end

function aeron_str_to_ptr_hash_map_remove(map, key, key_len)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_remove(map::Ptr{aeron_str_to_ptr_hash_map_t}, key::Cstring, key_len::Csize_t)::Ptr{Cvoid}
end

# typedef void ( * aeron_str_to_ptr_hash_map_for_each_func_t ) ( void * clientd , const char * key , size_t key_len , void * value )
const aeron_str_to_ptr_hash_map_for_each_func_t = Ptr{Cvoid}

function aeron_str_to_ptr_hash_map_for_each(map, func, clientd)
    @ccall AeronClient.aeron_str_to_ptr_hash_map_for_each(map::Ptr{aeron_str_to_ptr_hash_map_t}, func::aeron_str_to_ptr_hash_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

function aeron_publication_create(publication, conductor, channel, stream_id, session_id, position_limit_counter_id, position_limit_addr, channel_status_indicator_id, channel_status_addr, log_buffer, original_registration_id, registration_id)
    @ccall AeronClient.aeron_publication_create(publication::Ptr{Ptr{aeron_publication_t}}, conductor::Ptr{aeron_client_conductor_t}, channel::Cstring, stream_id::Int32, session_id::Int32, position_limit_counter_id::Int32, position_limit_addr::Ptr{Int64}, channel_status_indicator_id::Int32, channel_status_addr::Ptr{Int64}, log_buffer::Ptr{aeron_log_buffer_t}, original_registration_id::Int64, registration_id::Int64)::Cint
end

function aeron_publication_delete(publication)
    @ccall AeronClient.aeron_publication_delete(publication::Ptr{aeron_publication_t})::Cint
end

function aeron_publication_force_close(publication)
    @ccall AeronClient.aeron_publication_force_close(publication::Ptr{aeron_publication_t})::Cvoid
end

function aeron_publication_back_pressure_status(publication, current_position, message_length)
    @ccall AeronClient.aeron_publication_back_pressure_status(publication::Ptr{aeron_publication_t}, current_position::Int64, message_length::Int32)::Int64
end

function aeron_counter_create(counter, conductor, registration_id, counter_id, counter_addr)
    @ccall AeronClient.aeron_counter_create(counter::Ptr{Ptr{aeron_counter_t}}, conductor::Ptr{aeron_client_conductor_t}, registration_id::Int64, counter_id::Int32, counter_addr::Ptr{Int64})::Cint
end

function aeron_counter_delete(counter)
    @ccall AeronClient.aeron_counter_delete(counter::Ptr{aeron_counter_t})::Cint
end

function aeron_counter_force_close(counter)
    @ccall AeronClient.aeron_counter_force_close(counter::Ptr{aeron_counter_t})::Cvoid
end

struct aeron_int64_to_tagged_ptr_entry_stct
    value::Ptr{Cvoid}
    internal_flags::UInt32
    tag::UInt32
end

const aeron_int64_to_tagged_ptr_entry_t = aeron_int64_to_tagged_ptr_entry_stct

struct aeron_int64_to_tagged_ptr_hash_map_stct
    keys::Ptr{Int64}
    entries::Ptr{aeron_int64_to_tagged_ptr_entry_t}
    load_factor::Cfloat
    capacity::Csize_t
    size::Csize_t
    resize_threshold::Csize_t
end

const aeron_int64_to_tagged_ptr_hash_map_t = aeron_int64_to_tagged_ptr_hash_map_stct

function aeron_int64_to_tagged_ptr_hash_map_hash_key(key, mask)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_hash_key(key::Int64, mask::Csize_t)::Csize_t
end

function aeron_int64_to_tagged_ptr_hash_map_init(map, initial_capacity, load_factor)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_init(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

function aeron_int64_to_tagged_ptr_hash_map_delete(map)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_delete(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t})::Cvoid
end

function aeron_int64_to_tagged_ptr_hash_map_rehash(map, new_capacity)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_rehash(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, new_capacity::Csize_t)::Cint
end

function aeron_int64_to_tagged_ptr_hash_map_put(map, key, tag, value)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_put(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, key::Int64, tag::Int32, value::Ptr{Cvoid})::Cint
end

function aeron_int64_to_tagged_ptr_hash_map_get(map, key, tag, value)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_get(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, key::Int64, tag::Ptr{UInt32}, value::Ptr{Ptr{Cvoid}})::Bool
end

function aeron_int64_to_tagged_ptr_hash_map_compact_chain(map, delete_index)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_compact_chain(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, delete_index::Csize_t)::Cvoid
end

function aeron_int64_to_tagged_ptr_hash_map_remove(map, key, tag, value)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_remove(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, key::Int64, tag::Ptr{UInt32}, value::Ptr{Ptr{Cvoid}})::Bool
end

# typedef void ( * aeron_int64_to_tagged_ptr_hash_map_for_each_func_t ) ( void * clientd , int64_t key , uint32_t tag , void * value )
const aeron_int64_to_tagged_ptr_hash_map_for_each_func_t = Ptr{Cvoid}

# typedef bool ( * aeron_int64_to_tagged_ptr_hash_map_predicate_func_t ) ( void * clientd , int64_t key , uint32_t tag , void * value )
const aeron_int64_to_tagged_ptr_hash_map_predicate_func_t = Ptr{Cvoid}

function aeron_int64_to_tagged_ptr_hash_map_for_each(map, func, clientd)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_for_each(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, func::aeron_int64_to_tagged_ptr_hash_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

function aeron_int64_to_tagged_ptr_hash_map_remove_if(map, func, clientd)
    @ccall AeronClient.aeron_int64_to_tagged_ptr_hash_map_remove_if(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, func::aeron_int64_to_tagged_ptr_hash_map_predicate_func_t, clientd::Ptr{Cvoid})::Cvoid
end

struct aeron_symbol_table_obj_stct
    alias::Cstring
    name::Cstring
    object::Ptr{Cvoid}
end

const aeron_symbol_table_obj_t = aeron_symbol_table_obj_stct

function aeron_symbol_table_obj_load(table, table_length, name, component_name)
    @ccall AeronClient.aeron_symbol_table_obj_load(table::Ptr{aeron_symbol_table_obj_t}, table_length::Csize_t, name::Cstring, component_name::Cstring)::Ptr{Cvoid}
end

struct aeron_symbol_table_func_stct
    alias::Cstring
    name::Cstring
    _function::aeron_fptr_t
end

const aeron_symbol_table_func_t = aeron_symbol_table_func_stct

function aeron_symbol_table_func_load(table, table_length, name, component_name)
    @ccall AeronClient.aeron_symbol_table_func_load(table::Ptr{aeron_symbol_table_func_t}, table_length::Csize_t, name::Cstring, component_name::Cstring)::aeron_fptr_t
end

# typedef void ( * aeron_term_gap_scanner_on_gap_detected_func_t ) ( void * clientd , int32_t term_id , int32_t term_offset , size_t length )
const aeron_term_gap_scanner_on_gap_detected_func_t = Ptr{Cvoid}

function aeron_term_gap_scanner_scan_for_gap(buffer, term_id, term_offset, limit_offset, on_gap_detected, clientd)
    @ccall AeronClient.aeron_term_gap_scanner_scan_for_gap(buffer::Ptr{UInt8}, term_id::Int32, term_offset::Int32, limit_offset::Int32, on_gap_detected::aeron_term_gap_scanner_on_gap_detected_func_t, clientd::Ptr{Cvoid})::Int32
end

struct aeron_cnc_metadata_stct
    data::NTuple{48, UInt8}
end

function Base.getproperty(x::Ptr{aeron_cnc_metadata_stct}, f::Symbol)
    f === :cnc_version && return Ptr{Int32}(x + 0)
    f === :to_driver_buffer_length && return Ptr{Int32}(x + 4)
    f === :to_clients_buffer_length && return Ptr{Int32}(x + 8)
    f === :counter_metadata_buffer_length && return Ptr{Int32}(x + 12)
    f === :counter_values_buffer_length && return Ptr{Int32}(x + 16)
    f === :error_log_buffer_length && return Ptr{Int32}(x + 20)
    f === :client_liveness_timeout && return Ptr{Int64}(x + 24)
    f === :start_timestamp && return Ptr{Int64}(x + 32)
    f === :pid && return Ptr{Int64}(x + 40)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_cnc_metadata_stct, f::Symbol)
    r = Ref{aeron_cnc_metadata_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_cnc_metadata_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_cnc_metadata_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_cnc_metadata_t = aeron_cnc_metadata_stct

@enum aeron_cnc_load_result_stct::Int32 begin
    AERON_CNC_LOAD_FAILED = -1
    AERON_CNC_LOAD_SUCCESS = 0
    AERON_CNC_LOAD_AWAIT_FILE = 1
    AERON_CNC_LOAD_AWAIT_MMAP = 2
    AERON_CNC_LOAD_AWAIT_VERSION = 3
    AERON_CNC_LOAD_AWAIT_CNC_DATA = 4
end

const aeron_cnc_load_result_t = aeron_cnc_load_result_stct

function aeron_cnc_to_driver_buffer(metadata)
    @ccall AeronClient.aeron_cnc_to_driver_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

function aeron_cnc_to_clients_buffer(metadata)
    @ccall AeronClient.aeron_cnc_to_clients_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

function aeron_cnc_counters_metadata_buffer(metadata)
    @ccall AeronClient.aeron_cnc_counters_metadata_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

function aeron_cnc_counters_values_buffer(metadata)
    @ccall AeronClient.aeron_cnc_counters_values_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

function aeron_cnc_error_log_buffer(metadata)
    @ccall AeronClient.aeron_cnc_error_log_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

function aeron_cnc_computed_length(total_length_of_buffers, alignment)
    @ccall AeronClient.aeron_cnc_computed_length(total_length_of_buffers::Csize_t, alignment::Csize_t)::Csize_t
end

function aeron_cnc_is_file_length_sufficient(cnc_mmap)
    @ccall AeronClient.aeron_cnc_is_file_length_sufficient(cnc_mmap::Ptr{aeron_mapped_file_t})::Bool
end

function aeron_cnc_version_volatile(metadata)
    @ccall AeronClient.aeron_cnc_version_volatile(metadata::Ptr{aeron_cnc_metadata_t})::Int32
end

function aeron_cnc_map_file_and_load_metadata(dir, mapped_file, metadata)
    @ccall AeronClient.aeron_cnc_map_file_and_load_metadata(dir::Cstring, mapped_file::Ptr{aeron_mapped_file_t}, metadata::Ptr{Ptr{aeron_cnc_metadata_t}})::aeron_cnc_load_result_t
end

function aeron_cnc_resolve_filename(directory, filename_buffer, filename_buffer_length)
    @ccall AeronClient.aeron_cnc_resolve_filename(directory::Cstring, filename_buffer::Cstring, filename_buffer_length::Csize_t)::Cint
end

struct aeron_uri_param_stct
    key::Cstring
    value::Cstring
end

const aeron_uri_param_t = aeron_uri_param_stct

struct aeron_uri_params_stct
    length::Csize_t
    array::Ptr{aeron_uri_param_t}
end

const aeron_uri_params_t = aeron_uri_params_stct

struct aeron_udp_channel_params_stct
    endpoint::Cstring
    bind_interface::Cstring
    control::Cstring
    control_mode::Cstring
    channel_tag::Cstring
    entity_tag::Cstring
    ttl::Cstring
    additional_params::aeron_uri_params_t
end

const aeron_udp_channel_params_t = aeron_udp_channel_params_stct

struct aeron_ipc_channel_params_stct
    channel_tag::Cstring
    entity_tag::Cstring
    additional_params::aeron_uri_params_t
end

const aeron_ipc_channel_params_t = aeron_ipc_channel_params_stct

@enum aeron_uri_type_enum::UInt32 begin
    AERON_URI_UDP = 0
    AERON_URI_IPC = 1
    AERON_URI_UNKNOWN = 2
end

const aeron_uri_type_t = aeron_uri_type_enum

struct var"##Ctag#7691"
    data::NTuple{72, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#7691"}, f::Symbol)
    f === :udp && return Ptr{aeron_udp_channel_params_t}(x + 0)
    f === :ipc && return Ptr{aeron_ipc_channel_params_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#7691", f::Symbol)
    r = Ref{var"##Ctag#7691"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#7691"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#7691"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct aeron_uri_stct
    data::NTuple{464, UInt8}
end

function Base.getproperty(x::Ptr{aeron_uri_stct}, f::Symbol)
    f === :mutable_uri && return Ptr{NTuple{384, Cchar}}(x + 0)
    f === :type && return Ptr{aeron_uri_type_t}(x + 384)
    f === :params && return Ptr{var"##Ctag#7691"}(x + 392)
    return getfield(x, f)
end

function Base.getproperty(x::aeron_uri_stct, f::Symbol)
    r = Ref{aeron_uri_stct}(x)
    ptr = Base.unsafe_convert(Ptr{aeron_uri_stct}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{aeron_uri_stct}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const aeron_uri_t = aeron_uri_stct

@enum aeron_uri_ats_status_en::UInt32 begin
    AERON_URI_ATS_STATUS_DEFAULT = 0
    AERON_URI_ATS_STATUS_ENABLED = 1
    AERON_URI_ATS_STATUS_DISABLED = 2
end

const aeron_uri_ats_status_t = aeron_uri_ats_status_en

# typedef int ( * aeron_uri_parse_callback_t ) ( void * clientd , const char * key , const char * value )
const aeron_uri_parse_callback_t = Ptr{Cvoid}

function aeron_uri_parse_params(uri, param_func, clientd)
    @ccall AeronClient.aeron_uri_parse_params(uri::Cstring, param_func::aeron_uri_parse_callback_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_udp_uri_parse(uri, params)
    @ccall AeronClient.aeron_udp_uri_parse(uri::Cstring, params::Ptr{aeron_udp_channel_params_t})::Cint
end

function aeron_ipc_uri_parse(uri, params)
    @ccall AeronClient.aeron_ipc_uri_parse(uri::Cstring, params::Ptr{aeron_ipc_channel_params_t})::Cint
end

function aeron_uri_parse(uri_length, uri, params)
    @ccall AeronClient.aeron_uri_parse(uri_length::Csize_t, uri::Cstring, params::Ptr{aeron_uri_t})::Cint
end

function aeron_uri_close(params)
    @ccall AeronClient.aeron_uri_close(params::Ptr{aeron_uri_t})::Cvoid
end

function aeron_uri_multicast_ttl(uri)
    @ccall AeronClient.aeron_uri_multicast_ttl(uri::Ptr{aeron_uri_t})::UInt8
end

function aeron_uri_find_param_value(uri_params, key)
    @ccall AeronClient.aeron_uri_find_param_value(uri_params::Ptr{aeron_uri_params_t}, key::Cstring)::Cstring
end

function aeron_uri_get_int32(uri_params, key, retval)
    @ccall AeronClient.aeron_uri_get_int32(uri_params::Ptr{aeron_uri_params_t}, key::Cstring, retval::Ptr{Int32})::Cint
end

function aeron_uri_get_int64(uri_params, key, retval)
    @ccall AeronClient.aeron_uri_get_int64(uri_params::Ptr{aeron_uri_params_t}, key::Cstring, retval::Ptr{Int64})::Cint
end

function aeron_uri_get_bool(uri_params, key, retval)
    @ccall AeronClient.aeron_uri_get_bool(uri_params::Ptr{aeron_uri_params_t}, key::Cstring, retval::Ptr{Bool})::Cint
end

function aeron_uri_get_ats(uri_params, uri_ats_status)
    @ccall AeronClient.aeron_uri_get_ats(uri_params::Ptr{aeron_uri_params_t}, uri_ats_status::Ptr{aeron_uri_ats_status_t})::Cint
end

function aeron_uri_sprint(uri, buffer, buffer_len)
    @ccall AeronClient.aeron_uri_sprint(uri::Ptr{aeron_uri_t}, buffer::Cstring, buffer_len::Csize_t)::Cint
end

function aeron_uri_get_socket_buf_lengths(uri_params, socket_sndbuf_length, socket_rcvbuf_length)
    @ccall AeronClient.aeron_uri_get_socket_buf_lengths(uri_params::Ptr{aeron_uri_params_t}, socket_sndbuf_length::Ptr{Csize_t}, socket_rcvbuf_length::Ptr{Csize_t})::Cint
end

function aeron_uri_get_receiver_window_length(uri_params, receiver_window_length)
    @ccall AeronClient.aeron_uri_get_receiver_window_length(uri_params::Ptr{aeron_uri_params_t}, receiver_window_length::Ptr{Csize_t})::Cint
end

function aeron_uri_parse_tag(tag_str)
    @ccall AeronClient.aeron_uri_parse_tag(tag_str::Cstring)::Int64
end

function aeron_image_create(image, subscription, conductor, log_buffer, subscriber_position_id, subscriber_position, correlation_id, session_id, source_identity, source_identity_length)
    @ccall AeronClient.aeron_image_create(image::Ptr{Ptr{aeron_image_t}}, subscription::Ptr{aeron_subscription_t}, conductor::Ptr{aeron_client_conductor_t}, log_buffer::Ptr{aeron_log_buffer_t}, subscriber_position_id::Int32, subscriber_position::Ptr{Int64}, correlation_id::Int64, session_id::Int32, source_identity::Cstring, source_identity_length::Csize_t)::Cint
end

function aeron_image_delete(image)
    @ccall AeronClient.aeron_image_delete(image::Ptr{aeron_image_t})::Cint
end

function aeron_image_force_close(image)
    @ccall AeronClient.aeron_image_force_close(image::Ptr{aeron_image_t})::Cvoid
end

function aeron_image_removal_change_number(image)
    @ccall AeronClient.aeron_image_removal_change_number(image::Ptr{aeron_image_t})::Int64
end

function aeron_image_is_in_use_by_subscription(image, last_change_number)
    @ccall AeronClient.aeron_image_is_in_use_by_subscription(image::Ptr{aeron_image_t}, last_change_number::Int64)::Bool
end

function aeron_image_validate_position(image, position)
    @ccall AeronClient.aeron_image_validate_position(image::Ptr{aeron_image_t}, position::Int64)::Cint
end

function aeron_image_incr_refcnt(image)
    @ccall AeronClient.aeron_image_incr_refcnt(image::Ptr{aeron_image_t})::Int64
end

function aeron_image_decr_refcnt(image)
    @ccall AeronClient.aeron_image_decr_refcnt(image::Ptr{aeron_image_t})::Int64
end

function aeron_image_refcnt_volatile(image)
    @ccall AeronClient.aeron_image_refcnt_volatile(image::Ptr{aeron_image_t})::Int64
end

# typedef int ( * aeron_uri_hostname_resolver_func_t ) ( void * clientd , const char * host , struct addrinfo * hints , struct addrinfo * * info )
const aeron_uri_hostname_resolver_func_t = Ptr{Cvoid}

# typedef int ( * aeron_getifaddrs_func_t ) ( struct ifaddrs * * )
const aeron_getifaddrs_func_t = Ptr{Cvoid}

# typedef void ( * aeron_freeifaddrs_func_t ) ( struct ifaddrs * )
const aeron_freeifaddrs_func_t = Ptr{Cvoid}

# typedef int ( * aeron_ifaddr_func_t ) ( void * clientd , const char * name , struct sockaddr * addr , struct sockaddr * netmask , unsigned int flags )
const aeron_ifaddr_func_t = Ptr{Cvoid}

function aeron_ip_addr_resolver(host, sockaddr_, family_hint, protocol)
    @ccall AeronClient.aeron_ip_addr_resolver(host::Cstring, sockaddr_::Ptr{sockaddr_storage}, family_hint::Cint, protocol::Cint)::Cint
end

function aeron_udp_port_resolver(port_str, optional)
    @ccall AeronClient.aeron_udp_port_resolver(port_str::Cstring, optional::Bool)::Cint
end

function aeron_try_parse_ipv4(host, sockaddr_)
    @ccall AeronClient.aeron_try_parse_ipv4(host::Cstring, sockaddr_::Ptr{sockaddr_storage})::Bool
end

function aeron_ipv4_addr_resolver(host, protocol, sockaddr_)
    @ccall AeronClient.aeron_ipv4_addr_resolver(host::Cstring, protocol::Cint, sockaddr_::Ptr{sockaddr_storage})::Cint
end

function aeron_try_parse_ipv6(host, sockaddr_)
    @ccall AeronClient.aeron_try_parse_ipv6(host::Cstring, sockaddr_::Ptr{sockaddr_storage})::Bool
end

function aeron_ipv6_addr_resolver(host, protocol, sockaddr_)
    @ccall AeronClient.aeron_ipv6_addr_resolver(host::Cstring, protocol::Cint, sockaddr_::Ptr{sockaddr_storage})::Cint
end

function aeron_lookup_interfaces(func, clientd)
    @ccall AeronClient.aeron_lookup_interfaces(func::aeron_ifaddr_func_t, clientd::Ptr{Cvoid})::Cint
end

function aeron_lookup_interfaces_from_ifaddrs(func, clientd, ifaddrs_)
    @ccall AeronClient.aeron_lookup_interfaces_from_ifaddrs(func::aeron_ifaddr_func_t, clientd::Ptr{Cvoid}, ifaddrs_::Ptr{ifaddrs})::Cint
end

function aeron_set_getifaddrs(get_func, free_func)
    @ccall AeronClient.aeron_set_getifaddrs(get_func::aeron_getifaddrs_func_t, free_func::aeron_freeifaddrs_func_t)::Cvoid
end

function aeron_interface_parse_and_resolve(interface_str, sockaddr_, prefixlen)
    @ccall AeronClient.aeron_interface_parse_and_resolve(interface_str::Cstring, sockaddr_::Ptr{sockaddr_storage}, prefixlen::Ptr{Csize_t})::Cint
end

function aeron_set_ipv4_wildcard_host_and_port(sockaddr_)
    @ccall AeronClient.aeron_set_ipv4_wildcard_host_and_port(sockaddr_::Ptr{sockaddr_storage})::Cvoid
end

function aeron_set_ipv6_wildcard_host_and_port(sockaddr_)
    @ccall AeronClient.aeron_set_ipv6_wildcard_host_and_port(sockaddr_::Ptr{sockaddr_storage})::Cvoid
end

function aeron_ipv4_does_prefix_match(in_addr1, in_addr2, prefixlen)
    @ccall AeronClient.aeron_ipv4_does_prefix_match(in_addr1::Ptr{Cvoid}, in_addr2::Ptr{Cvoid}, prefixlen::Csize_t)::Bool
end

function aeron_ipv6_does_prefix_match(in6_addr1, in6_addr2, prefixlen)
    @ccall AeronClient.aeron_ipv6_does_prefix_match(in6_addr1::Ptr{Cvoid}, in6_addr2::Ptr{Cvoid}, prefixlen::Csize_t)::Bool
end

function aeron_ipv4_netmask_to_prefixlen(netmask)
    @ccall AeronClient.aeron_ipv4_netmask_to_prefixlen(netmask::Ptr{Cvoid})::Csize_t
end

function aeron_ipv6_netmask_to_prefixlen(netmask)
    @ccall AeronClient.aeron_ipv6_netmask_to_prefixlen(netmask::Ptr{Cvoid})::Csize_t
end

function aeron_find_interface(interface_str, if_addr, if_index)
    @ccall AeronClient.aeron_find_interface(interface_str::Cstring, if_addr::Ptr{sockaddr_storage}, if_index::Ptr{Cuint})::Cint
end

function aeron_find_unicast_interface(family, interface_str, interface_addr, interface_index)
    @ccall AeronClient.aeron_find_unicast_interface(family::Cint, interface_str::Cstring, interface_addr::Ptr{sockaddr_storage}, interface_index::Ptr{Cuint})::Cint
end

function aeron_is_addr_multicast(addr)
    @ccall AeronClient.aeron_is_addr_multicast(addr::Ptr{sockaddr_storage})::Bool
end

function aeron_is_wildcard_addr(addr)
    @ccall AeronClient.aeron_is_wildcard_addr(addr::Ptr{sockaddr_storage})::Bool
end

function aeron_is_wildcard_port(addr)
    @ccall AeronClient.aeron_is_wildcard_port(addr::Ptr{sockaddr_storage})::Bool
end

function aeron_format_source_identity(buffer, length, addr)
    @ccall AeronClient.aeron_format_source_identity(buffer::Cstring, length::Csize_t, addr::Ptr{sockaddr_storage})::Cint
end

function aeron_netutil_get_so_buf_lengths(default_so_rcvbuf, default_so_sndbuf)
    @ccall AeronClient.aeron_netutil_get_so_buf_lengths(default_so_rcvbuf::Ptr{Csize_t}, default_so_sndbuf::Ptr{Csize_t})::Cint
end

struct __pthread_mutex_s
    __lock::Cint
    __count::Cuint
    __owner::Cint
    __nusers::Cuint
    __kind::Cint
    __spins::Cint
    __list::__pthread_list_t
end

struct var"##Ctag#7690"
    head::UInt64
    padding::NTuple{56, Int8}
end
function Base.getproperty(x::Ptr{var"##Ctag#7690"}, f::Symbol)
    f === :head && return Ptr{UInt64}(x + 0)
    f === :padding && return Ptr{NTuple{56, Int8}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#7690", f::Symbol)
    r = Ref{var"##Ctag#7690"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#7690"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#7690"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


# exports
const PREFIXES = ["aeron_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
