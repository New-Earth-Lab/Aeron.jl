module LibAeron

using CEnum

# Prologue file
libaeron = joinpath(@__DIR__, "../artifact/lib/libaeron.so")

INT64_C = Int64
INT64_MAX = typemax(INT64_C)

# using Clang
# offsetof = Clang.LibClang.clang_Type_getOffsetOf



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

struct var"##Ctag#2336"
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#2336"}, f::Symbol)
    f === :ifu_broadaddr && return Ptr{Ptr{sockaddr}}(x + 0)
    f === :ifu_dstaddr && return Ptr{Ptr{sockaddr}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#2336", f::Symbol)
    r = Ref{var"##Ctag#2336"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#2336"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#2336"}, f::Symbol, v)
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
    f === :ifa_ifu && return Ptr{var"##Ctag#2336"}(x + 40)
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

"""
    aeron_alloc_no_err(ptr, size)

### Prototype
```c
int aeron_alloc_no_err(void **ptr, size_t size);
```
"""
function aeron_alloc_no_err(ptr, size)
    @ccall libaeron.aeron_alloc_no_err(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::Cint
end

"""
    aeron_alloc(ptr, size)

### Prototype
```c
int aeron_alloc(void **ptr, size_t size);
```
"""
function aeron_alloc(ptr, size)
    @ccall libaeron.aeron_alloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::Cint
end

"""
    aeron_alloc_aligned(ptr, offset, size, alignment)

### Prototype
```c
int aeron_alloc_aligned(void **ptr, size_t *offset, size_t size, size_t alignment);
```
"""
function aeron_alloc_aligned(ptr, offset, size, alignment)
    @ccall libaeron.aeron_alloc_aligned(ptr::Ptr{Ptr{Cvoid}}, offset::Ptr{Csize_t}, size::Csize_t, alignment::Csize_t)::Cint
end

"""
    aeron_reallocf(ptr, size)

### Prototype
```c
int aeron_reallocf(void **ptr, size_t size);
```
"""
function aeron_reallocf(ptr, size)
    @ccall libaeron.aeron_reallocf(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::Cint
end

"""
    aeron_free(ptr)

### Prototype
```c
void aeron_free(void *ptr);
```
"""
function aeron_free(ptr)
    @ccall libaeron.aeron_free(ptr::Ptr{Cvoid})::Cvoid
end

# typedef void ( * aeron_error_handler_t ) ( void * clientd , int errcode , const char * message )
"""
The error handler to be called when an error occurs.
"""
const aeron_error_handler_t = Ptr{Cvoid}

# typedef void ( * aeron_on_new_publication_t ) ( void * clientd , aeron_async_add_publication_t * async , const char * channel , int32_t stream_id , int32_t session_id , int64_t correlation_id )
"""
Function called by aeron\\_client\\_t to deliver notification that the media driver has added an [`aeron_publication_t`](@ref) or [`aeron_exclusive_publication_t`](@ref) successfully.

Implementations should do the minimum work for passing off state to another thread for later processing.

### Parameters
* `clientd`: to be returned in the call
* `async`: associated with the original add publication call
* `channel`: of the publication
* `stream_id`: within the channel of the publication
* `session_id`: of the publication
* `correlation_id`: used by the publication
"""
const aeron_on_new_publication_t = Ptr{Cvoid}

# typedef void ( * aeron_on_new_subscription_t ) ( void * clientd , aeron_async_add_subscription_t * async , const char * channel , int32_t stream_id , int64_t correlation_id )
"""
Function called by aeron\\_client\\_t to deliver notification that the media driver has added an [`aeron_subscription_t`](@ref) successfully.

Implementations should do the minimum work for handing off state to another thread for later processing.

### Parameters
* `clientd`: to be returned in the call
* `async`: associated with the original aeron\\_add\\_async\\_subscription call
* `channel`: of the subscription
* `stream_id`: within the channel of the subscription
* `session_id`: of the subscription
* `correlation_id`: used by the subscription
"""
const aeron_on_new_subscription_t = Ptr{Cvoid}

# typedef void ( * aeron_on_available_image_t ) ( void * clientd , aeron_subscription_t * subscription , aeron_image_t * image )
"""
Function called by aeron\\_client\\_t to deliver notifications that an [`aeron_image_t`](@ref) was added.

### Parameters
* `clientd`: to be returned in the call.
* `subscription`: that image is part of.
* `image`: that has become available.
"""
const aeron_on_available_image_t = Ptr{Cvoid}

# typedef void ( * aeron_on_unavailable_image_t ) ( void * clientd , aeron_subscription_t * subscription , aeron_image_t * image )
"""
Function called by aeron\\_client\\_t to deliver notifications that an [`aeron_image_t`](@ref) has been removed from use and should not be used any longer.

### Parameters
* `clientd`: to be returned in the call.
* `subscription`: that image is part of.
* `image`: that has become unavailable.
"""
const aeron_on_unavailable_image_t = Ptr{Cvoid}

# typedef void ( * aeron_on_available_counter_t ) ( void * clientd , aeron_counters_reader_t * counters_reader , int64_t registration_id , int32_t counter_id )
"""
Function called by aeron\\_client\\_t to deliver notifications that a counter has been added to the driver.

### Parameters
* `clientd`: to be returned in the call.
* `counters_reader`: that holds the counter.
* `registration_id`: of the counter.
* `counter_id`: of the counter.
"""
const aeron_on_available_counter_t = Ptr{Cvoid}

# typedef void ( * aeron_on_unavailable_counter_t ) ( void * clientd , aeron_counters_reader_t * counters_reader , int64_t registration_id , int32_t counter_id )
"""
Function called by aeron\\_client\\_t to deliver notifications that a counter has been removed from the driver.

### Parameters
* `clientd`: to be returned in the call.
* `counters_reader`: that holds the counter.
* `registration_id`: of the counter.
* `counter_id`: of the counter.
"""
const aeron_on_unavailable_counter_t = Ptr{Cvoid}

# typedef void ( * aeron_agent_on_start_func_t ) ( void * state , const char * role_name )
const aeron_agent_on_start_func_t = Ptr{Cvoid}

# typedef void ( * aeron_on_close_client_t ) ( void * clientd )
"""
Function called by aeron\\_client\\_t to deliver notifications that the client is closing.

### Parameters
* `clientd`: to be returned in the call.
"""
const aeron_on_close_client_t = Ptr{Cvoid}

# typedef void ( * aeron_idle_strategy_func_t ) ( void * state , int work_count )
const aeron_idle_strategy_func_t = Ptr{Cvoid}

# typedef int64_t ( * aeron_clock_func_t ) ( void )
"""
Clock function used by aeron.
"""
const aeron_clock_func_t = Ptr{Cvoid}

struct aeron_mapped_file_stct
    addr::Ptr{Cvoid}
    length::Csize_t
end

const aeron_mapped_file_t = aeron_mapped_file_stct

mutable struct var"##Ctag#2337"
    tail::UInt64
    head_cache::UInt64
    shared_head_cache::UInt64
    padding::NTuple{40, Int8}
    var"##Ctag#2337"() = new()
end
function Base.getproperty(x::Ptr{var"##Ctag#2337"}, f::Symbol)
    f === :tail && return Ptr{UInt64}(x + 0)
    f === :head_cache && return Ptr{UInt64}(x + 8)
    f === :shared_head_cache && return Ptr{UInt64}(x + 16)
    f === :padding && return Ptr{NTuple{40, Int8}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#2337", f::Symbol)
    r = Ref{var"##Ctag#2337"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#2337"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#2337"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


mutable struct var"##Ctag#2340"
    head::UInt64
    padding::NTuple{56, Int8}
    var"##Ctag#2340"() = new()
end
function Base.getproperty(x::Ptr{var"##Ctag#2340"}, f::Symbol)
    f === :head && return Ptr{UInt64}(x + 0)
    f === :padding && return Ptr{NTuple{56, Int8}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#2340", f::Symbol)
    r = Ref{var"##Ctag#2340"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#2340"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#2340"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct aeron_mpsc_concurrent_array_queue_stct
    data::NTuple{208, UInt8}
end

function Base.getproperty(x::Ptr{aeron_mpsc_concurrent_array_queue_stct}, f::Symbol)
    f === :padding && return Ptr{NTuple{56, Int8}}(x + 0)
    f === :producer && return Ptr{var"##Ctag#2337"}(x + 56)
    f === :consumer && return Ptr{var"##Ctag#2340"}(x + 120)
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

mutable struct aeron_context_stct
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
    aeron_context_stct() = new()
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

@cenum aeron_client_managed_resource_type_en::UInt32 begin
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

mutable struct aeron_client_registering_counter_stct
    key_buffer::Ptr{UInt8}
    label_buffer::Cstring
    key_buffer_length::UInt64
    label_buffer_length::UInt64
    type_id::Int32
    aeron_client_registering_counter_stct() = new()
end

@cenum aeron_client_registration_status_en::UInt32 begin
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

mutable struct aeron_stct
    conductor::aeron_client_conductor_t
    runner::aeron_agent_runner_t
    context::Ptr{aeron_context_t}
    aeron_stct() = new()
end

const aeron_t = aeron_stct

"""
    aeron_buffer_claim_stct

Structure used to hold information for a try\\_claim function call.
"""
mutable struct aeron_buffer_claim_stct
    frame_header::Ptr{UInt8}
    data::Ptr{UInt8}
    length::Csize_t
    aeron_buffer_claim_stct() = new()
end

"""
Structure used to hold information for a try\\_claim function call.
"""
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
"""
Generalised notification callback.
"""
const aeron_notification_t = Ptr{Cvoid}

mutable struct aeron_publication_stct
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
    aeron_publication_stct() = new()
end

const aeron_publication_t = aeron_publication_stct

mutable struct aeron_exclusive_publication_stct
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
    aeron_exclusive_publication_stct() = new()
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

mutable struct aeron_header_stct
    frame::Ptr{aeron_data_header_t}
    initial_term_id::Int32
    position_bits_to_shift::Csize_t
    aeron_header_stct() = new()
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

mutable struct aeron_counter_stct
    command_base::aeron_client_command_base_t
    conductor::Ptr{aeron_client_conductor_t}
    counter_addr::Ptr{Int64}
    registration_id::Int64
    counter_id::Int32
    on_close_complete::aeron_notification_t
    on_close_complete_clientd::Ptr{Cvoid}
    is_closed::Bool
    aeron_counter_stct() = new()
end

const aeron_counter_t = aeron_counter_stct

const aeron_async_add_publication_t = aeron_client_registering_resource_stct

const aeron_async_add_exclusive_publication_t = aeron_client_registering_resource_stct

const aeron_async_add_subscription_t = aeron_client_registering_resource_stct

const aeron_async_add_counter_t = aeron_client_registering_resource_stct

const aeron_async_destination_t = aeron_client_registering_resource_stct

# typedef void ( * aeron_fragment_handler_t ) ( void * clientd , const uint8_t * buffer , size_t length , aeron_header_t * header )
"""
Callback for handling fragments of data being read from a log.

The frame will either contain a whole message or a fragment of a message to be reassembled. Messages are fragmented if greater than the frame for MTU in length.

### Parameters
* `clientd`: passed to the poll function.
* `buffer`: containing the data.
* `length`: of the data in bytes.
* `header`: representing the meta data for the data.
"""
const aeron_fragment_handler_t = Ptr{Cvoid}

struct aeron_buffer_builder_stct
    buffer::Ptr{UInt8}
    buffer_length::Csize_t
    limit::Csize_t
    next_term_offset::Int32
end

const aeron_buffer_builder_t = aeron_buffer_builder_stct

mutable struct aeron_image_fragment_assembler_stct
    delegate::aeron_fragment_handler_t
    delegate_clientd::Ptr{Cvoid}
    buffer_builder::Ptr{aeron_buffer_builder_t}
    aeron_image_fragment_assembler_stct() = new()
end

const aeron_image_fragment_assembler_t = aeron_image_fragment_assembler_stct

# typedef aeron_controlled_fragment_handler_action_t ( * aeron_controlled_fragment_handler_t ) ( void * clientd , const uint8_t * buffer , size_t length , aeron_header_t * header )
"""
Callback for handling fragments of data being read from a log.

Handler for reading data that is coming from a log buffer. The frame will either contain a whole message or a fragment of a message to be reassembled. Messages are fragmented if greater than the frame for MTU in length.

### Parameters
* `clientd`: passed to the controlled poll function.
* `buffer`: containing the data.
* `length`: of the data in bytes.
* `header`: representing the meta data for the data.
### Returns
The action to be taken with regard to the stream position after the callback.
"""
const aeron_controlled_fragment_handler_t = Ptr{Cvoid}

mutable struct aeron_image_controlled_fragment_assembler_stct
    delegate::aeron_controlled_fragment_handler_t
    delegate_clientd::Ptr{Cvoid}
    buffer_builder::Ptr{aeron_buffer_builder_t}
    aeron_image_controlled_fragment_assembler_stct() = new()
end

const aeron_image_controlled_fragment_assembler_t = aeron_image_controlled_fragment_assembler_stct

mutable struct aeron_fragment_assembler_stct
    delegate::aeron_fragment_handler_t
    delegate_clientd::Ptr{Cvoid}
    builder_by_session_id_map::aeron_int64_to_ptr_hash_map_t
    aeron_fragment_assembler_stct() = new()
end

const aeron_fragment_assembler_t = aeron_fragment_assembler_stct

mutable struct aeron_controlled_fragment_assembler_stct
    delegate::aeron_controlled_fragment_handler_t
    delegate_clientd::Ptr{Cvoid}
    builder_by_session_id_map::aeron_int64_to_ptr_hash_map_t
    aeron_controlled_fragment_assembler_stct() = new()
end

const aeron_controlled_fragment_assembler_t = aeron_controlled_fragment_assembler_stct

"""
    aeron_context_set_dir(context, value)

### Prototype
```c
int aeron_context_set_dir(aeron_context_t *context, const char *value);
```
"""
function aeron_context_set_dir(context, value)
    @ccall libaeron.aeron_context_set_dir(context::Ptr{aeron_context_t}, value::Cstring)::Cint
end

"""
    aeron_context_get_dir(context)

### Prototype
```c
const char *aeron_context_get_dir(aeron_context_t *context);
```
"""
function aeron_context_get_dir(context)
    @ccall libaeron.aeron_context_get_dir(context::Ptr{aeron_context_t})::Cstring
end

"""
    aeron_context_set_driver_timeout_ms(context, value)

### Prototype
```c
int aeron_context_set_driver_timeout_ms(aeron_context_t *context, uint64_t value);
```
"""
function aeron_context_set_driver_timeout_ms(context, value)
    @ccall libaeron.aeron_context_set_driver_timeout_ms(context::Ptr{aeron_context_t}, value::UInt64)::Cint
end

"""
    aeron_context_get_driver_timeout_ms(context)

### Prototype
```c
uint64_t aeron_context_get_driver_timeout_ms(aeron_context_t *context);
```
"""
function aeron_context_get_driver_timeout_ms(context)
    @ccall libaeron.aeron_context_get_driver_timeout_ms(context::Ptr{aeron_context_t})::UInt64
end

"""
    aeron_context_set_keepalive_interval_ns(context, value)

### Prototype
```c
int aeron_context_set_keepalive_interval_ns(aeron_context_t *context, uint64_t value);
```
"""
function aeron_context_set_keepalive_interval_ns(context, value)
    @ccall libaeron.aeron_context_set_keepalive_interval_ns(context::Ptr{aeron_context_t}, value::UInt64)::Cint
end

"""
    aeron_context_get_keepalive_interval_ns(context)

### Prototype
```c
uint64_t aeron_context_get_keepalive_interval_ns(aeron_context_t *context);
```
"""
function aeron_context_get_keepalive_interval_ns(context)
    @ccall libaeron.aeron_context_get_keepalive_interval_ns(context::Ptr{aeron_context_t})::UInt64
end

"""
    aeron_context_set_resource_linger_duration_ns(context, value)

### Prototype
```c
int aeron_context_set_resource_linger_duration_ns(aeron_context_t *context, uint64_t value);
```
"""
function aeron_context_set_resource_linger_duration_ns(context, value)
    @ccall libaeron.aeron_context_set_resource_linger_duration_ns(context::Ptr{aeron_context_t}, value::UInt64)::Cint
end

"""
    aeron_context_get_resource_linger_duration_ns(context)

### Prototype
```c
uint64_t aeron_context_get_resource_linger_duration_ns(aeron_context_t *context);
```
"""
function aeron_context_get_resource_linger_duration_ns(context)
    @ccall libaeron.aeron_context_get_resource_linger_duration_ns(context::Ptr{aeron_context_t})::UInt64
end

"""
    aeron_context_set_pre_touch_mapped_memory(context, value)

### Prototype
```c
int aeron_context_set_pre_touch_mapped_memory(aeron_context_t *context, bool value);
```
"""
function aeron_context_set_pre_touch_mapped_memory(context, value)
    @ccall libaeron.aeron_context_set_pre_touch_mapped_memory(context::Ptr{aeron_context_t}, value::Bool)::Cint
end

"""
    aeron_context_get_pre_touch_mapped_memory(context)

### Prototype
```c
bool aeron_context_get_pre_touch_mapped_memory(aeron_context_t *context);
```
"""
function aeron_context_get_pre_touch_mapped_memory(context)
    @ccall libaeron.aeron_context_get_pre_touch_mapped_memory(context::Ptr{aeron_context_t})::Bool
end

"""
    aeron_context_set_error_handler(context, handler, clientd)

### Prototype
```c
int aeron_context_set_error_handler(aeron_context_t *context, aeron_error_handler_t handler, void *clientd);
```
"""
function aeron_context_set_error_handler(context, handler, clientd)
    @ccall libaeron.aeron_context_set_error_handler(context::Ptr{aeron_context_t}, handler::aeron_error_handler_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_context_get_error_handler(context)

### Prototype
```c
aeron_error_handler_t aeron_context_get_error_handler(aeron_context_t *context);
```
"""
function aeron_context_get_error_handler(context)
    @ccall libaeron.aeron_context_get_error_handler(context::Ptr{aeron_context_t})::aeron_error_handler_t
end

"""
    aeron_context_get_error_handler_clientd(context)

### Prototype
```c
void *aeron_context_get_error_handler_clientd(aeron_context_t *context);
```
"""
function aeron_context_get_error_handler_clientd(context)
    @ccall libaeron.aeron_context_get_error_handler_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

"""
    aeron_context_set_on_new_publication(context, handler, clientd)

### Prototype
```c
int aeron_context_set_on_new_publication(aeron_context_t *context, aeron_on_new_publication_t handler, void *clientd);
```
"""
function aeron_context_set_on_new_publication(context, handler, clientd)
    @ccall libaeron.aeron_context_set_on_new_publication(context::Ptr{aeron_context_t}, handler::aeron_on_new_publication_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_context_get_on_new_publication(context)

### Prototype
```c
aeron_on_new_publication_t aeron_context_get_on_new_publication(aeron_context_t *context);
```
"""
function aeron_context_get_on_new_publication(context)
    @ccall libaeron.aeron_context_get_on_new_publication(context::Ptr{aeron_context_t})::aeron_on_new_publication_t
end

"""
    aeron_context_get_on_new_publication_clientd(context)

### Prototype
```c
void *aeron_context_get_on_new_publication_clientd(aeron_context_t *context);
```
"""
function aeron_context_get_on_new_publication_clientd(context)
    @ccall libaeron.aeron_context_get_on_new_publication_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

"""
    aeron_context_set_on_new_exclusive_publication(context, handler, clientd)

### Prototype
```c
int aeron_context_set_on_new_exclusive_publication( aeron_context_t *context, aeron_on_new_publication_t handler, void *clientd);
```
"""
function aeron_context_set_on_new_exclusive_publication(context, handler, clientd)
    @ccall libaeron.aeron_context_set_on_new_exclusive_publication(context::Ptr{aeron_context_t}, handler::aeron_on_new_publication_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_context_get_on_new_exclusive_publication(context)

### Prototype
```c
aeron_on_new_publication_t aeron_context_get_on_new_exclusive_publication(aeron_context_t *context);
```
"""
function aeron_context_get_on_new_exclusive_publication(context)
    @ccall libaeron.aeron_context_get_on_new_exclusive_publication(context::Ptr{aeron_context_t})::aeron_on_new_publication_t
end

"""
    aeron_context_get_on_new_exclusive_publication_clientd(context)

### Prototype
```c
void *aeron_context_get_on_new_exclusive_publication_clientd(aeron_context_t *context);
```
"""
function aeron_context_get_on_new_exclusive_publication_clientd(context)
    @ccall libaeron.aeron_context_get_on_new_exclusive_publication_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

"""
    aeron_context_set_on_new_subscription(context, handler, clientd)

### Prototype
```c
int aeron_context_set_on_new_subscription( aeron_context_t *context, aeron_on_new_subscription_t handler, void *clientd);
```
"""
function aeron_context_set_on_new_subscription(context, handler, clientd)
    @ccall libaeron.aeron_context_set_on_new_subscription(context::Ptr{aeron_context_t}, handler::aeron_on_new_subscription_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_context_get_on_new_subscription(context)

### Prototype
```c
aeron_on_new_subscription_t aeron_context_get_on_new_subscription(aeron_context_t *context);
```
"""
function aeron_context_get_on_new_subscription(context)
    @ccall libaeron.aeron_context_get_on_new_subscription(context::Ptr{aeron_context_t})::aeron_on_new_subscription_t
end

"""
    aeron_context_get_on_new_subscription_clientd(context)

### Prototype
```c
void *aeron_context_get_on_new_subscription_clientd(aeron_context_t *context);
```
"""
function aeron_context_get_on_new_subscription_clientd(context)
    @ccall libaeron.aeron_context_get_on_new_subscription_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

"""
    aeron_context_set_on_available_counter(context, handler, clientd)

### Prototype
```c
int aeron_context_set_on_available_counter( aeron_context_t *context, aeron_on_available_counter_t handler, void *clientd);
```
"""
function aeron_context_set_on_available_counter(context, handler, clientd)
    @ccall libaeron.aeron_context_set_on_available_counter(context::Ptr{aeron_context_t}, handler::aeron_on_available_counter_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_context_get_on_available_counter(context)

### Prototype
```c
aeron_on_available_counter_t aeron_context_get_on_available_counter(aeron_context_t *context);
```
"""
function aeron_context_get_on_available_counter(context)
    @ccall libaeron.aeron_context_get_on_available_counter(context::Ptr{aeron_context_t})::aeron_on_available_counter_t
end

"""
    aeron_context_get_on_available_counter_clientd(context)

### Prototype
```c
void *aeron_context_get_on_available_counter_clientd(aeron_context_t *context);
```
"""
function aeron_context_get_on_available_counter_clientd(context)
    @ccall libaeron.aeron_context_get_on_available_counter_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

"""
    aeron_context_set_on_unavailable_counter(context, handler, clientd)

### Prototype
```c
int aeron_context_set_on_unavailable_counter( aeron_context_t *context, aeron_on_unavailable_counter_t handler, void *clientd);
```
"""
function aeron_context_set_on_unavailable_counter(context, handler, clientd)
    @ccall libaeron.aeron_context_set_on_unavailable_counter(context::Ptr{aeron_context_t}, handler::aeron_on_unavailable_counter_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_context_get_on_unavailable_counter(context)

### Prototype
```c
aeron_on_unavailable_counter_t aeron_context_get_on_unavailable_counter(aeron_context_t *context);
```
"""
function aeron_context_get_on_unavailable_counter(context)
    @ccall libaeron.aeron_context_get_on_unavailable_counter(context::Ptr{aeron_context_t})::aeron_on_unavailable_counter_t
end

"""
    aeron_context_get_on_unavailable_counter_clientd(context)

### Prototype
```c
void *aeron_context_get_on_unavailable_counter_clientd(aeron_context_t *context);
```
"""
function aeron_context_get_on_unavailable_counter_clientd(context)
    @ccall libaeron.aeron_context_get_on_unavailable_counter_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

"""
    aeron_context_set_on_close_client(context, handler, clientd)

### Prototype
```c
int aeron_context_set_on_close_client( aeron_context_t *context, aeron_on_close_client_t handler, void *clientd);
```
"""
function aeron_context_set_on_close_client(context, handler, clientd)
    @ccall libaeron.aeron_context_set_on_close_client(context::Ptr{aeron_context_t}, handler::aeron_on_close_client_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_context_get_on_close_client(context)

### Prototype
```c
aeron_on_close_client_t aeron_context_get_on_close_client(aeron_context_t *context);
```
"""
function aeron_context_get_on_close_client(context)
    @ccall libaeron.aeron_context_get_on_close_client(context::Ptr{aeron_context_t})::aeron_on_close_client_t
end

"""
    aeron_context_get_on_close_client_clientd(context)

### Prototype
```c
void *aeron_context_get_on_close_client_clientd(aeron_context_t *context);
```
"""
function aeron_context_get_on_close_client_clientd(context)
    @ccall libaeron.aeron_context_get_on_close_client_clientd(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

"""
    aeron_context_set_use_conductor_agent_invoker(context, value)

Whether to use an invoker to control the conductor agent or spawn a thread.

### Prototype
```c
int aeron_context_set_use_conductor_agent_invoker(aeron_context_t *context, bool value);
```
"""
function aeron_context_set_use_conductor_agent_invoker(context, value)
    @ccall libaeron.aeron_context_set_use_conductor_agent_invoker(context::Ptr{aeron_context_t}, value::Bool)::Cint
end

"""
    aeron_context_get_use_conductor_agent_invoker(context)

### Prototype
```c
bool aeron_context_get_use_conductor_agent_invoker(aeron_context_t *context);
```
"""
function aeron_context_get_use_conductor_agent_invoker(context)
    @ccall libaeron.aeron_context_get_use_conductor_agent_invoker(context::Ptr{aeron_context_t})::Bool
end

"""
    aeron_context_set_agent_on_start_function(context, value, state)

### Prototype
```c
int aeron_context_set_agent_on_start_function( aeron_context_t *context, aeron_agent_on_start_func_t value, void *state);
```
"""
function aeron_context_set_agent_on_start_function(context, value, state)
    @ccall libaeron.aeron_context_set_agent_on_start_function(context::Ptr{aeron_context_t}, value::aeron_agent_on_start_func_t, state::Ptr{Cvoid})::Cint
end

"""
    aeron_context_get_agent_on_start_function(context)

### Prototype
```c
aeron_agent_on_start_func_t aeron_context_get_agent_on_start_function(aeron_context_t *context);
```
"""
function aeron_context_get_agent_on_start_function(context)
    @ccall libaeron.aeron_context_get_agent_on_start_function(context::Ptr{aeron_context_t})::aeron_agent_on_start_func_t
end

"""
    aeron_context_get_agent_on_start_state(context)

### Prototype
```c
void *aeron_context_get_agent_on_start_state(aeron_context_t *context);
```
"""
function aeron_context_get_agent_on_start_state(context)
    @ccall libaeron.aeron_context_get_agent_on_start_state(context::Ptr{aeron_context_t})::Ptr{Cvoid}
end

"""
    aeron_context_init(context)

Create a [`aeron_context_t`](@ref) struct and initialize with default values.

### Parameters
* `context`: to create and initialize
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_context_init(aeron_context_t **context);
```
"""
function aeron_context_init(context)
    @ccall libaeron.aeron_context_init(context::Ptr{Ptr{aeron_context_t}})::Cint
end

"""
    aeron_context_close(context)

Close and delete [`aeron_context_t`](@ref) struct.

### Parameters
* `context`: to close and delete
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_context_close(aeron_context_t *context);
```
"""
function aeron_context_close(context)
    @ccall libaeron.aeron_context_close(context::Ptr{aeron_context_t})::Cint
end

"""
    aeron_init(client, context)

Create a [`aeron_t`](@ref) client struct and initialize from the [`aeron_context_t`](@ref) struct.

The given [`aeron_context_t`](@ref) struct will be used exclusively by the client. Do not reuse between clients.

### Parameters
* `aeron`: client to create and initialize.
* `context`: to use for initialization.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_init(aeron_t **client, aeron_context_t *context);
```
"""
function aeron_init(client, context)
    @ccall libaeron.aeron_init(client::Ptr{Ptr{aeron_t}}, context::Ptr{aeron_context_t})::Cint
end

"""
    aeron_start(client)

Start an [`aeron_t`](@ref). This may spawn a thread for the Client Conductor.

### Parameters
* `client`: to start.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_start(aeron_t *client);
```
"""
function aeron_start(client)
    @ccall libaeron.aeron_start(client::Ptr{aeron_t})::Cint
end

"""
    aeron_main_do_work(client)

Call the Conductor main do\\_work duty cycle once.

Client must have been created with use conductor invoker set to true.

### Parameters
* `client`: to call do\\_work duty cycle on.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_main_do_work(aeron_t *client);
```
"""
function aeron_main_do_work(client)
    @ccall libaeron.aeron_main_do_work(client::Ptr{aeron_t})::Cint
end

"""
    aeron_main_idle_strategy(client, work_count)

Call the Conductor Idle Strategy.

### Parameters
* `client`: to idle.
* `work_count`: to pass to idle strategy.
### Prototype
```c
void aeron_main_idle_strategy(aeron_t *client, int work_count);
```
"""
function aeron_main_idle_strategy(client, work_count)
    @ccall libaeron.aeron_main_idle_strategy(client::Ptr{aeron_t}, work_count::Cint)::Cvoid
end

"""
    aeron_close(client)

Close and delete [`aeron_t`](@ref) struct.

### Parameters
* `client`: to close and delete
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_close(aeron_t *client);
```
"""
function aeron_close(client)
    @ccall libaeron.aeron_close(client::Ptr{aeron_t})::Cint
end

"""
    aeron_is_closed(client)

Determines if the client has been closed, e.g. via a driver timeout. Don't call this method after calling [`aeron_close`](@ref) as that will have already freed the associated memory.

### Parameters
* `client`: to check if closed.
### Returns
true if it has been closed, false otherwise.
### Prototype
```c
bool aeron_is_closed(aeron_t *client);
```
"""
function aeron_is_closed(client)
    @ccall libaeron.aeron_is_closed(client::Ptr{aeron_t})::Bool
end

"""
    aeron_print_counters(client, stream_out)

Call stream\\_out to print the counter labels and values.

### Parameters
* `client`: to get the counters from.
* `stream_out`: to call for each label and value.
### Prototype
```c
void aeron_print_counters(aeron_t *client, void (*stream_out)(const char *));
```
"""
function aeron_print_counters(client, stream_out)
    @ccall libaeron.aeron_print_counters(client::Ptr{aeron_t}, stream_out::Ptr{Cvoid})::Cvoid
end

"""
    aeron_context(client)

Return the [`aeron_context_t`](@ref) that is in use by the given client.

### Parameters
* `client`: to return the [`aeron_context_t`](@ref) for.
### Returns
the [`aeron_context_t`](@ref) for the given client or NULL for an error.
### Prototype
```c
aeron_context_t *aeron_context(aeron_t *client);
```
"""
function aeron_context(client)
    @ccall libaeron.aeron_context(client::Ptr{aeron_t})::Ptr{aeron_context_t}
end

"""
    aeron_client_id(client)

Return the client id in use by the client.

### Parameters
* `client`: to return the client id for.
### Returns
id value or -1 for an error.
### Prototype
```c
int64_t aeron_client_id(aeron_t *client);
```
"""
function aeron_client_id(client)
    @ccall libaeron.aeron_client_id(client::Ptr{aeron_t})::Int64
end

"""
    aeron_next_correlation_id(client)

Return a unique correlation id from the driver.

### Parameters
* `client`: to use to get the id.
### Returns
unique correlation id or -1 for an error.
### Prototype
```c
int64_t aeron_next_correlation_id(aeron_t *client);
```
"""
function aeron_next_correlation_id(client)
    @ccall libaeron.aeron_next_correlation_id(client::Ptr{aeron_t})::Int64
end

"""
    aeron_async_add_publication(async, client, uri, stream_id)

Asynchronously add a publication using the given client and return an object to use to determine when the publication is available.

### Parameters
* `async`: object to use for polling completion.
* `client`: to add the publication to.
* `uri`: for the channel of the publication.
* `stream_id`: for the publication.
### Returns
0 for success or -1 for an error.
### Prototype
```c
int aeron_async_add_publication( aeron_async_add_publication_t **async, aeron_t *client, const char *uri, int32_t stream_id);
```
"""
function aeron_async_add_publication(async, client, uri, stream_id)
    @ccall libaeron.aeron_async_add_publication(async::Ptr{Ptr{aeron_async_add_publication_t}}, client::Ptr{aeron_t}, uri::Cstring, stream_id::Int32)::Cint
end

"""
    aeron_async_add_publication_poll(publication, async)

Poll the completion of the [`aeron_async_add_publication`](@ref) call.

### Parameters
* `publication`: to set if completed successfully.
* `async`: to check for completion.
### Returns
0 for not complete (try again), 1 for completed successfully, or -1 for an error.
### Prototype
```c
int aeron_async_add_publication_poll(aeron_publication_t **publication, aeron_async_add_publication_t *async);
```
"""
function aeron_async_add_publication_poll(publication, async)
    @ccall libaeron.aeron_async_add_publication_poll(publication::Ptr{Ptr{aeron_publication_t}}, async::Ptr{aeron_async_add_publication_t})::Cint
end

"""
    aeron_async_add_exclusive_publication(async, client, uri, stream_id)

Asynchronously add an exclusive publication using the given client and return an object to use to determine when the publication is available.

### Parameters
* `async`: object to use for polling completion.
* `client`: to add the publication to.
* `uri`: for the channel of the publication.
* `stream_id`: for the publication.
### Returns
0 for success or -1 for an error.
### Prototype
```c
int aeron_async_add_exclusive_publication( aeron_async_add_exclusive_publication_t **async, aeron_t *client, const char *uri, int32_t stream_id);
```
"""
function aeron_async_add_exclusive_publication(async, client, uri, stream_id)
    @ccall libaeron.aeron_async_add_exclusive_publication(async::Ptr{Ptr{aeron_async_add_exclusive_publication_t}}, client::Ptr{aeron_t}, uri::Cstring, stream_id::Int32)::Cint
end

"""
    aeron_async_add_exclusive_publication_poll(publication, async)

Poll the completion of the [`aeron_async_add_exclusive_publication`](@ref) call.

### Parameters
* `publication`: to set if completed successfully.
* `async`: to check for completion.
### Returns
0 for not complete (try again), 1 for completed successfully, or -1 for an error.
### Prototype
```c
int aeron_async_add_exclusive_publication_poll( aeron_exclusive_publication_t **publication, aeron_async_add_exclusive_publication_t *async);
```
"""
function aeron_async_add_exclusive_publication_poll(publication, async)
    @ccall libaeron.aeron_async_add_exclusive_publication_poll(publication::Ptr{Ptr{aeron_exclusive_publication_t}}, async::Ptr{aeron_async_add_exclusive_publication_t})::Cint
end

"""
    aeron_async_add_subscription(async, client, uri, stream_id, on_available_image_handler, on_available_image_clientd, on_unavailable_image_handler, on_unavailable_image_clientd)

Asynchronously add a subscription using the given client and return an object to use to determine when the subscription is available.

### Parameters
* `async`: object to use for polling completion.
* `client`: to add the subscription to.
* `uri`: for the channel of the subscription.
* `stream_id`: for the subscription.
* `on_available_image_handler`: to be called when images become available on the subscription.
* `on_available_image_clientd`: to be passed when images become available on the subscription.
* `on_unavailable_image_handler`: to be called when images go unavailable on the subscription.
* `on_available_image_clientd`: to be called when images go unavailable on the subscription.
### Returns
0 for success or -1 for an error.
### Prototype
```c
int aeron_async_add_subscription( aeron_async_add_subscription_t **async, aeron_t *client, const char *uri, int32_t stream_id, aeron_on_available_image_t on_available_image_handler, void *on_available_image_clientd, aeron_on_unavailable_image_t on_unavailable_image_handler, void *on_unavailable_image_clientd);
```
"""
function aeron_async_add_subscription(async, client, uri, stream_id, on_available_image_handler, on_available_image_clientd, on_unavailable_image_handler, on_unavailable_image_clientd)
    @ccall libaeron.aeron_async_add_subscription(async::Ptr{Ptr{aeron_async_add_subscription_t}}, client::Ptr{aeron_t}, uri::Cstring, stream_id::Int32, on_available_image_handler::aeron_on_available_image_t, on_available_image_clientd::Ptr{Cvoid}, on_unavailable_image_handler::aeron_on_unavailable_image_t, on_unavailable_image_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_async_add_subscription_poll(subscription, async)

Poll the completion of the [`aeron_async_add_subscription`](@ref) call.

### Parameters
* `subscription`: to set if completed successfully.
* `async`: to check for completion.
### Returns
0 for not complete (try again), 1 for completed successfully, or -1 for an error.
### Prototype
```c
int aeron_async_add_subscription_poll(aeron_subscription_t **subscription, aeron_async_add_subscription_t *async);
```
"""
function aeron_async_add_subscription_poll(subscription, async)
    @ccall libaeron.aeron_async_add_subscription_poll(subscription::Ptr{Ptr{aeron_subscription_t}}, async::Ptr{aeron_async_add_subscription_t})::Cint
end

"""
    aeron_counters_reader(client)

Return a reference to the counters reader of the given client.

The [`aeron_counters_reader_t`](@ref) is maintained by the client. And should not be freed.

### Parameters
* `client`: that contains the counters reader.
### Returns
[`aeron_counters_reader_t`](@ref) or NULL for error.
### Prototype
```c
aeron_counters_reader_t *aeron_counters_reader(aeron_t *client);
```
"""
function aeron_counters_reader(client)
    @ccall libaeron.aeron_counters_reader(client::Ptr{aeron_t})::Ptr{aeron_counters_reader_t}
end

"""
    aeron_async_add_counter(async, client, type_id, key_buffer, key_buffer_length, label_buffer, label_buffer_length)

Asynchronously add a counter using the given client and return an object to use to determine when the counter is available.

### Parameters
* `async`: object to use for polling completion.
* `client`: to add the counter to.
* `type_id`: for the counter.
* `key_buffer`: for the counter.
* `key_buffer_length`: for the counter.
* `label_buffer`: for the counter.
* `label_buffer_length`: for the counter.
### Returns
0 for success or -1 for an error.
### Prototype
```c
int aeron_async_add_counter( aeron_async_add_counter_t **async, aeron_t *client, int32_t type_id, const uint8_t *key_buffer, size_t key_buffer_length, const char *label_buffer, size_t label_buffer_length);
```
"""
function aeron_async_add_counter(async, client, type_id, key_buffer, key_buffer_length, label_buffer, label_buffer_length)
    @ccall libaeron.aeron_async_add_counter(async::Ptr{Ptr{aeron_async_add_counter_t}}, client::Ptr{aeron_t}, type_id::Int32, key_buffer::Ptr{UInt8}, key_buffer_length::Csize_t, label_buffer::Cstring, label_buffer_length::Csize_t)::Cint
end

"""
    aeron_async_add_counter_poll(counter, async)

Poll the completion of the [`aeron_async_add_counter`](@ref) call.

### Parameters
* `counter`: to set if completed successfully.
* `async`: to check for completion.
### Returns
0 for not complete (try again), 1 for completed successfully, or -1 for an error.
### Prototype
```c
int aeron_async_add_counter_poll(aeron_counter_t **counter, aeron_async_add_counter_t *async);
```
"""
function aeron_async_add_counter_poll(counter, async)
    @ccall libaeron.aeron_async_add_counter_poll(counter::Ptr{Ptr{aeron_counter_t}}, async::Ptr{aeron_async_add_counter_t})::Cint
end

"""
    aeron_add_available_counter_handler(client, pair)

Add a handler to be called when a new counter becomes available.

NOTE: This function blocks until the handler is added by the client conductor thread.

### Parameters
* `client`: for the counter
* `pair`: holding the handler to call and a clientd to pass when called.
### Returns
0 for success and -1 for error
### Prototype
```c
int aeron_add_available_counter_handler(aeron_t *client, aeron_on_available_counter_pair_t *pair);
```
"""
function aeron_add_available_counter_handler(client, pair)
    @ccall libaeron.aeron_add_available_counter_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_available_counter_pair_t})::Cint
end

"""
    aeron_remove_available_counter_handler(client, pair)

Remove a previously added handler to be called when a new counter becomes available.

NOTE: This function blocks until the handler is removed by the client conductor thread.

### Parameters
* `client`: for the counter
* `pair`: holding the handler to call and a clientd to pass when called.
### Returns
0 for success and -1 for error
### Prototype
```c
int aeron_remove_available_counter_handler(aeron_t *client, aeron_on_available_counter_pair_t *pair);
```
"""
function aeron_remove_available_counter_handler(client, pair)
    @ccall libaeron.aeron_remove_available_counter_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_available_counter_pair_t})::Cint
end

"""
    aeron_add_unavailable_counter_handler(client, pair)

Add a handler to be called when a new counter becomes unavailable or goes away.

NOTE: This function blocks until the handler is added by the client conductor thread.

### Parameters
* `client`: for the counter
* `pair`: holding the handler to call and a clientd to pass when called.
### Returns
0 for success and -1 for error
### Prototype
```c
int aeron_add_unavailable_counter_handler(aeron_t *client, aeron_on_unavailable_counter_pair_t *pair);
```
"""
function aeron_add_unavailable_counter_handler(client, pair)
    @ccall libaeron.aeron_add_unavailable_counter_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_unavailable_counter_pair_t})::Cint
end

"""
    aeron_remove_unavailable_counter_handler(client, pair)

Remove a previously added handler to be called when a new counter becomes unavailable or goes away.

NOTE: This function blocks until the handler is removed by the client conductor thread.

### Parameters
* `client`: for the counter
* `pair`: holding the handler to call and a clientd to pass when called.
### Returns
0 for success and -1 for error
### Prototype
```c
int aeron_remove_unavailable_counter_handler(aeron_t *client, aeron_on_unavailable_counter_pair_t *pair);
```
"""
function aeron_remove_unavailable_counter_handler(client, pair)
    @ccall libaeron.aeron_remove_unavailable_counter_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_unavailable_counter_pair_t})::Cint
end

"""
    aeron_add_close_handler(client, pair)

Add a handler to be called when client is closed.

NOTE: This function blocks until the handler is added by the client conductor thread.

### Parameters
* `client`: for the counter
* `pair`: holding the handler to call and a clientd to pass when called.
### Returns
0 for success and -1 for error
### Prototype
```c
int aeron_add_close_handler(aeron_t *client, aeron_on_close_client_pair_t *pair);
```
"""
function aeron_add_close_handler(client, pair)
    @ccall libaeron.aeron_add_close_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_close_client_pair_t})::Cint
end

"""
    aeron_remove_close_handler(client, pair)

Remove a previously added handler to be called when client is closed.

NOTE: This function blocks until the handler is removed by the client conductor thread.

### Parameters
* `client`: for the counter
* `pair`: holding the handler to call and a clientd to pass when called.
### Returns
0 for success and -1 for error
### Prototype
```c
int aeron_remove_close_handler(aeron_t *client, aeron_on_close_client_pair_t *pair);
```
"""
function aeron_remove_close_handler(client, pair)
    @ccall libaeron.aeron_remove_close_handler(client::Ptr{aeron_t}, pair::Ptr{aeron_on_close_client_pair_t})::Cint
end

mutable struct aeron_counters_reader_buffers_stct
    values::Ptr{UInt8}
    metadata::Ptr{UInt8}
    values_length::Csize_t
    metadata_length::Csize_t
    aeron_counters_reader_buffers_stct() = new()
end

const aeron_counters_reader_buffers_t = aeron_counters_reader_buffers_stct

"""
    aeron_counters_reader_get_buffers(reader, buffers)

Get buffer pointers and lengths for the counters reader.

### Parameters
* `reader`: reader containing the buffers.
* `buffers`: output structure to return the buffers.
### Returns
-1 on failure, 0 on success.
### Prototype
```c
int aeron_counters_reader_get_buffers(aeron_counters_reader_t *reader, aeron_counters_reader_buffers_t *buffers);
```
"""
function aeron_counters_reader_get_buffers(reader, buffers)
    @ccall libaeron.aeron_counters_reader_get_buffers(reader::Ptr{aeron_counters_reader_t}, buffers::Ptr{aeron_counters_reader_buffers_t})::Cint
end

# typedef void ( * aeron_counters_reader_foreach_counter_func_t ) ( int64_t value , int32_t id , int32_t type_id , const uint8_t * key , size_t key_length , const char * label , size_t label_length , void * clientd )
"""
Function called by [`aeron_counters_reader_foreach_counter`](@ref) for each counter in the [`aeron_counters_reader_t`](@ref).

### Parameters
* `value`: of the counter.
* `id`: of the counter.
* `label`: for the counter.
* `label_length`: for the counter.
* `clientd`: to be returned in the call
"""
const aeron_counters_reader_foreach_counter_func_t = Ptr{Cvoid}

"""
    aeron_counters_reader_foreach_counter(counters_reader, func, clientd)

Iterate over the counters in the counters\\_reader and call the given function for each counter.

### Parameters
* `counters_reader`: to iterate over.
* `func`: to call for each counter.
* `clientd`: to pass for each call to func.
### Prototype
```c
void aeron_counters_reader_foreach_counter( aeron_counters_reader_t *counters_reader, aeron_counters_reader_foreach_counter_func_t func, void *clientd);
```
"""
function aeron_counters_reader_foreach_counter(counters_reader, func, clientd)
    @ccall libaeron.aeron_counters_reader_foreach_counter(counters_reader::Ptr{aeron_counters_reader_t}, func::aeron_counters_reader_foreach_counter_func_t, clientd::Ptr{Cvoid})::Cvoid
end

"""
    aeron_counters_reader_max_counter_id(reader)

Get the current max counter id.

### Parameters
* `reader`: to query
### Returns
-1 on failure, max counter id on success.
### Prototype
```c
int32_t aeron_counters_reader_max_counter_id(aeron_counters_reader_t *reader);
```
"""
function aeron_counters_reader_max_counter_id(reader)
    @ccall libaeron.aeron_counters_reader_max_counter_id(reader::Ptr{aeron_counters_reader_t})::Int32
end

"""
    aeron_counters_reader_addr(counters_reader, counter_id)

Get the address for a counter.

### Parameters
* `counters_reader`: that contains the counter
* `counter_id`: to find
### Returns
address of the counter value
### Prototype
```c
int64_t *aeron_counters_reader_addr(aeron_counters_reader_t *counters_reader, int32_t counter_id);
```
"""
function aeron_counters_reader_addr(counters_reader, counter_id)
    @ccall libaeron.aeron_counters_reader_addr(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32)::Ptr{Int64}
end

"""
    aeron_counters_reader_counter_registration_id(counters_reader, counter_id, registration_id)

Get the registration id assigned to a counter.

### Parameters
* `counters_reader`: representing the this pointer.
* `counter_id`: for which the registration id requested.
* `registration_id`: pointer for value to be set on success.
### Returns
-1 on failure, 0 on success.
### Prototype
```c
int aeron_counters_reader_counter_registration_id( aeron_counters_reader_t *counters_reader, int32_t counter_id, int64_t *registration_id);
```
"""
function aeron_counters_reader_counter_registration_id(counters_reader, counter_id, registration_id)
    @ccall libaeron.aeron_counters_reader_counter_registration_id(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, registration_id::Ptr{Int64})::Cint
end

"""
    aeron_counters_reader_counter_owner_id(counters_reader, counter_id, owner_id)

Get the owner id assigned to a counter which will typically be the client id.

### Parameters
* `counters_reader`: representing the this pointer.
* `counter_id`: for which the registration id requested.
* `owner_id`: pointer for value to be set on success.
### Returns
-1 on failure, 0 on success.
### Prototype
```c
int aeron_counters_reader_counter_owner_id( aeron_counters_reader_t *counters_reader, int32_t counter_id, int64_t *owner_id);
```
"""
function aeron_counters_reader_counter_owner_id(counters_reader, counter_id, owner_id)
    @ccall libaeron.aeron_counters_reader_counter_owner_id(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, owner_id::Ptr{Int64})::Cint
end

"""
    aeron_counters_reader_counter_state(counters_reader, counter_id, state)

Get the state for a counter.

### Parameters
* `counters_reader`: that contains the counter
* `counter_id`: to find
* `state`: out pointer for the current state to be stored in.
### Returns
-1 on failure, 0 on success.
### Prototype
```c
int aeron_counters_reader_counter_state(aeron_counters_reader_t *counters_reader, int32_t counter_id, int32_t *state);
```
"""
function aeron_counters_reader_counter_state(counters_reader, counter_id, state)
    @ccall libaeron.aeron_counters_reader_counter_state(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, state::Ptr{Int32})::Cint
end

"""
    aeron_counters_reader_counter_type_id(counters_reader, counter_id, type_id)

Get the type id for a counter.

### Parameters
* `counters_reader`: that contains the counter
* `counter_id`: to find
* `type`: id out pointer for the current state to be stored in.
### Returns
-1 on failure, 0 on success.
### Prototype
```c
int aeron_counters_reader_counter_type_id( aeron_counters_reader_t *counters_reader, int32_t counter_id, int32_t *type_id);
```
"""
function aeron_counters_reader_counter_type_id(counters_reader, counter_id, type_id)
    @ccall libaeron.aeron_counters_reader_counter_type_id(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, type_id::Ptr{Int32})::Cint
end

"""
    aeron_counters_reader_counter_label(counters_reader, counter_id, buffer, buffer_length)

Get the label for a counter.

### Parameters
* `counters_reader`: that contains the counter
* `counter_id`: to find
* `buffer`: to store the counter in.
* `buffer_length`: length of the output buffer
### Returns
-1 on failure, number of characters copied to buffer on success.
### Prototype
```c
int aeron_counters_reader_counter_label( aeron_counters_reader_t *counters_reader, int32_t counter_id, char *buffer, size_t buffer_length);
```
"""
function aeron_counters_reader_counter_label(counters_reader, counter_id, buffer, buffer_length)
    @ccall libaeron.aeron_counters_reader_counter_label(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, buffer::Cstring, buffer_length::Csize_t)::Cint
end

"""
    aeron_counters_reader_free_for_reuse_deadline_ms(counters_reader, counter_id, deadline_ms)

Get the free for reuse deadline (ms) for a counter.

### Parameters
* `counters_reader`: that contains the counter.
* `counter_id`: to find.
* `deadline_ms`: output value to store the deadline.
### Returns
-1 on failure, 0 on success.
### Prototype
```c
int aeron_counters_reader_free_for_reuse_deadline_ms( aeron_counters_reader_t *counters_reader, int32_t counter_id, int64_t *deadline_ms);
```
"""
function aeron_counters_reader_free_for_reuse_deadline_ms(counters_reader, counter_id, deadline_ms)
    @ccall libaeron.aeron_counters_reader_free_for_reuse_deadline_ms(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, deadline_ms::Ptr{Int64})::Cint
end

# typedef int64_t ( * aeron_reserved_value_supplier_t ) ( void * clientd , uint8_t * buffer , size_t frame_length )
"""
Function called when filling in the reserved value field of a message.

### Parameters
* `clientd`: passed to the offer function.
* `buffer`: of the entire frame, including Aeron data header.
* `frame_length`: of the entire frame.
"""
const aeron_reserved_value_supplier_t = Ptr{Cvoid}

mutable struct aeron_iovec_stct
    iov_base::Ptr{UInt8}
    iov_len::Csize_t
    aeron_iovec_stct() = new()
end

const aeron_iovec_t = aeron_iovec_stct

"""
    aeron_buffer_claim_commit(buffer_claim)

Commit the given buffer\\_claim as a complete message available for consumption.

### Parameters
* `buffer_claim`: to commit.
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_buffer_claim_commit(aeron_buffer_claim_t *buffer_claim);
```
"""
function aeron_buffer_claim_commit(buffer_claim)
    @ccall libaeron.aeron_buffer_claim_commit(buffer_claim::Ptr{aeron_buffer_claim_t})::Cint
end

"""
    aeron_buffer_claim_abort(buffer_claim)

Abort the given buffer\\_claim and assign its position as padding.

### Parameters
* `buffer_claim`: to abort.
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_buffer_claim_abort(aeron_buffer_claim_t *buffer_claim);
```
"""
function aeron_buffer_claim_abort(buffer_claim)
    @ccall libaeron.aeron_buffer_claim_abort(buffer_claim::Ptr{aeron_buffer_claim_t})::Cint
end

"""
    aeron_publication_constants_stct

Configuration for a publication that does not change during it's lifetime.
"""
mutable struct aeron_publication_constants_stct
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
    aeron_publication_constants_stct() = new()
end

"""
Configuration for a publication that does not change during it's lifetime.
"""
const aeron_publication_constants_t = aeron_publication_constants_stct

"""
    aeron_publication_offer(publication, buffer, length, reserved_value_supplier, clientd)

Non-blocking publish of a buffer containing a message.

### Parameters
* `publication`: to publish on.
* `buffer`: to publish.
* `length`: of the buffer.
* `reserved_value_supplier`: to use for setting the reserved value field or NULL.
* `clientd`: to pass to the reserved\\_value\\_supplier.
### Returns
the new stream position otherwise a negative error value.
### Prototype
```c
int64_t aeron_publication_offer( aeron_publication_t *publication, const uint8_t *buffer, size_t length, aeron_reserved_value_supplier_t reserved_value_supplier, void *clientd);
```
"""
function aeron_publication_offer(publication, buffer, length, reserved_value_supplier, clientd)
    @ccall libaeron.aeron_publication_offer(publication::Ptr{aeron_publication_t}, buffer::Ptr{UInt8}, length::Csize_t, reserved_value_supplier::aeron_reserved_value_supplier_t, clientd::Ptr{Cvoid})::Int64
end

"""
    aeron_publication_offerv(publication, iov, iovcnt, reserved_value_supplier, clientd)

Non-blocking publish by gathering buffer vectors into a message.

### Parameters
* `publication`: to publish on.
* `iov`: array for the vectors
* `iovcnt`: of the number of vectors
* `reserved_value_supplier`: to use for setting the reserved value field or NULL.
* `clientd`: to pass to the reserved\\_value\\_supplier.
### Returns
the new stream position otherwise a negative error value.
### Prototype
```c
int64_t aeron_publication_offerv( aeron_publication_t *publication, aeron_iovec_t *iov, size_t iovcnt, aeron_reserved_value_supplier_t reserved_value_supplier, void *clientd);
```
"""
function aeron_publication_offerv(publication, iov, iovcnt, reserved_value_supplier, clientd)
    @ccall libaeron.aeron_publication_offerv(publication::Ptr{aeron_publication_t}, iov::Ptr{aeron_iovec_t}, iovcnt::Csize_t, reserved_value_supplier::aeron_reserved_value_supplier_t, clientd::Ptr{Cvoid})::Int64
end

"""
    aeron_publication_try_claim(publication, length, buffer_claim)

Try to claim a range in the publication log into which a message can be written with zero copy semantics. Once the message has been written then [`aeron_buffer_claim_commit`](@ref) should be called thus making it available. A claim length cannot be greater than max payload length. <p> <b>Note:</b> This method can only be used for message lengths less than MTU length minus header. If the claim is held for more than the aeron.publication.unblock.timeout system property then the driver will assume the publication thread is dead and will unblock the claim thus allowing other threads to make progress and other claims to be sent to reach end-of-stream (EOS).

```c++
 aeron_buffer_claim_t buffer_claim;
 if (aeron_publication_try_claim(publication, length, &buffer_claim) > 0L)
 {
     // work with buffer_claim->data directly.
     aeron_buffer_claim_commit(&buffer_claim);
 }
```

### Parameters
* `publication`: to publish to.
* `length`: of the message.
* `buffer_claim`: to be populated if the claim succeeds.
### Returns
the new stream position otherwise a negative error value.
### Prototype
```c
int64_t aeron_publication_try_claim( aeron_publication_t *publication, size_t length, aeron_buffer_claim_t *buffer_claim);
```
"""
function aeron_publication_try_claim(publication, length, buffer_claim)
    @ccall libaeron.aeron_publication_try_claim(publication::Ptr{aeron_publication_t}, length::Csize_t, buffer_claim::Ptr{aeron_buffer_claim_t})::Int64
end

"""
    aeron_publication_channel_status(publication)

Get the status of the media channel for this publication. <p> The status will be ERRORED (-1) if a socket exception occurs on setup and ACTIVE (1) if all is well.

### Parameters
* `publication`: to check status of.
### Returns
1 for ACTIVE, -1 for ERRORED
### Prototype
```c
int64_t aeron_publication_channel_status(aeron_publication_t *publication);
```
"""
function aeron_publication_channel_status(publication)
    @ccall libaeron.aeron_publication_channel_status(publication::Ptr{aeron_publication_t})::Int64
end

"""
    aeron_publication_is_closed(publication)

Has the publication closed?

### Parameters
* `publication`: to check
### Returns
true if this publication is closed.
### Prototype
```c
bool aeron_publication_is_closed(aeron_publication_t *publication);
```
"""
function aeron_publication_is_closed(publication)
    @ccall libaeron.aeron_publication_is_closed(publication::Ptr{aeron_publication_t})::Bool
end

"""
    aeron_publication_is_connected(publication)

Has the publication seen an active Subscriber recently?

### Parameters
* `publication`: to check.
### Returns
true if this publication has recently seen an active subscriber otherwise false.
### Prototype
```c
bool aeron_publication_is_connected(aeron_publication_t *publication);
```
"""
function aeron_publication_is_connected(publication)
    @ccall libaeron.aeron_publication_is_connected(publication::Ptr{aeron_publication_t})::Bool
end

"""
    aeron_publication_constants(publication, constants)

Fill in a structure with the constants in use by a publication.

### Parameters
* `publication`: to get the constants for.
* `constants`: structure to fill in with the constants
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_publication_constants(aeron_publication_t *publication, aeron_publication_constants_t *constants);
```
"""
function aeron_publication_constants(publication, constants)
    @ccall libaeron.aeron_publication_constants(publication::Ptr{aeron_publication_t}, constants::Ptr{aeron_publication_constants_t})::Cint
end

"""
    aeron_publication_position(publication)

Get the current position to which the publication has advanced for this stream.

### Parameters
* `publication`: to query.
### Returns
the current position to which the publication has advanced for this stream or a negative error value.
### Prototype
```c
int64_t aeron_publication_position(aeron_publication_t *publication);
```
"""
function aeron_publication_position(publication)
    @ccall libaeron.aeron_publication_position(publication::Ptr{aeron_publication_t})::Int64
end

"""
    aeron_publication_position_limit(publication)

Get the position limit beyond which this publication will be back pressured.

This should only be used as a guide to determine when back pressure is likely to be applied.

### Parameters
* `publication`: to query.
### Returns
the position limit beyond which this publication will be back pressured or a negative error value.
### Prototype
```c
int64_t aeron_publication_position_limit(aeron_publication_t *publication);
```
"""
function aeron_publication_position_limit(publication)
    @ccall libaeron.aeron_publication_position_limit(publication::Ptr{aeron_publication_t})::Int64
end

"""
    aeron_publication_async_add_destination(async, client, publication, uri)

Add a destination manually to a multi-destination-cast publication.

### Parameters
* `async`: object to use for polling completion.
* `publication`: to add destination to.
* `uri`: for the destination to add.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_publication_async_add_destination( aeron_async_destination_t **async, aeron_t *client, aeron_publication_t *publication, const char *uri);
```
"""
function aeron_publication_async_add_destination(async, client, publication, uri)
    @ccall libaeron.aeron_publication_async_add_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, publication::Ptr{aeron_publication_t}, uri::Cstring)::Cint
end

"""
    aeron_publication_async_remove_destination(async, client, publication, uri)

Remove a destination manually from a multi-destination-cast publication.

### Parameters
* `async`: object to use for polling completion.
* `publication`: to remove destination from.
* `uri`: for the destination to remove.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_publication_async_remove_destination( aeron_async_destination_t **async, aeron_t *client, aeron_publication_t *publication, const char *uri);
```
"""
function aeron_publication_async_remove_destination(async, client, publication, uri)
    @ccall libaeron.aeron_publication_async_remove_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, publication::Ptr{aeron_publication_t}, uri::Cstring)::Cint
end

"""
    aeron_publication_async_destination_poll(async)

Poll the completion of the add/remove of a destination to/from a publication.

### Parameters
* `async`: to check for completion.
### Returns
0 for not complete (try again), 1 for completed successfully, or -1 for an error.
### Prototype
```c
int aeron_publication_async_destination_poll(aeron_async_destination_t *async);
```
"""
function aeron_publication_async_destination_poll(async)
    @ccall libaeron.aeron_publication_async_destination_poll(async::Ptr{aeron_async_destination_t})::Cint
end

"""
    aeron_exclusive_publication_async_add_destination(async, client, publication, uri)

Add a destination manually to a multi-destination-cast exclusive publication.

### Parameters
* `async`: object to use for polling completion.
* `publication`: to add destination to.
* `uri`: for the destination to add.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_exclusive_publication_async_add_destination( aeron_async_destination_t **async, aeron_t *client, aeron_exclusive_publication_t *publication, const char *uri);
```
"""
function aeron_exclusive_publication_async_add_destination(async, client, publication, uri)
    @ccall libaeron.aeron_exclusive_publication_async_add_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, publication::Ptr{aeron_exclusive_publication_t}, uri::Cstring)::Cint
end

"""
    aeron_exclusive_publication_async_remove_destination(async, client, publication, uri)

Remove a destination manually from a multi-destination-cast exclusive publication.

### Parameters
* `async`: object to use for polling completion.
* `publication`: to remove destination from.
* `uri`: for the destination to remove.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_exclusive_publication_async_remove_destination( aeron_async_destination_t **async, aeron_t *client, aeron_exclusive_publication_t *publication, const char *uri);
```
"""
function aeron_exclusive_publication_async_remove_destination(async, client, publication, uri)
    @ccall libaeron.aeron_exclusive_publication_async_remove_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, publication::Ptr{aeron_exclusive_publication_t}, uri::Cstring)::Cint
end

"""
    aeron_exclusive_publication_async_destination_poll(async)

Poll the completion of the add/remove of a destination to/from an exclusive publication.

### Parameters
* `async`: to check for completion.
### Returns
0 for not complete (try again), 1 for completed successfully, or -1 for an error.
### Prototype
```c
int aeron_exclusive_publication_async_destination_poll(aeron_async_destination_t *async);
```
"""
function aeron_exclusive_publication_async_destination_poll(async)
    @ccall libaeron.aeron_exclusive_publication_async_destination_poll(async::Ptr{aeron_async_destination_t})::Cint
end

"""
    aeron_publication_close(publication, on_close_complete, on_close_complete_clientd)

Asynchronously close the publication. Will callback on the on\\_complete notification when the subscription is closed. The callback is optional, use NULL for the on\\_complete callback if not required.

### Parameters
* `publication`: to close
* `on_close_complete`: optional callback to execute once the subscription has been closed and freed. This may happen on a separate thread, so the caller should ensure that clientd has the appropriate lifetime.
* `on_close_complete_clientd`: parameter to pass to the on\\_complete callback.
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_publication_close( aeron_publication_t *publication, aeron_notification_t on_close_complete, void *on_close_complete_clientd);
```
"""
function aeron_publication_close(publication, on_close_complete, on_close_complete_clientd)
    @ccall libaeron.aeron_publication_close(publication::Ptr{aeron_publication_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_publication_channel(publication)

Get the publication's channel

### Parameters
* `publication`: this
### Returns
channel uri string
### Prototype
```c
const char *aeron_publication_channel(aeron_publication_t *publication);
```
"""
function aeron_publication_channel(publication)
    @ccall libaeron.aeron_publication_channel(publication::Ptr{aeron_publication_t})::Cstring
end

"""
    aeron_publication_stream_id(publication)

Get the publication's stream id

### Parameters
* `publication`: this
### Returns
stream id
### Prototype
```c
int32_t aeron_publication_stream_id(aeron_publication_t *publication);
```
"""
function aeron_publication_stream_id(publication)
    @ccall libaeron.aeron_publication_stream_id(publication::Ptr{aeron_publication_t})::Int32
end

"""
    aeron_publication_session_id(publication)

Get the publication's session id

### Parameters
* `publication`: this
### Returns
session id
### Prototype
```c
int32_t aeron_publication_session_id(aeron_publication_t *publication);
```
"""
function aeron_publication_session_id(publication)
    @ccall libaeron.aeron_publication_session_id(publication::Ptr{aeron_publication_t})::Int32
end

"""
    aeron_publication_local_sockaddrs(publication, address_vec, address_vec_len)

Get all of the local socket addresses for this publication. Typically only one representing the control address.

### Parameters
* `subscription`: to query
* `address_vec`: to hold the received addresses
* `address_vec_len`: available length of the vector to hold the addresses
### Returns
number of addresses found or -1 if there is an error.
### See also
[`aeron_subscription_local_sockaddrs`](@ref)

### Prototype
```c
int aeron_publication_local_sockaddrs( aeron_publication_t *publication, aeron_iovec_t *address_vec, size_t address_vec_len);
```
"""
function aeron_publication_local_sockaddrs(publication, address_vec, address_vec_len)
    @ccall libaeron.aeron_publication_local_sockaddrs(publication::Ptr{aeron_publication_t}, address_vec::Ptr{aeron_iovec_t}, address_vec_len::Csize_t)::Cint
end

"""
    aeron_exclusive_publication_offer(publication, buffer, length, reserved_value_supplier, clientd)

Non-blocking publish of a buffer containing a message.

### Parameters
* `publication`: to publish on.
* `buffer`: to publish.
* `length`: of the buffer.
* `reserved_value_supplier`: to use for setting the reserved value field or NULL.
* `clientd`: to pass to the reserved\\_value\\_supplier.
### Returns
the new stream position otherwise a negative error value.
### Prototype
```c
int64_t aeron_exclusive_publication_offer( aeron_exclusive_publication_t *publication, const uint8_t *buffer, size_t length, aeron_reserved_value_supplier_t reserved_value_supplier, void *clientd);
```
"""
function aeron_exclusive_publication_offer(publication, buffer, length, reserved_value_supplier, clientd)
    @ccall libaeron.aeron_exclusive_publication_offer(publication::Ptr{aeron_exclusive_publication_t}, buffer::Ptr{UInt8}, length::Csize_t, reserved_value_supplier::aeron_reserved_value_supplier_t, clientd::Ptr{Cvoid})::Int64
end

"""
    aeron_exclusive_publication_offerv(publication, iov, iovcnt, reserved_value_supplier, clientd)

Non-blocking publish by gathering buffer vectors into a message.

### Parameters
* `publication`: to publish on.
* `iov`: array for the vectors
* `iovcnt`: of the number of vectors
* `reserved_value_supplier`: to use for setting the reserved value field or NULL.
* `clientd`: to pass to the reserved\\_value\\_supplier.
### Returns
the new stream position otherwise a negative error value.
### Prototype
```c
int64_t aeron_exclusive_publication_offerv( aeron_exclusive_publication_t *publication, aeron_iovec_t *iov, size_t iovcnt, aeron_reserved_value_supplier_t reserved_value_supplier, void *clientd);
```
"""
function aeron_exclusive_publication_offerv(publication, iov, iovcnt, reserved_value_supplier, clientd)
    @ccall libaeron.aeron_exclusive_publication_offerv(publication::Ptr{aeron_exclusive_publication_t}, iov::Ptr{aeron_iovec_t}, iovcnt::Csize_t, reserved_value_supplier::aeron_reserved_value_supplier_t, clientd::Ptr{Cvoid})::Int64
end

"""
    aeron_exclusive_publication_try_claim(publication, length, buffer_claim)

Try to claim a range in the publication log into which a message can be written with zero copy semantics. Once the message has been written then [`aeron_buffer_claim_commit`](@ref) should be called thus making it available. A claim length cannot be greater than max payload length. <p> <b>Note:</b> This method can only be used for message lengths less than MTU length minus header.

```c++
 aeron_buffer_claim_t buffer_claim;
 if (aeron_exclusive_publication_try_claim(publication, length, &buffer_claim) > 0L)
 {
     // work with buffer_claim->data directly.
     aeron_buffer_claim_commit(&buffer_claim);
 }
```

### Parameters
* `publication`: to publish to.
* `length`: of the message.
* `buffer_claim`: to be populated if the claim succeeds.
### Returns
the new stream position otherwise a negative error value.
### Prototype
```c
int64_t aeron_exclusive_publication_try_claim( aeron_exclusive_publication_t *publication, size_t length, aeron_buffer_claim_t *buffer_claim);
```
"""
function aeron_exclusive_publication_try_claim(publication, length, buffer_claim)
    @ccall libaeron.aeron_exclusive_publication_try_claim(publication::Ptr{aeron_exclusive_publication_t}, length::Csize_t, buffer_claim::Ptr{aeron_buffer_claim_t})::Int64
end

"""
    aeron_exclusive_publication_append_padding(publication, length)

Append a padding record log of a given length to make up the log to a position.

### Parameters
* `length`: of the range to claim, in bytes.
### Returns
the new stream position otherwise a negative error value.
### Prototype
```c
int64_t aeron_exclusive_publication_append_padding(aeron_exclusive_publication_t *publication, size_t length);
```
"""
function aeron_exclusive_publication_append_padding(publication, length)
    @ccall libaeron.aeron_exclusive_publication_append_padding(publication::Ptr{aeron_exclusive_publication_t}, length::Csize_t)::Int64
end

"""
    aeron_exclusive_publication_offer_block(publication, buffer, length)

Offer a block of pre-formatted message fragments directly into the current term.

### Parameters
* `buffer`: containing the pre-formatted block of message fragments.
* `offset`: offset in the buffer at which the first fragment begins.
* `length`: in bytes of the encoded block.
### Returns
the new stream position otherwise a negative error value.
### Prototype
```c
int64_t aeron_exclusive_publication_offer_block( aeron_exclusive_publication_t *publication, const uint8_t *buffer, size_t length);
```
"""
function aeron_exclusive_publication_offer_block(publication, buffer, length)
    @ccall libaeron.aeron_exclusive_publication_offer_block(publication::Ptr{aeron_exclusive_publication_t}, buffer::Ptr{UInt8}, length::Csize_t)::Int64
end

"""
    aeron_exclusive_publication_channel_status(publication)

Get the status of the media channel for this publication. <p> The status will be ERRORED (-1) if a socket exception occurs on setup and ACTIVE (1) if all is well.

### Parameters
* `publication`: to check status of.
### Returns
1 for ACTIVE, -1 for ERRORED
### Prototype
```c
int64_t aeron_exclusive_publication_channel_status(aeron_exclusive_publication_t *publication);
```
"""
function aeron_exclusive_publication_channel_status(publication)
    @ccall libaeron.aeron_exclusive_publication_channel_status(publication::Ptr{aeron_exclusive_publication_t})::Int64
end

"""
    aeron_exclusive_publication_constants(publication, constants)

Fill in a structure with the constants in use by a publication.

### Parameters
* `publication`: to get the constants for.
* `constants`: structure to fill in with the constants
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_exclusive_publication_constants( aeron_exclusive_publication_t *publication, aeron_publication_constants_t *constants);
```
"""
function aeron_exclusive_publication_constants(publication, constants)
    @ccall libaeron.aeron_exclusive_publication_constants(publication::Ptr{aeron_exclusive_publication_t}, constants::Ptr{aeron_publication_constants_t})::Cint
end

"""
    aeron_exclusive_publication_position(publication)

Get the current position to which the publication has advanced for this stream.

### Parameters
* `publication`: to query.
### Returns
the current position to which the publication has advanced for this stream or a negative error value.
### Prototype
```c
int64_t aeron_exclusive_publication_position(aeron_exclusive_publication_t *publication);
```
"""
function aeron_exclusive_publication_position(publication)
    @ccall libaeron.aeron_exclusive_publication_position(publication::Ptr{aeron_exclusive_publication_t})::Int64
end

"""
    aeron_exclusive_publication_position_limit(publication)

Get the position limit beyond which this publication will be back pressured.

This should only be used as a guide to determine when back pressure is likely to be applied.

### Parameters
* `publication`: to query.
### Returns
the position limit beyond which this publication will be back pressured or a negative error value.
### Prototype
```c
int64_t aeron_exclusive_publication_position_limit(aeron_exclusive_publication_t *publication);
```
"""
function aeron_exclusive_publication_position_limit(publication)
    @ccall libaeron.aeron_exclusive_publication_position_limit(publication::Ptr{aeron_exclusive_publication_t})::Int64
end

"""
    aeron_exclusive_publication_close(publication, on_close_complete, on_close_complete_clientd)

Asynchronously close the publication.

### Parameters
* `publication`: to close
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_exclusive_publication_close( aeron_exclusive_publication_t *publication, aeron_notification_t on_close_complete, void *on_close_complete_clientd);
```
"""
function aeron_exclusive_publication_close(publication, on_close_complete, on_close_complete_clientd)
    @ccall libaeron.aeron_exclusive_publication_close(publication::Ptr{aeron_exclusive_publication_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_exclusive_publication_is_closed(publication)

Has the exclusive publication closed?

### Parameters
* `publication`: to check
### Returns
true if this publication is closed.
### Prototype
```c
bool aeron_exclusive_publication_is_closed(aeron_exclusive_publication_t *publication);
```
"""
function aeron_exclusive_publication_is_closed(publication)
    @ccall libaeron.aeron_exclusive_publication_is_closed(publication::Ptr{aeron_exclusive_publication_t})::Bool
end

"""
    aeron_exclusive_publication_is_connected(publication)

Has the exclusive publication seen an active Subscriber recently?

### Parameters
* `publication`: to check.
### Returns
true if this publication has recently seen an active subscriber otherwise false.
### Prototype
```c
bool aeron_exclusive_publication_is_connected(aeron_exclusive_publication_t *publication);
```
"""
function aeron_exclusive_publication_is_connected(publication)
    @ccall libaeron.aeron_exclusive_publication_is_connected(publication::Ptr{aeron_exclusive_publication_t})::Bool
end

"""
    aeron_exclusive_publication_local_sockaddrs(publication, address_vec, address_vec_len)

Get all of the local socket addresses for this exclusive publication. Typically only one representing the control address.

### Parameters
* `subscription`: to query
* `address_vec`: to hold the received addresses
* `address_vec_len`: available length of the vector to hold the addresses
### Returns
number of addresses found or -1 if there is an error.
### See also
[`aeron_subscription_local_sockaddrs`](@ref)

### Prototype
```c
int aeron_exclusive_publication_local_sockaddrs( aeron_exclusive_publication_t *publication, aeron_iovec_t *address_vec, size_t address_vec_len);
```
"""
function aeron_exclusive_publication_local_sockaddrs(publication, address_vec, address_vec_len)
    @ccall libaeron.aeron_exclusive_publication_local_sockaddrs(publication::Ptr{aeron_exclusive_publication_t}, address_vec::Ptr{aeron_iovec_t}, address_vec_len::Csize_t)::Cint
end

@cenum aeron_controlled_fragment_handler_action_en::UInt32 begin
    AERON_ACTION_ABORT = 1
    AERON_ACTION_BREAK = 2
    AERON_ACTION_COMMIT = 3
    AERON_ACTION_CONTINUE = 4
end

const aeron_controlled_fragment_handler_action_t = aeron_controlled_fragment_handler_action_en

# typedef void ( * aeron_block_handler_t ) ( void * clientd , const uint8_t * buffer , size_t length , int32_t session_id , int32_t term_id )
"""
Callback for handling a block of messages being read from a log.

### Parameters
* `clientd`: passed to the block poll function.
* `buffer`: containing the block of message fragments.
* `offset`: at which the block begins, including any frame headers.
* `length`: of the block in bytes, including any frame headers that is aligned.
* `session_id`: of the stream containing this block of message fragments.
* `term_id`: of the stream containing this block of message fragments.
"""
const aeron_block_handler_t = Ptr{Cvoid}

"""
    aeron_header_values(header, values)

Get all of the field values from the header. This will do a memcpy into the supplied header\\_values\\_t pointer.

### Parameters
* `header`: to read values from.
* `values`: to copy values to, must not be null.
### Returns
0 on success, -1 on failure.
### Prototype
```c
int aeron_header_values(aeron_header_t *header, aeron_header_values_t *values);
```
"""
function aeron_header_values(header, values)
    @ccall libaeron.aeron_header_values(header::Ptr{aeron_header_t}, values::Ptr{aeron_header_values_t})::Cint
end

"""
    aeron_header_position(header)

Get the current position to which the Image has advanced on reading this message.

### Parameters
* `header`: the current header message
### Returns
the current position to which the Image has advanced on reading this message.
### Prototype
```c
int64_t aeron_header_position(aeron_header_t *header);
```
"""
function aeron_header_position(header)
    @ccall libaeron.aeron_header_position(header::Ptr{aeron_header_t})::Int64
end

"""
    aeron_header_position_bits_to_shift(header)

Get the number of times to left shift the term count to multiply by term length.

### Returns
number of times to left shift the term count to multiply by term length.
### Prototype
```c
size_t aeron_header_position_bits_to_shift(aeron_header_t *header);
```
"""
function aeron_header_position_bits_to_shift(header)
    @ccall libaeron.aeron_header_position_bits_to_shift(header::Ptr{aeron_header_t})::Csize_t
end

mutable struct aeron_subscription_constants_stct
    channel::Cstring
    on_available_image::aeron_on_available_image_t
    on_unavailable_image::aeron_on_unavailable_image_t
    registration_id::Int64
    stream_id::Int32
    channel_status_indicator_id::Int32
    aeron_subscription_constants_stct() = new()
end

const aeron_subscription_constants_t = aeron_subscription_constants_stct

"""
    aeron_subscription_poll(subscription, handler, clientd, fragment_limit)

Poll the images under the subscription for available message fragments. <p> Each fragment read will be a whole message if it is under MTU length. If larger than MTU then it will come as a series of fragments ordered within a session. <p> To assemble messages that span multiple fragments then use [`aeron_fragment_assembler_t`](@ref).

### Parameters
* `subscription`: to poll.
* `handler`: for handling each message fragment as it is read.
* `fragment_limit`: number of message fragments to limit when polling across multiple images.
### Returns
the number of fragments received or -1 for error.
### Prototype
```c
int aeron_subscription_poll( aeron_subscription_t *subscription, aeron_fragment_handler_t handler, void *clientd, size_t fragment_limit);
```
"""
function aeron_subscription_poll(subscription, handler, clientd, fragment_limit)
    @ccall libaeron.aeron_subscription_poll(subscription::Ptr{aeron_subscription_t}, handler::aeron_fragment_handler_t, clientd::Ptr{Cvoid}, fragment_limit::Csize_t)::Cint
end

"""
    aeron_subscription_controlled_poll(subscription, handler, clientd, fragment_limit)

Poll in a controlled manner the images under the subscription for available message fragments. Control is applied to fragments in the stream. If more fragments can be read on another stream they will even if BREAK or ABORT is returned from the fragment handler. <p> Each fragment read will be a whole message if it is under MTU length. If larger than MTU then it will come as a series of fragments ordered within a session. <p> To assemble messages that span multiple fragments then use [`aeron_controlled_fragment_assembler_t`](@ref).

### Parameters
* `subscription`: to poll.
* `handler`: for handling each message fragment as it is read.
* `fragment_limit`: number of message fragments to limit when polling across multiple images.
### Returns
the number of fragments received or -1 for error.
### Prototype
```c
int aeron_subscription_controlled_poll( aeron_subscription_t *subscription, aeron_controlled_fragment_handler_t handler, void *clientd, size_t fragment_limit);
```
"""
function aeron_subscription_controlled_poll(subscription, handler, clientd, fragment_limit)
    @ccall libaeron.aeron_subscription_controlled_poll(subscription::Ptr{aeron_subscription_t}, handler::aeron_controlled_fragment_handler_t, clientd::Ptr{Cvoid}, fragment_limit::Csize_t)::Cint
end

"""
    aeron_subscription_block_poll(subscription, handler, clientd, block_length_limit)

Poll the images under the subscription for available message fragments in blocks. <p> This method is useful for operations like bulk archiving and messaging indexing.

### Parameters
* `subscription`: to poll.
* `handler`: to receive a block of fragments from each image.
* `block_length_limit`: for each image polled.
### Returns
the number of bytes consumed or -1 for error.
### Prototype
```c
long aeron_subscription_block_poll( aeron_subscription_t *subscription, aeron_block_handler_t handler, void *clientd, size_t block_length_limit);
```
"""
function aeron_subscription_block_poll(subscription, handler, clientd, block_length_limit)
    @ccall libaeron.aeron_subscription_block_poll(subscription::Ptr{aeron_subscription_t}, handler::aeron_block_handler_t, clientd::Ptr{Cvoid}, block_length_limit::Csize_t)::Clong
end

"""
    aeron_subscription_is_connected(subscription)

Is this subscription connected by having at least one open publication image.

### Parameters
* `subscription`: to check.
### Returns
true if this subscription connected by having at least one open publication image.
### Prototype
```c
bool aeron_subscription_is_connected(aeron_subscription_t *subscription);
```
"""
function aeron_subscription_is_connected(subscription)
    @ccall libaeron.aeron_subscription_is_connected(subscription::Ptr{aeron_subscription_t})::Bool
end

"""
    aeron_subscription_constants(subscription, constants)

Fill in a structure with the constants in use by a subscription.

### Parameters
* `subscription`: to get the constants for.
* `constants`: structure to fill in with the constants
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_subscription_constants(aeron_subscription_t *subscription, aeron_subscription_constants_t *constants);
```
"""
function aeron_subscription_constants(subscription, constants)
    @ccall libaeron.aeron_subscription_constants(subscription::Ptr{aeron_subscription_t}, constants::Ptr{aeron_subscription_constants_t})::Cint
end

"""
    aeron_subscription_image_count(subscription)

Count of images associated to this subscription.

### Parameters
* `subscription`: to count images for.
### Returns
count of count associated to this subscription or -1 for error.
### Prototype
```c
int aeron_subscription_image_count(aeron_subscription_t *subscription);
```
"""
function aeron_subscription_image_count(subscription)
    @ccall libaeron.aeron_subscription_image_count(subscription::Ptr{aeron_subscription_t})::Cint
end

"""
    aeron_subscription_image_by_session_id(subscription, session_id)

Return the image associated with the given session\\_id under the given subscription.

Note: the returned image is considered retained by the application and thus must be released via aeron\\_image\\_release when finished or if the image becomes unavailable.

### Parameters
* `subscription`: to search.
* `session_id`: associated with the image.
### Returns
image associated with the given session\\_id or NULL if no image exists.
### Prototype
```c
aeron_image_t *aeron_subscription_image_by_session_id(aeron_subscription_t *subscription, int32_t session_id);
```
"""
function aeron_subscription_image_by_session_id(subscription, session_id)
    @ccall libaeron.aeron_subscription_image_by_session_id(subscription::Ptr{aeron_subscription_t}, session_id::Int32)::Ptr{aeron_image_t}
end

"""
    aeron_subscription_image_at_index(subscription, index)

Return the image at the given index.

Note: the returned image is considered retained by the application and thus must be released via aeron\\_image\\_release when finished or if the image becomes unavailable.

### Parameters
* `subscription`: to search.
* `index`: for the image.
### Returns
image at the given index or NULL if no image exists.
### Prototype
```c
aeron_image_t *aeron_subscription_image_at_index(aeron_subscription_t *subscription, size_t index);
```
"""
function aeron_subscription_image_at_index(subscription, index)
    @ccall libaeron.aeron_subscription_image_at_index(subscription::Ptr{aeron_subscription_t}, index::Csize_t)::Ptr{aeron_image_t}
end

"""
    aeron_subscription_for_each_image(subscription, handler, clientd)

Iterate over the images for this subscription calling the given function.

### Parameters
* `subscription`: to iterate over.
* `handler`: to be called for each image.
### Prototype
```c
void aeron_subscription_for_each_image( aeron_subscription_t *subscription, void (*handler)(aeron_image_t *image, void *clientd), void *clientd);
```
"""
function aeron_subscription_for_each_image(subscription, handler, clientd)
    @ccall libaeron.aeron_subscription_for_each_image(subscription::Ptr{aeron_subscription_t}, handler::Ptr{Cvoid}, clientd::Ptr{Cvoid})::Cvoid
end

"""
    aeron_subscription_image_retain(subscription, image)

Retain the given image for access in the application.

Note: A retain call must have a corresponding release call. Note: Subscriptions are not threadsafe and should not be shared between subscribers.

### Parameters
* `subscription`: that image is part of.
* `image`: to retain
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_subscription_image_retain(aeron_subscription_t *subscription, aeron_image_t *image);
```
"""
function aeron_subscription_image_retain(subscription, image)
    @ccall libaeron.aeron_subscription_image_retain(subscription::Ptr{aeron_subscription_t}, image::Ptr{aeron_image_t})::Cint
end

"""
    aeron_subscription_image_release(subscription, image)

Release the given image and relinquish desire to use the image directly.

Note: Subscriptions are not threadsafe and should not be shared between subscribers.

### Parameters
* `subscription`: that image is part of.
* `image`: to release
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_subscription_image_release(aeron_subscription_t *subscription, aeron_image_t *image);
```
"""
function aeron_subscription_image_release(subscription, image)
    @ccall libaeron.aeron_subscription_image_release(subscription::Ptr{aeron_subscription_t}, image::Ptr{aeron_image_t})::Cint
end

"""
    aeron_subscription_is_closed(subscription)

Is the subscription closed.

### Parameters
* `subscription`: to be checked.
### Returns
true if it has been closed otherwise false.
### Prototype
```c
bool aeron_subscription_is_closed(aeron_subscription_t *subscription);
```
"""
function aeron_subscription_is_closed(subscription)
    @ccall libaeron.aeron_subscription_is_closed(subscription::Ptr{aeron_subscription_t})::Bool
end

"""
    aeron_subscription_channel_status(subscription)

Get the status of the media channel for this subscription. <p> The status will be ERRORED (-1) if a socket exception occurs on setup and ACTIVE (1) if all is well.

### Parameters
* `subscription`: to check status of.
### Returns
1 for ACTIVE, -1 for ERRORED
### Prototype
```c
int64_t aeron_subscription_channel_status(aeron_subscription_t *subscription);
```
"""
function aeron_subscription_channel_status(subscription)
    @ccall libaeron.aeron_subscription_channel_status(subscription::Ptr{aeron_subscription_t})::Int64
end

"""
    aeron_subscription_async_add_destination(async, client, subscription, uri)

Add a destination manually to a multi-destination-subscription.

### Parameters
* `async`: object to use for polling completion.
* `subscription`: to add destination to.
* `uri`: for the destination to add.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_subscription_async_add_destination( aeron_async_destination_t **async, aeron_t *client, aeron_subscription_t *subscription, const char *uri);
```
"""
function aeron_subscription_async_add_destination(async, client, subscription, uri)
    @ccall libaeron.aeron_subscription_async_add_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, subscription::Ptr{aeron_subscription_t}, uri::Cstring)::Cint
end

"""
    aeron_subscription_async_remove_destination(async, client, subscription, uri)

Remove a destination manually from a multi-destination-subscription.

### Parameters
* `async`: object to use for polling completion.
* `subscription`: to remove destination from.
* `uri`: for the destination to remove.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_subscription_async_remove_destination( aeron_async_destination_t **async, aeron_t *client, aeron_subscription_t *subscription, const char *uri);
```
"""
function aeron_subscription_async_remove_destination(async, client, subscription, uri)
    @ccall libaeron.aeron_subscription_async_remove_destination(async::Ptr{Ptr{aeron_async_destination_t}}, client::Ptr{aeron_t}, subscription::Ptr{aeron_subscription_t}, uri::Cstring)::Cint
end

"""
    aeron_subscription_async_destination_poll(async)

Poll the completion of add/remove of a destination to/from a subscription.

### Parameters
* `async`: to check for completion.
### Returns
0 for not complete (try again), 1 for completed successfully, or -1 for an error.
### Prototype
```c
int aeron_subscription_async_destination_poll(aeron_async_destination_t *async);
```
"""
function aeron_subscription_async_destination_poll(async)
    @ccall libaeron.aeron_subscription_async_destination_poll(async::Ptr{aeron_async_destination_t})::Cint
end

"""
    aeron_subscription_close(subscription, on_close_complete, on_close_complete_clientd)

Asynchronously close the subscription. Will callback on the on\\_complete notification when the subscription is closed. The callback is optional, use NULL for the on\\_complete callback if not required.

### Parameters
* `subscription`: to close
* `on_close_complete`: optional callback to execute once the subscription has been closed and freed. This may happen on a separate thread, so the caller should ensure that clientd has the appropriate lifetime.
* `on_close_complete_clientd`: parameter to pass to the on\\_complete callback.
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_subscription_close( aeron_subscription_t *subscription, aeron_notification_t on_close_complete, void *on_close_complete_clientd);
```
"""
function aeron_subscription_close(subscription, on_close_complete, on_close_complete_clientd)
    @ccall libaeron.aeron_subscription_close(subscription::Ptr{aeron_subscription_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_subscription_local_sockaddrs(subscription, address_vec, address_vec_len)

Get all of the local socket addresses for this subscription. Multiple addresses can occur if this is a multi-destination subscription. Addresses will a string representation in numeric form. IPv6 addresses will be surrounded by '[' and ']' so that the ':' that separate the parts are distinguishable from the port delimiter. E.g. [fe80::7552:c06e:6bf4:4160]:12345. As of writing the maximum length for a formatted address is 54 bytes including the NULL terminator. [`AERON_CLIENT_MAX_LOCAL_ADDRESS_STR_LEN`](@ref) is defined to provide enough space to fit the returned string. Returned strings will be NULL terminated. If the buffer to hold the address can not hold enough of the message it will be truncated and the last character will be null.

If the address\\_vec\\_len is less the total number of addresses available then the first addresses found up to that length will be placed into the address\\_vec. However the function will return the total number of addresses available so if if that is larger than the input array then the client code may wish to re-query with a larger array to get them all.

### Parameters
* `subscription`: to query
* `address_vec`: to hold the received addresses
* `address_vec_len`: available length of the vector to hold the addresses
### Returns
number of addresses found or -1 if there is an error.
### Prototype
```c
int aeron_subscription_local_sockaddrs( aeron_subscription_t *subscription, aeron_iovec_t *address_vec, size_t address_vec_len);
```
"""
function aeron_subscription_local_sockaddrs(subscription, address_vec, address_vec_len)
    @ccall libaeron.aeron_subscription_local_sockaddrs(subscription::Ptr{aeron_subscription_t}, address_vec::Ptr{aeron_iovec_t}, address_vec_len::Csize_t)::Cint
end

"""
    aeron_subscription_resolved_endpoint(subscription, address, address_len)

Retrieves the first local socket address for this subscription. If this is not MDS then it will be the one representing endpoint for this subscription.

### Parameters
* `subscription`: to query
* `address`: for the received address
* `address_len`: available length for the copied address.
### Returns
-1 on error, 0 if address not found, 1 if address is found.
### See also
[`aeron_subscription_local_sockaddrs`](@ref)

### Prototype
```c
int aeron_subscription_resolved_endpoint(aeron_subscription_t *subscription, const char *address, size_t address_len);
```
"""
function aeron_subscription_resolved_endpoint(subscription, address, address_len)
    @ccall libaeron.aeron_subscription_resolved_endpoint(subscription::Ptr{aeron_subscription_t}, address::Cstring, address_len::Csize_t)::Cint
end

"""
    aeron_subscription_try_resolve_channel_endpoint_port(subscription, uri, uri_len)

Retrieves the channel URI for this subscription with any wildcard ports filled in. If the channel is not UDP or does not have a wildcard port (`0`), then it will return the original URI.

### Parameters
* `subscription`: to query
* `uri`: buffer to hold the resolved uri
* `uri_len`: length of the buffer
### Returns
-1 on failure or the number of bytes written to the buffer (excluding the NULL terminator). Writing is done on a per key basis, so if the buffer was truncated before writing completed, it will only include the byte count up to the key that overflowed. However, the invariant that if the number returned >= uri\\_len, then output will have been truncated.
### Prototype
```c
int aeron_subscription_try_resolve_channel_endpoint_port( aeron_subscription_t *subscription, char *uri, size_t uri_len);
```
"""
function aeron_subscription_try_resolve_channel_endpoint_port(subscription, uri, uri_len)
    @ccall libaeron.aeron_subscription_try_resolve_channel_endpoint_port(subscription::Ptr{aeron_subscription_t}, uri::Cstring, uri_len::Csize_t)::Cint
end

"""
    aeron_image_constants_stct

Configuration for an image that does not change during it's lifetime.
"""
mutable struct aeron_image_constants_stct
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
    aeron_image_constants_stct() = new()
end

"""
Configuration for an image that does not change during it's lifetime.
"""
const aeron_image_constants_t = aeron_image_constants_stct

"""
    aeron_image_constants(image, constants)

Fill in a structure with the constants in use by a image.

### Parameters
* `image`: to get the constants for.
* `constants`: structure to fill in with the constants
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_image_constants(aeron_image_t *image, aeron_image_constants_t *constants);
```
"""
function aeron_image_constants(image, constants)
    @ccall libaeron.aeron_image_constants(image::Ptr{aeron_image_t}, constants::Ptr{aeron_image_constants_t})::Cint
end

"""
    aeron_image_position(image)

The position this image has been consumed to by the subscriber.

### Parameters
* `image`: to query position of.
### Returns
the position this image has been consumed to by the subscriber.
### Prototype
```c
int64_t aeron_image_position(aeron_image_t *image);
```
"""
function aeron_image_position(image)
    @ccall libaeron.aeron_image_position(image::Ptr{aeron_image_t})::Int64
end

"""
    aeron_image_set_position(image, position)

Set the subscriber position for this image to indicate where it has been consumed to.

### Parameters
* `image`: to set the position of.
* `new_position`: for the consumption point.
### Prototype
```c
int aeron_image_set_position(aeron_image_t *image, int64_t position);
```
"""
function aeron_image_set_position(image, position)
    @ccall libaeron.aeron_image_set_position(image::Ptr{aeron_image_t}, position::Int64)::Cint
end

"""
    aeron_image_is_end_of_stream(image)

Is the current consumed position at the end of the stream?

### Parameters
* `image`: to check.
### Returns
true if at the end of the stream or false if not.
### Prototype
```c
bool aeron_image_is_end_of_stream(aeron_image_t *image);
```
"""
function aeron_image_is_end_of_stream(image)
    @ccall libaeron.aeron_image_is_end_of_stream(image::Ptr{aeron_image_t})::Bool
end

"""
    aeron_image_active_transport_count(image)

Count of observed active transports within the image liveness timeout.

If the image is closed, then this is 0. This may also be 0 if no actual datagrams have arrived. IPC Images also will be 0.

### Parameters
* `image`: to check.
### Returns
count of active transports - 0 if Image is closed, no datagrams yet, or IPC. Or -1 for error.
### Prototype
```c
int aeron_image_active_transport_count(aeron_image_t *image);
```
"""
function aeron_image_active_transport_count(image)
    @ccall libaeron.aeron_image_active_transport_count(image::Ptr{aeron_image_t})::Cint
end

"""
    aeron_image_poll(image, handler, clientd, fragment_limit)

Poll for new messages in a stream. If new messages are found beyond the last consumed position then they will be delivered to the handler up to a limited number of fragments as specified. <p> Use a fragment assembler to assemble messages which span multiple fragments.

### Parameters
* `image`: to poll.
* `handler`: to which message fragments are delivered.
* `clientd`: to pass to the handler.
* `fragment_limit`: for the number of fragments to be consumed during one polling operation.
### Returns
the number of fragments that have been consumed or -1 for error.
### Prototype
```c
int aeron_image_poll(aeron_image_t *image, aeron_fragment_handler_t handler, void *clientd, size_t fragment_limit);
```
"""
function aeron_image_poll(image, handler, clientd, fragment_limit)
    @ccall libaeron.aeron_image_poll(image::Ptr{aeron_image_t}, handler::aeron_fragment_handler_t, clientd::Ptr{Cvoid}, fragment_limit::Csize_t)::Cint
end

"""
    aeron_image_controlled_poll(image, handler, clientd, fragment_limit)

Poll for new messages in a stream. If new messages are found beyond the last consumed position then they will be delivered to the handler up to a limited number of fragments as specified. <p> Use a controlled fragment assembler to assemble messages which span multiple fragments.

### Parameters
* `image`: to poll.
* `handler`: to which message fragments are delivered.
* `clientd`: to pass to the handler.
* `fragment_limit`: for the number of fragments to be consumed during one polling operation.
### Returns
the number of fragments that have been consumed or -1 for error.
### Prototype
```c
int aeron_image_controlled_poll( aeron_image_t *image, aeron_controlled_fragment_handler_t handler, void *clientd, size_t fragment_limit);
```
"""
function aeron_image_controlled_poll(image, handler, clientd, fragment_limit)
    @ccall libaeron.aeron_image_controlled_poll(image::Ptr{aeron_image_t}, handler::aeron_controlled_fragment_handler_t, clientd::Ptr{Cvoid}, fragment_limit::Csize_t)::Cint
end

"""
    aeron_image_bounded_poll(image, handler, clientd, limit_position, fragment_limit)

Poll for new messages in a stream. If new messages are found beyond the last consumed position then they will be delivered to the handler up to a limited number of fragments as specified or the maximum position specified. <p> Use a fragment assembler to assemble messages which span multiple fragments.

### Parameters
* `image`: to poll.
* `handler`: to which message fragments are delivered.
* `clientd`: to pass to the handler.
* `limit_position`: to consume messages up to.
* `fragment_limit`: for the number of fragments to be consumed during one polling operation.
### Returns
the number of fragments that have been consumed or -1 for error.
### Prototype
```c
int aeron_image_bounded_poll( aeron_image_t *image, aeron_fragment_handler_t handler, void *clientd, int64_t limit_position, size_t fragment_limit);
```
"""
function aeron_image_bounded_poll(image, handler, clientd, limit_position, fragment_limit)
    @ccall libaeron.aeron_image_bounded_poll(image::Ptr{aeron_image_t}, handler::aeron_fragment_handler_t, clientd::Ptr{Cvoid}, limit_position::Int64, fragment_limit::Csize_t)::Cint
end

"""
    aeron_image_bounded_controlled_poll(image, handler, clientd, limit_position, fragment_limit)

Poll for new messages in a stream. If new messages are found beyond the last consumed position then they will be delivered to the handler up to a limited number of fragments as specified or the maximum position specified. <p> Use a controlled fragment assembler to assemble messages which span multiple fragments.

### Parameters
* `image`: to poll.
* `handler`: to which message fragments are delivered.
* `clientd`: to pass to the handler.
* `limit_position`: to consume messages up to.
* `fragment_limit`: for the number of fragments to be consumed during one polling operation.
### Returns
the number of fragments that have been consumed or -1 for error.
### Prototype
```c
int aeron_image_bounded_controlled_poll( aeron_image_t *image, aeron_controlled_fragment_handler_t handler, void *clientd, int64_t limit_position, size_t fragment_limit);
```
"""
function aeron_image_bounded_controlled_poll(image, handler, clientd, limit_position, fragment_limit)
    @ccall libaeron.aeron_image_bounded_controlled_poll(image::Ptr{aeron_image_t}, handler::aeron_controlled_fragment_handler_t, clientd::Ptr{Cvoid}, limit_position::Int64, fragment_limit::Csize_t)::Cint
end

"""
    aeron_image_controlled_peek(image, initial_position, handler, clientd, limit_position)

Peek for new messages in a stream by scanning forward from an initial position. If new messages are found then they will be delivered to the handler up to a limited position. <p> Use a controlled fragment assembler to assemble messages which span multiple fragments. Scans must also start at the beginning of a message so that the assembler is reset.

### Parameters
* `image`: to peek.
* `initial_position`: from which to peek forward.
* `handler`: to which message fragments are delivered.
* `clientd`: to pass to the handler.
* `limit_position`: up to which can be scanned.
### Returns
the resulting position after the scan terminates which is a complete message or -1 for error.
### Prototype
```c
int64_t aeron_image_controlled_peek( aeron_image_t *image, int64_t initial_position, aeron_controlled_fragment_handler_t handler, void *clientd, int64_t limit_position);
```
"""
function aeron_image_controlled_peek(image, initial_position, handler, clientd, limit_position)
    @ccall libaeron.aeron_image_controlled_peek(image::Ptr{aeron_image_t}, initial_position::Int64, handler::aeron_controlled_fragment_handler_t, clientd::Ptr{Cvoid}, limit_position::Int64)::Int64
end

"""
    aeron_image_block_poll(image, handler, clientd, block_length_limit)

Poll for new messages in a stream. If new messages are found beyond the last consumed position then they will be delivered to the handler up to a limited number of bytes. <p> A scan will terminate if a padding frame is encountered. If first frame in a scan is padding then a block for the padding is notified. If the padding comes after the first frame in a scan then the scan terminates at the offset the padding frame begins. Padding frames are delivered singularly in a block. <p> Padding frames may be for a greater range than the limit offset but only the header needs to be valid so relevant length of the frame is data header length.

### Parameters
* `image`: to poll.
* `handler`: to which block is delivered.
* `clientd`: to pass to the handler.
* `block_length_limit`: up to which a block may be in length.
### Returns
the number of bytes that have been consumed or -1 for error.
### Prototype
```c
int aeron_image_block_poll( aeron_image_t *image, aeron_block_handler_t handler, void *clientd, size_t block_length_limit);
```
"""
function aeron_image_block_poll(image, handler, clientd, block_length_limit)
    @ccall libaeron.aeron_image_block_poll(image::Ptr{aeron_image_t}, handler::aeron_block_handler_t, clientd::Ptr{Cvoid}, block_length_limit::Csize_t)::Cint
end

"""
    aeron_image_is_closed(image)

### Prototype
```c
bool aeron_image_is_closed(aeron_image_t *image);
```
"""
function aeron_image_is_closed(image)
    @ccall libaeron.aeron_image_is_closed(image::Ptr{aeron_image_t})::Bool
end

"""
    aeron_image_fragment_assembler_create(assembler, delegate, delegate_clientd)

Create an image fragment assembler for use with a single image.

### Parameters
* `assembler`: to be set when created successfully.
* `delegate`: to call on completed.
* `delegate_clientd`: to pass to delegate handler.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_image_fragment_assembler_create( aeron_image_fragment_assembler_t **assembler, aeron_fragment_handler_t delegate, void *delegate_clientd);
```
"""
function aeron_image_fragment_assembler_create(assembler, delegate, delegate_clientd)
    @ccall libaeron.aeron_image_fragment_assembler_create(assembler::Ptr{Ptr{aeron_image_fragment_assembler_t}}, delegate::aeron_fragment_handler_t, delegate_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_image_fragment_assembler_delete(assembler)

Delete an image fragment assembler.

### Parameters
* `assembler`: to delete.
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_image_fragment_assembler_delete(aeron_image_fragment_assembler_t *assembler);
```
"""
function aeron_image_fragment_assembler_delete(assembler)
    @ccall libaeron.aeron_image_fragment_assembler_delete(assembler::Ptr{aeron_image_fragment_assembler_t})::Cint
end

"""
    aeron_image_fragment_assembler_handler(clientd, buffer, length, header)

Handler function to be passed for handling fragment assembly.

### Parameters
* `clientd`: passed in the poll call (must be a [`aeron_image_fragment_assembler_t`](@ref))
* `buffer`: containing the data.
* `length`: of the data in bytes.
* `header`: representing the meta data for the data.
### Prototype
```c
void aeron_image_fragment_assembler_handler( void *clientd, const uint8_t *buffer, size_t length, aeron_header_t *header);
```
"""
function aeron_image_fragment_assembler_handler(clientd, buffer, length, header)
    @ccall libaeron.aeron_image_fragment_assembler_handler(clientd::Ptr{Cvoid}, buffer::Ptr{UInt8}, length::Csize_t, header::Ptr{aeron_header_t})::Cvoid
end

"""
    aeron_image_controlled_fragment_assembler_create(assembler, delegate, delegate_clientd)

Create an image controlled fragment assembler for use with a single image.

### Parameters
* `assembler`: to be set when created successfully.
* `delegate`: to call on completed
* `delegate_clientd`: to pass to delegate handler.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_image_controlled_fragment_assembler_create( aeron_image_controlled_fragment_assembler_t **assembler, aeron_controlled_fragment_handler_t delegate, void *delegate_clientd);
```
"""
function aeron_image_controlled_fragment_assembler_create(assembler, delegate, delegate_clientd)
    @ccall libaeron.aeron_image_controlled_fragment_assembler_create(assembler::Ptr{Ptr{aeron_image_controlled_fragment_assembler_t}}, delegate::aeron_controlled_fragment_handler_t, delegate_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_image_controlled_fragment_assembler_delete(assembler)

Delete an image controlled fragment assembler.

### Parameters
* `assembler`: to delete.
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_image_controlled_fragment_assembler_delete(aeron_image_controlled_fragment_assembler_t *assembler);
```
"""
function aeron_image_controlled_fragment_assembler_delete(assembler)
    @ccall libaeron.aeron_image_controlled_fragment_assembler_delete(assembler::Ptr{aeron_image_controlled_fragment_assembler_t})::Cint
end

"""
    aeron_controlled_image_fragment_assembler_handler(clientd, buffer, length, header)

Handler function to be passed for handling fragment assembly.

### Parameters
* `clientd`: passed in the poll call (must be a [`aeron_image_controlled_fragment_assembler_t`](@ref))
* `buffer`: containing the data.
* `length`: of the data in bytes.
* `header`: representing the meta data for the data.
### Returns
The action to be taken with regard to the stream position after the callback.
### Prototype
```c
aeron_controlled_fragment_handler_action_t aeron_controlled_image_fragment_assembler_handler( void *clientd, const uint8_t *buffer, size_t length, aeron_header_t *header);
```
"""
function aeron_controlled_image_fragment_assembler_handler(clientd, buffer, length, header)
    @ccall libaeron.aeron_controlled_image_fragment_assembler_handler(clientd::Ptr{Cvoid}, buffer::Ptr{UInt8}, length::Csize_t, header::Ptr{aeron_header_t})::aeron_controlled_fragment_handler_action_t
end

"""
    aeron_fragment_assembler_create(assembler, delegate, delegate_clientd)

Create a fragment assembler for use with a subscription.

### Parameters
* `assembler`: to be set when created successfully.
* `delegate`: to call on completed
* `delegate_clientd`: to pass to delegate handler.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_fragment_assembler_create( aeron_fragment_assembler_t **assembler, aeron_fragment_handler_t delegate, void *delegate_clientd);
```
"""
function aeron_fragment_assembler_create(assembler, delegate, delegate_clientd)
    @ccall libaeron.aeron_fragment_assembler_create(assembler::Ptr{Ptr{aeron_fragment_assembler_t}}, delegate::aeron_fragment_handler_t, delegate_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_fragment_assembler_delete(assembler)

Delete a fragment assembler.

### Parameters
* `assembler`: to delete.
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_fragment_assembler_delete(aeron_fragment_assembler_t *assembler);
```
"""
function aeron_fragment_assembler_delete(assembler)
    @ccall libaeron.aeron_fragment_assembler_delete(assembler::Ptr{aeron_fragment_assembler_t})::Cint
end

"""
    aeron_fragment_assembler_handler(clientd, buffer, length, header)

Handler function to be passed for handling fragment assembly.

### Parameters
* `clientd`: passed in the poll call (must be a [`aeron_fragment_assembler_t`](@ref))
* `buffer`: containing the data.
* `length`: of the data in bytes.
* `header`: representing the meta data for the data.
### Prototype
```c
void aeron_fragment_assembler_handler( void *clientd, const uint8_t *buffer, size_t length, aeron_header_t *header);
```
"""
function aeron_fragment_assembler_handler(clientd, buffer, length, header)
    @ccall libaeron.aeron_fragment_assembler_handler(clientd::Ptr{Cvoid}, buffer::Ptr{UInt8}, length::Csize_t, header::Ptr{aeron_header_t})::Cvoid
end

"""
    aeron_controlled_fragment_assembler_create(assembler, delegate, delegate_clientd)

Create a controlled fragment assembler for use with a subscription.

### Parameters
* `assembler`: to be set when created successfully.
* `delegate`: to call on completed
* `delegate_clientd`: to pass to delegate handler.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_controlled_fragment_assembler_create( aeron_controlled_fragment_assembler_t **assembler, aeron_controlled_fragment_handler_t delegate, void *delegate_clientd);
```
"""
function aeron_controlled_fragment_assembler_create(assembler, delegate, delegate_clientd)
    @ccall libaeron.aeron_controlled_fragment_assembler_create(assembler::Ptr{Ptr{aeron_controlled_fragment_assembler_t}}, delegate::aeron_controlled_fragment_handler_t, delegate_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_controlled_fragment_assembler_delete(assembler)

Delete a controlled fragment assembler.

### Parameters
* `assembler`: to delete.
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_controlled_fragment_assembler_delete(aeron_controlled_fragment_assembler_t *assembler);
```
"""
function aeron_controlled_fragment_assembler_delete(assembler)
    @ccall libaeron.aeron_controlled_fragment_assembler_delete(assembler::Ptr{aeron_controlled_fragment_assembler_t})::Cint
end

"""
    aeron_controlled_fragment_assembler_handler(clientd, buffer, length, header)

Handler function to be passed for handling fragment assembly.

### Parameters
* `clientd`: passed in the poll call (must be a [`aeron_controlled_fragment_assembler_t`](@ref))
* `buffer`: containing the data.
* `length`: of the data in bytes.
* `header`: representing the meta data for the data.
### Returns
The action to be taken with regard to the stream position after the callback.
### Prototype
```c
aeron_controlled_fragment_handler_action_t aeron_controlled_fragment_assembler_handler( void *clientd, const uint8_t *buffer, size_t length, aeron_header_t *header);
```
"""
function aeron_controlled_fragment_assembler_handler(clientd, buffer, length, header)
    @ccall libaeron.aeron_controlled_fragment_assembler_handler(clientd::Ptr{Cvoid}, buffer::Ptr{UInt8}, length::Csize_t, header::Ptr{aeron_header_t})::aeron_controlled_fragment_handler_action_t
end

"""
    aeron_counter_addr(counter)

Return a pointer to the counter value.

### Parameters
* `counter`: to pointer to.
### Returns
pointer to the counter value.
### Prototype
```c
int64_t *aeron_counter_addr(aeron_counter_t *counter);
```
"""
function aeron_counter_addr(counter)
    @ccall libaeron.aeron_counter_addr(counter::Ptr{aeron_counter_t})::Ptr{Int64}
end

"""
    aeron_counter_constants_stct

Configuration for a counter that does not change during it's lifetime.
"""
mutable struct aeron_counter_constants_stct
    registration_id::Int64
    counter_id::Int32
    aeron_counter_constants_stct() = new()
end

"""
Configuration for a counter that does not change during it's lifetime.
"""
const aeron_counter_constants_t = aeron_counter_constants_stct

"""
    aeron_counter_constants(counter, constants)

Fill in a structure with the constants in use by a counter.

### Parameters
* `counter`: to get the constants for.
* `constants`: structure to fill in with the constants.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_counter_constants(aeron_counter_t *counter, aeron_counter_constants_t *constants);
```
"""
function aeron_counter_constants(counter, constants)
    @ccall libaeron.aeron_counter_constants(counter::Ptr{aeron_counter_t}, constants::Ptr{aeron_counter_constants_t})::Cint
end

"""
    aeron_counter_close(counter, on_close_complete, on_close_complete_clientd)

Asynchronously close the counter.

### Parameters
* `counter`: to close.
### Returns
0 for success or -1 for error.
### Prototype
```c
int aeron_counter_close( aeron_counter_t *counter, aeron_notification_t on_close_complete, void *on_close_complete_clientd);
```
"""
function aeron_counter_close(counter, on_close_complete, on_close_complete_clientd)
    @ccall libaeron.aeron_counter_close(counter::Ptr{aeron_counter_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_counter_is_closed(counter)

Check if the counter is closed

### Parameters
* `counter`: to check
### Returns
true if closed, false otherwise.
### Prototype
```c
bool aeron_counter_is_closed(aeron_counter_t *counter);
```
"""
function aeron_counter_is_closed(counter)
    @ccall libaeron.aeron_counter_is_closed(counter::Ptr{aeron_counter_t})::Bool
end

"""
    aeron_version_full()

Return full version and build string.

### Returns
full version and build string.
### Prototype
```c
const char *aeron_version_full(void);
```
"""
function aeron_version_full()
    @ccall libaeron.aeron_version_full()::Cstring
end

"""
    aeron_version_major()

Return major version number.

### Returns
major version number.
### Prototype
```c
int aeron_version_major(void);
```
"""
function aeron_version_major()
    @ccall libaeron.aeron_version_major()::Cint
end

"""
    aeron_version_minor()

Return minor version number.

### Returns
minor version number.
### Prototype
```c
int aeron_version_minor(void);
```
"""
function aeron_version_minor()
    @ccall libaeron.aeron_version_minor()::Cint
end

"""
    aeron_version_patch()

Return patch version number.

### Returns
patch version number.
### Prototype
```c
int aeron_version_patch(void);
```
"""
function aeron_version_patch()
    @ccall libaeron.aeron_version_patch()::Cint
end

"""
    aeron_nano_clock()

Return time in nanoseconds for machine. Is not wall clock time.

### Returns
nanoseconds since epoch for machine.
### Prototype
```c
int64_t aeron_nano_clock(void);
```
"""
function aeron_nano_clock()
    @ccall libaeron.aeron_nano_clock()::Int64
end

"""
    aeron_epoch_clock()

Return time in milliseconds since epoch. Is wall clock time.

### Returns
milliseconds since epoch.
### Prototype
```c
int64_t aeron_epoch_clock(void);
```
"""
function aeron_epoch_clock()
    @ccall libaeron.aeron_epoch_clock()::Int64
end

# typedef void ( * aeron_log_func_t ) ( const char * )
"""
Function to return logging information.
"""
const aeron_log_func_t = Ptr{Cvoid}

"""
    aeron_is_driver_active(dirname, timeout_ms, log_func)

Determine if an aeron driver is using a given aeron directory.

### Parameters
* `dirname`: for aeron directory
* `timeout_ms`: to use to determine activity for aeron directory
* `log_func`: to call during activity check to log diagnostic information.
### Returns
true for active driver or false for no active driver.
### Prototype
```c
bool aeron_is_driver_active(const char *dirname, int64_t timeout_ms, aeron_log_func_t log_func);
```
"""
function aeron_is_driver_active(dirname, timeout_ms, log_func)
    @ccall libaeron.aeron_is_driver_active(dirname::Cstring, timeout_ms::Int64, log_func::aeron_log_func_t)::Bool
end

"""
    aeron_properties_buffer_load(buffer)

Load properties from a string containing name=value pairs and set appropriate environment variables for the process so that subsequent calls to aeron\\_driver\\_context\\_init will use those values.

### Parameters
* `buffer`: containing properties and values.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_properties_buffer_load(const char *buffer);
```
"""
function aeron_properties_buffer_load(buffer)
    @ccall libaeron.aeron_properties_buffer_load(buffer::Cstring)::Cint
end

"""
    aeron_properties_file_load(filename)

Load properties file and set appropriate environment variables for the process so that subsequent calls to aeron\\_driver\\_context\\_init will use those values.

### Parameters
* `filename`: to load.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_properties_file_load(const char *filename);
```
"""
function aeron_properties_file_load(filename)
    @ccall libaeron.aeron_properties_file_load(filename::Cstring)::Cint
end

"""
    aeron_properties_http_load(url)

Load properties from HTTP URL and set environment variables for the process so that subsequent calls to aeron\\_driver\\_context\\_init will use those values.

### Parameters
* `url`: to attempt to retrieve and load.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_properties_http_load(const char *url);
```
"""
function aeron_properties_http_load(url)
    @ccall libaeron.aeron_properties_http_load(url::Cstring)::Cint
end

"""
    aeron_properties_load(url_or_filename)

Load properties based on URL or filename. If string contains file or http URL, it will attempt to load properties from a file or http as indicated. If not a URL, then it will try to load the string as a filename.

### Parameters
* `url_or_filename`: to load properties from.
### Returns
0 for success and -1 for error.
### Prototype
```c
int aeron_properties_load(const char *url_or_filename);
```
"""
function aeron_properties_load(url_or_filename)
    @ccall libaeron.aeron_properties_load(url_or_filename::Cstring)::Cint
end

"""
    aeron_errcode()

Return current aeron error code (errno) for calling thread.

### Returns
aeron error code for calling thread.
### Prototype
```c
int aeron_errcode(void);
```
"""
function aeron_errcode()
    @ccall libaeron.aeron_errcode()::Cint
end

"""
    aeron_errmsg()

Return the current aeron error message for calling thread.

### Returns
aeron error message for calling thread.
### Prototype
```c
const char *aeron_errmsg(void);
```
"""
function aeron_errmsg()
    @ccall libaeron.aeron_errmsg()::Cstring
end

"""
    aeron_default_path(path, path_length)

Get the default path used by the Aeron media driver.

### Parameters
* `path`: buffer to store the path.
* `path_length`: space available in the buffer
### Returns
-1 if there is an issue or the number of bytes written to path excluding the terminator `\\0`. If this is equal to or greater than the path\\_length then the path has been truncated.
### Prototype
```c
int aeron_default_path(char *path, size_t path_length);
```
"""
function aeron_default_path(path, path_length)
    @ccall libaeron.aeron_default_path(path::Cstring, path_length::Csize_t)::Cint
end

"""
    aeron_async_add_counter_get_registration_id(add_counter)

Gets the registration id for addition of the counter. Note that using this after a call to poll the succeeds or errors is undefined behaviour. As the async\\_add\\_counter\\_t may have been freed.

### Parameters
* `add_counter`: used to check for completion.
### Returns
registration id for the counter.
### Prototype
```c
int64_t aeron_async_add_counter_get_registration_id(aeron_async_add_counter_t *add_counter);
```
"""
function aeron_async_add_counter_get_registration_id(add_counter)
    @ccall libaeron.aeron_async_add_counter_get_registration_id(add_counter::Ptr{aeron_async_add_counter_t})::Int64
end

"""
    aeron_async_add_publication_get_registration_id(add_publication)

Gets the registration id for addition of the publication. Note that using this after a call to poll the succeeds or errors is undefined behaviour. As the async\\_add\\_publication\\_t may have been freed.

### Parameters
* `add_publication`: used to check for completion.
### Returns
registration id for the publication.
### Prototype
```c
int64_t aeron_async_add_publication_get_registration_id(aeron_async_add_publication_t *add_publication);
```
"""
function aeron_async_add_publication_get_registration_id(add_publication)
    @ccall libaeron.aeron_async_add_publication_get_registration_id(add_publication::Ptr{aeron_async_add_publication_t})::Int64
end

"""
    aeron_async_add_exclusive_exclusive_publication_get_registration_id(add_exclusive_publication)

Gets the registration id for addition of the exclusive\\_publication. Note that using this after a call to poll the succeeds or errors is undefined behaviour. As the async\\_add\\_exclusive\\_publication\\_t may have been freed.

### Parameters
* `add_exclusive_publication`: used to check for completion.
### Returns
registration id for the exclusive\\_publication.
### Prototype
```c
int64_t aeron_async_add_exclusive_exclusive_publication_get_registration_id( aeron_async_add_exclusive_publication_t *add_exclusive_publication);
```
"""
function aeron_async_add_exclusive_exclusive_publication_get_registration_id(add_exclusive_publication)
    @ccall libaeron.aeron_async_add_exclusive_exclusive_publication_get_registration_id(add_exclusive_publication::Ptr{aeron_async_add_exclusive_publication_t})::Int64
end

"""
    aeron_async_add_subscription_get_registration_id(add_subscription)

Gets the registration id for addition of the subscription. Note that using this after a call to poll the succeeds or errors is undefined behaviour. As the async\\_add\\_subscription\\_t may have been freed.

### Parameters
* `add_subscription`: used to check for completion.
### Returns
registration id for the subscription.
### Prototype
```c
int64_t aeron_async_add_subscription_get_registration_id(aeron_async_add_subscription_t *add_subscription);
```
"""
function aeron_async_add_subscription_get_registration_id(add_subscription)
    @ccall libaeron.aeron_async_add_subscription_get_registration_id(add_subscription::Ptr{aeron_async_add_subscription_t})::Int64
end

"""
    aeron_async_destination_get_registration_id(async_destination)

Gets the registration\\_id for the destination command supplied. Note that this is the correlation\\_id used for the specified destination command, not the registration\\_id for the original parent resource (publication, subscription).

### Parameters
* `async_destination`: tracking the current destination command.
### Returns
correlation\\_id sent to driver.
### Prototype
```c
int64_t aeron_async_destination_get_registration_id(aeron_async_destination_t *async_destination);
```
"""
function aeron_async_destination_get_registration_id(async_destination)
    @ccall libaeron.aeron_async_destination_get_registration_id(async_destination::Ptr{aeron_async_destination_t})::Int64
end

"""
    aeron_context_request_driver_termination(directory, token_buffer, token_length)

Request the media driver terminates operation and closes all resources.

### Parameters
* `directory`: in which the media driver is running.
* `token_buffer`: containing the authentication token confirming the client is allowed to terminate the driver.
* `token_length`: of the token in the buffer.
### Returns

### Prototype
```c
int aeron_context_request_driver_termination(const char *directory, const uint8_t *token_buffer, size_t token_length);
```
"""
function aeron_context_request_driver_termination(directory, token_buffer, token_length)
    @ccall libaeron.aeron_context_request_driver_termination(directory::Cstring, token_buffer::Ptr{UInt8}, token_length::Csize_t)::Cint
end

mutable struct aeron_cnc_stct end

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

"""
    aeron_cnc_init(aeron_cnc, base_path, timeout_ms)

Initialise an aeron\\_cnc, which gives user level access to the command and control file used to communicate with the media driver. Will wait until the media driver has loaded and the cnc file is created, up to timeout\\_ms. Use a value of 0 for a non-blocking initialisation.

### Parameters
* `aeron_cnc`: to hold the loaded aeron\\_cnc
* `base_path`: media driver's base path
* `timeout_ms`: Number of milliseconds to wait before timing out.
### Returns
0 on success, -1 on failure.
### Prototype
```c
int aeron_cnc_init(aeron_cnc_t **aeron_cnc, const char *base_path, int64_t timeout_ms);
```
"""
function aeron_cnc_init(aeron_cnc, base_path, timeout_ms)
    @ccall libaeron.aeron_cnc_init(aeron_cnc::Ptr{Ptr{aeron_cnc_t}}, base_path::Cstring, timeout_ms::Int64)::Cint
end

"""
    aeron_cnc_constants(aeron_cnc, constants)

Fetch the sets of constant values associated with this command and control file.

### Parameters
* `aeron_cnc`: to query
* `constants`: user supplied structure to hold return values.
### Returns
0 on success, -1 on failure.
### Prototype
```c
int aeron_cnc_constants(aeron_cnc_t *aeron_cnc, aeron_cnc_constants_t *constants);
```
"""
function aeron_cnc_constants(aeron_cnc, constants)
    @ccall libaeron.aeron_cnc_constants(aeron_cnc::Ptr{aeron_cnc_t}, constants::Ptr{aeron_cnc_constants_t})::Cint
end

"""
    aeron_cnc_filename(aeron_cnc)

Get the current file name of the cnc file.

### Parameters
* `aeron_cnc`: to query
### Returns
name of the cnc file
### Prototype
```c
const char *aeron_cnc_filename(aeron_cnc_t *aeron_cnc);
```
"""
function aeron_cnc_filename(aeron_cnc)
    @ccall libaeron.aeron_cnc_filename(aeron_cnc::Ptr{aeron_cnc_t})::Cstring
end

"""
    aeron_cnc_to_driver_heartbeat(aeron_cnc)

Gets the timestamp of the last heartbeat sent to the media driver from any client.

### Parameters
* `aeron_cnc`: to query
### Returns
last heartbeat timestamp in ms.
### Prototype
```c
int64_t aeron_cnc_to_driver_heartbeat(aeron_cnc_t *aeron_cnc);
```
"""
function aeron_cnc_to_driver_heartbeat(aeron_cnc)
    @ccall libaeron.aeron_cnc_to_driver_heartbeat(aeron_cnc::Ptr{aeron_cnc_t})::Int64
end

# typedef void ( * aeron_error_log_reader_func_t ) ( int32_t observation_count , int64_t first_observation_timestamp , int64_t last_observation_timestamp , const char * error , size_t error_length , void * clientd )
const aeron_error_log_reader_func_t = Ptr{Cvoid}

"""
    aeron_cnc_error_log_read(aeron_cnc, callback, clientd, since_timestamp)

Reads the current error log for this driver.

### Parameters
* `aeron_cnc`: to query
* `callback`: called for every distinct error observation
* `clientd`: client data to be passed to the callback
* `since_timestamp`: only return errors after this timestamp (0 returns all)
### Returns
the number of distinct errors seen
### Prototype
```c
size_t aeron_cnc_error_log_read( aeron_cnc_t *aeron_cnc, aeron_error_log_reader_func_t callback, void *clientd, int64_t since_timestamp);
```
"""
function aeron_cnc_error_log_read(aeron_cnc, callback, clientd, since_timestamp)
    @ccall libaeron.aeron_cnc_error_log_read(aeron_cnc::Ptr{aeron_cnc_t}, callback::aeron_error_log_reader_func_t, clientd::Ptr{Cvoid}, since_timestamp::Int64)::Csize_t
end

"""
    aeron_cnc_counters_reader(aeron_cnc)

Gets a counters reader for this command and control file. This does not need to be closed manually, resources are tied to the instance of aeron\\_cnc.

### Parameters
* `aeron_cnc`: to query
### Returns
pointer to a counters reader.
### Prototype
```c
aeron_counters_reader_t *aeron_cnc_counters_reader(aeron_cnc_t *aeron_cnc);
```
"""
function aeron_cnc_counters_reader(aeron_cnc)
    @ccall libaeron.aeron_cnc_counters_reader(aeron_cnc::Ptr{aeron_cnc_t})::Ptr{aeron_counters_reader_t}
end

# typedef void ( * aeron_loss_reporter_read_entry_func_t ) ( void * clientd , int64_t observation_count , int64_t total_bytes_lost , int64_t first_observation_timestamp , int64_t last_observation_timestamp , int32_t session_id , int32_t stream_id , const char * channel , int32_t channel_length , const char * source , int32_t source_length )
const aeron_loss_reporter_read_entry_func_t = Ptr{Cvoid}

"""
    aeron_cnc_loss_reporter_read(aeron_cnc, entry_func, clientd)

Read all of the data loss observations from the report in the same media driver instances as the cnc file.

### Parameters
* `aeron_cnc`: to query
* `entry_func`: callback for each observation found
* `clientd`: client data to be passed to the callback.
### Returns
-1 on failure, number of observations on success (could be 0).
### Prototype
```c
int aeron_cnc_loss_reporter_read( aeron_cnc_t *aeron_cnc, aeron_loss_reporter_read_entry_func_t entry_func, void *clientd);
```
"""
function aeron_cnc_loss_reporter_read(aeron_cnc, entry_func, clientd)
    @ccall libaeron.aeron_cnc_loss_reporter_read(aeron_cnc::Ptr{aeron_cnc_t}, entry_func::aeron_loss_reporter_read_entry_func_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_cnc_close(aeron_cnc)

Closes the instance of the aeron cnc and frees its resources.

### Parameters
* `aeron_cnc`: to close
### Prototype
```c
void aeron_cnc_close(aeron_cnc_t *aeron_cnc);
```
"""
function aeron_cnc_close(aeron_cnc)
    @ccall libaeron.aeron_cnc_close(aeron_cnc::Ptr{aeron_cnc_t})::Cvoid
end

"""
    aeron_cache_line_align_buffer(buffer)

### Prototype
```c
inline uint8_t *aeron_cache_line_align_buffer(uint8_t *buffer);
```
"""
function aeron_cache_line_align_buffer(buffer)
    @ccall libaeron.aeron_cache_line_align_buffer(buffer::Ptr{UInt8})::Ptr{UInt8}
end

"""
    aeron_number_of_trailing_zeroes(value)

### Prototype
```c
inline int aeron_number_of_trailing_zeroes(int32_t value);
```
"""
function aeron_number_of_trailing_zeroes(value)
    @ccall libaeron.aeron_number_of_trailing_zeroes(value::Int32)::Cint
end

"""
    aeron_number_of_trailing_zeroes_u64(value)

### Prototype
```c
inline int aeron_number_of_trailing_zeroes_u64(uint64_t value);
```
"""
function aeron_number_of_trailing_zeroes_u64(value)
    @ccall libaeron.aeron_number_of_trailing_zeroes_u64(value::UInt64)::Cint
end

"""
    aeron_number_of_leading_zeroes(value)

### Prototype
```c
inline int aeron_number_of_leading_zeroes(int32_t value);
```
"""
function aeron_number_of_leading_zeroes(value)
    @ccall libaeron.aeron_number_of_leading_zeroes(value::Int32)::Cint
end

"""
    aeron_find_next_power_of_two(value)

### Prototype
```c
inline int32_t aeron_find_next_power_of_two(int32_t value);
```
"""
function aeron_find_next_power_of_two(value)
    @ccall libaeron.aeron_find_next_power_of_two(value::Int32)::Int32
end

"""
    aeron_randomised_int32()

### Prototype
```c
int32_t aeron_randomised_int32(void);
```
"""
function aeron_randomised_int32()
    @ccall libaeron.aeron_randomised_int32()::Int32
end

struct aeron_clock_cache_stct
    pre_pad::NTuple{56, UInt8}
    cached_epoch_time::Int64
    cached_nano_time::Int64
    post_pad::NTuple{56, UInt8}
end

const aeron_clock_cache_t = aeron_clock_cache_stct

"""
    aeron_clock_update_cached_time(cached_clock, epoch_time, nano_time)

Update the cached clock with the current epoch and nano time values.

### Parameters
* `cached_clock`: 'this'
* `epoch_time`: current ms since epoch.
* `nano_time`: current ns time.
### Prototype
```c
void aeron_clock_update_cached_time(aeron_clock_cache_t *cached_clock, int64_t epoch_time, int64_t nano_time);
```
"""
function aeron_clock_update_cached_time(cached_clock, epoch_time, nano_time)
    @ccall libaeron.aeron_clock_update_cached_time(cached_clock::Ptr{aeron_clock_cache_t}, epoch_time::Int64, nano_time::Int64)::Cvoid
end

"""
    aeron_clock_update_cached_epoch_time(cached_clock, epoch_time)

Update the cached clock with the current epoch time value.

### Parameters
* `cached_clock`: 'this'
* `epoch_time`: current ms since epoch.
### Prototype
```c
void aeron_clock_update_cached_epoch_time(aeron_clock_cache_t *cached_clock, int64_t epoch_time);
```
"""
function aeron_clock_update_cached_epoch_time(cached_clock, epoch_time)
    @ccall libaeron.aeron_clock_update_cached_epoch_time(cached_clock::Ptr{aeron_clock_cache_t}, epoch_time::Int64)::Cvoid
end

"""
    aeron_clock_update_cached_nano_time(cached_clock, nano_time)

Update the cached clock with the current nano time value.

### Parameters
* `cached_clock`: 'this'
* `nano_time`: current ns time.
### Prototype
```c
void aeron_clock_update_cached_nano_time(aeron_clock_cache_t *cached_clock, int64_t nano_time);
```
"""
function aeron_clock_update_cached_nano_time(cached_clock, nano_time)
    @ccall libaeron.aeron_clock_update_cached_nano_time(cached_clock::Ptr{aeron_clock_cache_t}, nano_time::Int64)::Cvoid
end

"""
    aeron_clock_cached_epoch_time(cached_clock)

Retrieves the cached epoch time from supplied cached clock.

### Parameters
* `cached_clock`: 'this'
### Returns
The current cached value for the epoch time.
### Prototype
```c
int64_t aeron_clock_cached_epoch_time(aeron_clock_cache_t *cached_clock);
```
"""
function aeron_clock_cached_epoch_time(cached_clock)
    @ccall libaeron.aeron_clock_cached_epoch_time(cached_clock::Ptr{aeron_clock_cache_t})::Int64
end

"""
    aeron_clock_cached_nano_time(cached_clock)

Retrieves the cached nano time from supplied cached clock.

### Parameters
* `cached_clock`: 'this'
### Returns
The current cached value for the nano time.
### Prototype
```c
int64_t aeron_clock_cached_nano_time(aeron_clock_cache_t *cached_clock);
```
"""
function aeron_clock_cached_nano_time(cached_clock)
    @ccall libaeron.aeron_clock_cached_nano_time(cached_clock::Ptr{aeron_clock_cache_t})::Int64
end

"""
    aeron_clock_cache_alloc(cached_clock)

Allocate a cached clock.

### Parameters
* `cached_clock`: Pointer to the pointer to be initialised with the new cached clock
### Returns
-1 if allocation fails, e.g. out of memory.
### Prototype
```c
int aeron_clock_cache_alloc(aeron_clock_cache_t **cached_clock);
```
"""
function aeron_clock_cache_alloc(cached_clock)
    @ccall libaeron.aeron_clock_cache_alloc(cached_clock::Ptr{Ptr{aeron_clock_cache_t}})::Cint
end

"""
    aeron_clock_gettime_realtime(time)

Get the realtime from the system in timespec format

### Parameters
* `time`: value to fill with the current time
### Returns
0 on success, -1 on failure.
### Prototype
```c
int aeron_clock_gettime_realtime(struct timespec *time);
```
"""
function aeron_clock_gettime_realtime(time)
    @ccall libaeron.aeron_clock_gettime_realtime(time::Ptr{Cvoid})::Cint
end

"""
    aeron_thread_set_name(role_name)

### Prototype
```c
void aeron_thread_set_name(const char *role_name);
```
"""
function aeron_thread_set_name(role_name)
    @ccall libaeron.aeron_thread_set_name(role_name::Cstring)::Cvoid
end

"""
    aeron_nano_sleep(nanoseconds)

### Prototype
```c
void aeron_nano_sleep(uint64_t nanoseconds);
```
"""
function aeron_nano_sleep(nanoseconds)
    @ccall libaeron.aeron_nano_sleep(nanoseconds::UInt64)::Cvoid
end

"""
    aeron_micro_sleep(microseconds)

### Prototype
```c
void aeron_micro_sleep(unsigned int microseconds);
```
"""
function aeron_micro_sleep(microseconds)
    @ccall libaeron.aeron_micro_sleep(microseconds::Cuint)::Cvoid
end

"""
    aeron_thread_set_affinity(role_name, cpu_affinity_no)

### Prototype
```c
int aeron_thread_set_affinity(const char *role_name, uint8_t cpu_affinity_no);
```
"""
function aeron_thread_set_affinity(role_name, cpu_affinity_no)
    @ccall libaeron.aeron_thread_set_affinity(role_name::Cstring, cpu_affinity_no::UInt8)::Cint
end

const aeron_mutex_t = pthread_mutex_t

"""
    proc_yield()

### Prototype
```c
void proc_yield(void);
```
"""
function proc_yield()
    @ccall libaeron.proc_yield()::Cvoid
end

"""
    aeron_cas_int64(dst, expected, desired)

### Prototype
```c
inline bool aeron_cas_int64(volatile int64_t *dst, int64_t expected, int64_t desired);
```
"""
function aeron_cas_int64(dst, expected, desired)
    @ccall libaeron.aeron_cas_int64(dst::Ptr{Int64}, expected::Int64, desired::Int64)::Bool
end

"""
    aeron_cas_uint64(dst, expected, desired)

### Prototype
```c
inline bool aeron_cas_uint64(volatile uint64_t *dst, uint64_t expected, uint64_t desired);
```
"""
function aeron_cas_uint64(dst, expected, desired)
    @ccall libaeron.aeron_cas_uint64(dst::Ptr{UInt64}, expected::UInt64, desired::UInt64)::Bool
end

"""
    aeron_cas_int32(dst, expected, desired)

### Prototype
```c
inline bool aeron_cas_int32(volatile int32_t *dst, int32_t expected, int32_t desired);
```
"""
function aeron_cas_int32(dst, expected, desired)
    @ccall libaeron.aeron_cas_int32(dst::Ptr{Int32}, expected::Int32, desired::Int32)::Bool
end

"""
    aeron_acquire()

### Prototype
```c
inline void aeron_acquire(void);
```
"""
function aeron_acquire()
    @ccall libaeron.aeron_acquire()::Cvoid
end

"""
    aeron_release()

### Prototype
```c
inline void aeron_release(void);
```
"""
function aeron_release()
    @ccall libaeron.aeron_release()::Cvoid
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

mutable struct aeron_distinct_error_log_stct
    buffer::Ptr{UInt8}
    observation_list::Ptr{aeron_distinct_error_log_observation_list_t}
    buffer_capacity::Csize_t
    next_offset::Csize_t
    clock::aeron_clock_func_t
    mutex::aeron_mutex_t
    aeron_distinct_error_log_stct() = new()
end

const aeron_distinct_error_log_t = aeron_distinct_error_log_stct

"""
    aeron_distinct_error_log_init(log, buffer, buffer_size, clock)

### Prototype
```c
int aeron_distinct_error_log_init( aeron_distinct_error_log_t *log, uint8_t *buffer, size_t buffer_size, aeron_clock_func_t clock);
```
"""
function aeron_distinct_error_log_init(log, buffer, buffer_size, clock)
    @ccall libaeron.aeron_distinct_error_log_init(log::Ptr{aeron_distinct_error_log_t}, buffer::Ptr{UInt8}, buffer_size::Csize_t, clock::aeron_clock_func_t)::Cint
end

"""
    aeron_distinct_error_log_close(log)

### Prototype
```c
void aeron_distinct_error_log_close(aeron_distinct_error_log_t *log);
```
"""
function aeron_distinct_error_log_close(log)
    @ccall libaeron.aeron_distinct_error_log_close(log::Ptr{aeron_distinct_error_log_t})::Cvoid
end

"""
    aeron_distinct_error_log_record(log, error_code, description)

### Prototype
```c
int aeron_distinct_error_log_record(aeron_distinct_error_log_t *log, int error_code, const char *description);
```
"""
function aeron_distinct_error_log_record(log, error_code, description)
    @ccall libaeron.aeron_distinct_error_log_record(log::Ptr{aeron_distinct_error_log_t}, error_code::Cint, description::Cstring)::Cint
end

"""
    aeron_error_log_exists(buffer, buffer_size)

### Prototype
```c
bool aeron_error_log_exists(const uint8_t *buffer, size_t buffer_size);
```
"""
function aeron_error_log_exists(buffer, buffer_size)
    @ccall libaeron.aeron_error_log_exists(buffer::Ptr{UInt8}, buffer_size::Csize_t)::Bool
end

"""
    aeron_error_log_read(buffer, buffer_size, reader, clientd, since_timestamp)

### Prototype
```c
size_t aeron_error_log_read( const uint8_t *buffer, size_t buffer_size, aeron_error_log_reader_func_t reader, void *clientd, int64_t since_timestamp);
```
"""
function aeron_error_log_read(buffer, buffer_size, reader, clientd, since_timestamp)
    @ccall libaeron.aeron_error_log_read(buffer::Ptr{UInt8}, buffer_size::Csize_t, reader::aeron_error_log_reader_func_t, clientd::Ptr{Cvoid}, since_timestamp::Int64)::Csize_t
end

"""
    aeron_distinct_error_log_num_observations(log)

### Prototype
```c
size_t aeron_distinct_error_log_num_observations(aeron_distinct_error_log_t *log);
```
"""
function aeron_distinct_error_log_num_observations(log)
    @ccall libaeron.aeron_distinct_error_log_num_observations(log::Ptr{aeron_distinct_error_log_t})::Csize_t
end

# typedef int ( * aeron_idle_strategy_init_func_t ) ( void * * state , const char * env_var , const char * init_args )
const aeron_idle_strategy_init_func_t = Ptr{Cvoid}

"""
    aeron_semantic_version_compose(major, minor, patch)

### Prototype
```c
int32_t aeron_semantic_version_compose(uint8_t major, uint8_t minor, uint8_t patch);
```
"""
function aeron_semantic_version_compose(major, minor, patch)
    @ccall libaeron.aeron_semantic_version_compose(major::UInt8, minor::UInt8, patch::UInt8)::Int32
end

"""
    aeron_semantic_version_major(version)

### Prototype
```c
uint8_t aeron_semantic_version_major(int32_t version);
```
"""
function aeron_semantic_version_major(version)
    @ccall libaeron.aeron_semantic_version_major(version::Int32)::UInt8
end

"""
    aeron_semantic_version_minor(version)

### Prototype
```c
uint8_t aeron_semantic_version_minor(int32_t version);
```
"""
function aeron_semantic_version_minor(version)
    @ccall libaeron.aeron_semantic_version_minor(version::Int32)::UInt8
end

"""
    aeron_semantic_version_patch(version)

### Prototype
```c
uint8_t aeron_semantic_version_patch(int32_t version);
```
"""
function aeron_semantic_version_patch(version)
    @ccall libaeron.aeron_semantic_version_patch(version::Int32)::UInt8
end

# typedef void ( * aeron_fptr_t ) ( void )
const aeron_fptr_t = Ptr{Cvoid}

mutable struct aeron_per_thread_error_stct
    errcode::Cint
    offset::Csize_t
    errmsg::NTuple{8192, Cchar}
    aeron_per_thread_error_stct() = new()
end

const aeron_per_thread_error_t = aeron_per_thread_error_stct

"""
    aeron_set_errno(errcode)

### Prototype
```c
void aeron_set_errno(int errcode);
```
"""
function aeron_set_errno(errcode)
    @ccall libaeron.aeron_set_errno(errcode::Cint)::Cvoid
end

"""
    aeron_error_code_str(errcode)

### Prototype
```c
const char *aeron_error_code_str(int errcode);
```
"""
function aeron_error_code_str(errcode)
    @ccall libaeron.aeron_error_code_str(errcode::Cint)::Cstring
end

"""
    aeron_err_clear()

### Prototype
```c
void aeron_err_clear(void);
```
"""
function aeron_err_clear()
    @ccall libaeron.aeron_err_clear()::Cvoid
end

mutable struct aeron_bit_set_stct
    bit_set_length::Csize_t
    bits::Ptr{UInt64}
    static_array::Ptr{UInt64}
    aeron_bit_set_stct() = new()
end

const aeron_bit_set_t = aeron_bit_set_stct

"""
    aeron_bit_set_init(bit_set, initial_value)

### Prototype
```c
inline int aeron_bit_set_init(aeron_bit_set_t *bit_set, bool initial_value);
```
"""
function aeron_bit_set_init(bit_set, initial_value)
    @ccall libaeron.aeron_bit_set_init(bit_set::Ptr{aeron_bit_set_t}, initial_value::Bool)::Cint
end

"""
    aeron_bit_set_stack_alloc(bit_set_length, static_array, static_array_len, bit_set)

### Prototype
```c
inline int aeron_bit_set_stack_alloc( size_t bit_set_length, uint64_t *static_array, size_t static_array_len, aeron_bit_set_t *bit_set);
```
"""
function aeron_bit_set_stack_alloc(bit_set_length, static_array, static_array_len, bit_set)
    @ccall libaeron.aeron_bit_set_stack_alloc(bit_set_length::Csize_t, static_array::Ptr{UInt64}, static_array_len::Csize_t, bit_set::Ptr{aeron_bit_set_t})::Cint
end

"""
    aeron_bit_set_heap_alloc(bit_set_length, bit_set)

### Prototype
```c
inline int aeron_bit_set_heap_alloc(size_t bit_set_length, aeron_bit_set_t **bit_set);
```
"""
function aeron_bit_set_heap_alloc(bit_set_length, bit_set)
    @ccall libaeron.aeron_bit_set_heap_alloc(bit_set_length::Csize_t, bit_set::Ptr{Ptr{aeron_bit_set_t}})::Cint
end

"""
    aeron_bit_set_stack_init(bit_set_length, static_array, static_array_len, initial_value, bit_set)

### Prototype
```c
inline int aeron_bit_set_stack_init( size_t bit_set_length, uint64_t *static_array, size_t static_array_len, bool initial_value, aeron_bit_set_t *bit_set);
```
"""
function aeron_bit_set_stack_init(bit_set_length, static_array, static_array_len, initial_value, bit_set)
    @ccall libaeron.aeron_bit_set_stack_init(bit_set_length::Csize_t, static_array::Ptr{UInt64}, static_array_len::Csize_t, initial_value::Bool, bit_set::Ptr{aeron_bit_set_t})::Cint
end

"""
    aeron_bit_set_heap_init(bit_set_length, initial_value, bit_set)

### Prototype
```c
inline int aeron_bit_set_heap_init(size_t bit_set_length, bool initial_value, aeron_bit_set_t **bit_set);
```
"""
function aeron_bit_set_heap_init(bit_set_length, initial_value, bit_set)
    @ccall libaeron.aeron_bit_set_heap_init(bit_set_length::Csize_t, initial_value::Bool, bit_set::Ptr{Ptr{aeron_bit_set_t}})::Cint
end

"""
    aeron_bit_set_stack_free(bit_set)

### Prototype
```c
inline void aeron_bit_set_stack_free(aeron_bit_set_t *bit_set);
```
"""
function aeron_bit_set_stack_free(bit_set)
    @ccall libaeron.aeron_bit_set_stack_free(bit_set::Ptr{aeron_bit_set_t})::Cvoid
end

"""
    aeron_bit_set_heap_free(bit_set)

### Prototype
```c
inline void aeron_bit_set_heap_free(aeron_bit_set_t *bit_set);
```
"""
function aeron_bit_set_heap_free(bit_set)
    @ccall libaeron.aeron_bit_set_heap_free(bit_set::Ptr{aeron_bit_set_t})::Cvoid
end

"""
    aeron_bit_set_get(bit_set, bit_index, value)

### Prototype
```c
inline int aeron_bit_set_get(aeron_bit_set_t *bit_set, size_t bit_index, bool *value);
```
"""
function aeron_bit_set_get(bit_set, bit_index, value)
    @ccall libaeron.aeron_bit_set_get(bit_set::Ptr{aeron_bit_set_t}, bit_index::Csize_t, value::Ptr{Bool})::Cint
end

"""
    aeron_bit_set_set(bit_set, bit_index, value)

### Prototype
```c
inline int aeron_bit_set_set(aeron_bit_set_t *bit_set, size_t bit_index, bool value);
```
"""
function aeron_bit_set_set(bit_set, bit_index, value)
    @ccall libaeron.aeron_bit_set_set(bit_set::Ptr{aeron_bit_set_t}, bit_index::Csize_t, value::Bool)::Cint
end

"""
    aeron_bit_set_find_first(bit_set, value, bit_index)

### Prototype
```c
inline int aeron_bit_set_find_first(aeron_bit_set_t *bit_set, bool value, size_t *bit_index);
```
"""
function aeron_bit_set_find_first(bit_set, value, bit_index)
    @ccall libaeron.aeron_bit_set_find_first(bit_set::Ptr{aeron_bit_set_t}, value::Bool, bit_index::Ptr{Csize_t})::Cint
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

"""
    aeron_udp_protocol_group_tag(sm, group_tag)

### Prototype
```c
int aeron_udp_protocol_group_tag(aeron_status_message_header_t *sm, int64_t *group_tag);
```
"""
function aeron_udp_protocol_group_tag(sm, group_tag)
    @ccall libaeron.aeron_udp_protocol_group_tag(sm::Ptr{aeron_status_message_header_t}, group_tag::Ptr{Int64})::Cint
end

"""
    aeron_res_header_address_length(res_type)

### Prototype
```c
inline size_t aeron_res_header_address_length(int8_t res_type);
```
"""
function aeron_res_header_address_length(res_type)
    @ccall libaeron.aeron_res_header_address_length(res_type::Int8)::Csize_t
end

"""
    aeron_compute_max_message_length(term_length)

### Prototype
```c
inline size_t aeron_compute_max_message_length(size_t term_length);
```
"""
function aeron_compute_max_message_length(term_length)
    @ccall libaeron.aeron_compute_max_message_length(term_length::Csize_t)::Csize_t
end

"""
    aeron_res_header_entry_length_ipv4(header)

### Prototype
```c
size_t aeron_res_header_entry_length_ipv4(aeron_resolution_header_ipv4_t *header);
```
"""
function aeron_res_header_entry_length_ipv4(header)
    @ccall libaeron.aeron_res_header_entry_length_ipv4(header::Ptr{aeron_resolution_header_ipv4_t})::Csize_t
end

"""
    aeron_res_header_entry_length_ipv6(header)

### Prototype
```c
size_t aeron_res_header_entry_length_ipv6(aeron_resolution_header_ipv6_t *header);
```
"""
function aeron_res_header_entry_length_ipv6(header)
    @ccall libaeron.aeron_res_header_entry_length_ipv6(header::Ptr{aeron_resolution_header_ipv6_t})::Csize_t
end

"""
    aeron_res_header_entry_length(res, remaining)

### Prototype
```c
int aeron_res_header_entry_length(void *res, size_t remaining);
```
"""
function aeron_res_header_entry_length(res, remaining)
    @ccall libaeron.aeron_res_header_entry_length(res::Ptr{Cvoid}, remaining::Csize_t)::Cint
end

"""
    aeron_add_wrap_i32(a, b)

### Prototype
```c
inline int32_t aeron_add_wrap_i32(int32_t a, int32_t b);
```
"""
function aeron_add_wrap_i32(a, b)
    @ccall libaeron.aeron_add_wrap_i32(a::Int32, b::Int32)::Int32
end

"""
    aeron_sub_wrap_i32(a, b)

### Prototype
```c
inline int32_t aeron_sub_wrap_i32(int32_t a, int32_t b);
```
"""
function aeron_sub_wrap_i32(a, b)
    @ccall libaeron.aeron_sub_wrap_i32(a::Int32, b::Int32)::Int32
end

"""
    aeron_mul_wrap_i32(a, b)

### Prototype
```c
inline int32_t aeron_mul_wrap_i32(int32_t a, int32_t b);
```
"""
function aeron_mul_wrap_i32(a, b)
    @ccall libaeron.aeron_mul_wrap_i32(a::Int32, b::Int32)::Int32
end

"""
    aeron_logbuffer_check_term_length(term_length)

### Prototype
```c
int aeron_logbuffer_check_term_length(uint64_t term_length);
```
"""
function aeron_logbuffer_check_term_length(term_length)
    @ccall libaeron.aeron_logbuffer_check_term_length(term_length::UInt64)::Cint
end

"""
    aeron_logbuffer_check_page_size(page_size)

### Prototype
```c
int aeron_logbuffer_check_page_size(uint64_t page_size);
```
"""
function aeron_logbuffer_check_page_size(page_size)
    @ccall libaeron.aeron_logbuffer_check_page_size(page_size::UInt64)::Cint
end

"""
    aeron_logbuffer_compute_log_length(term_length, page_size)

### Prototype
```c
inline uint64_t aeron_logbuffer_compute_log_length(uint64_t term_length, uint64_t page_size);
```
"""
function aeron_logbuffer_compute_log_length(term_length, page_size)
    @ccall libaeron.aeron_logbuffer_compute_log_length(term_length::UInt64, page_size::UInt64)::UInt64
end

"""
    aeron_logbuffer_term_offset(raw_tail, term_length)

### Prototype
```c
inline int32_t aeron_logbuffer_term_offset(int64_t raw_tail, int32_t term_length);
```
"""
function aeron_logbuffer_term_offset(raw_tail, term_length)
    @ccall libaeron.aeron_logbuffer_term_offset(raw_tail::Int64, term_length::Int32)::Int32
end

"""
    aeron_logbuffer_term_id(raw_tail)

### Prototype
```c
inline int32_t aeron_logbuffer_term_id(int64_t raw_tail);
```
"""
function aeron_logbuffer_term_id(raw_tail)
    @ccall libaeron.aeron_logbuffer_term_id(raw_tail::Int64)::Int32
end

"""
    aeron_logbuffer_compute_term_count(term_id, initial_term_id)

### Prototype
```c
inline int32_t aeron_logbuffer_compute_term_count(int32_t term_id, int32_t initial_term_id);
```
"""
function aeron_logbuffer_compute_term_count(term_id, initial_term_id)
    @ccall libaeron.aeron_logbuffer_compute_term_count(term_id::Int32, initial_term_id::Int32)::Int32
end

"""
    aeron_logbuffer_index_by_position(position, position_bits_to_shift)

### Prototype
```c
inline size_t aeron_logbuffer_index_by_position(int64_t position, size_t position_bits_to_shift);
```
"""
function aeron_logbuffer_index_by_position(position, position_bits_to_shift)
    @ccall libaeron.aeron_logbuffer_index_by_position(position::Int64, position_bits_to_shift::Csize_t)::Csize_t
end

"""
    aeron_logbuffer_index_by_term(initial_term_id, active_term_id)

### Prototype
```c
inline size_t aeron_logbuffer_index_by_term(int32_t initial_term_id, int32_t active_term_id);
```
"""
function aeron_logbuffer_index_by_term(initial_term_id, active_term_id)
    @ccall libaeron.aeron_logbuffer_index_by_term(initial_term_id::Int32, active_term_id::Int32)::Csize_t
end

"""
    aeron_logbuffer_index_by_term_count(term_count)

### Prototype
```c
inline size_t aeron_logbuffer_index_by_term_count(int32_t term_count);
```
"""
function aeron_logbuffer_index_by_term_count(term_count)
    @ccall libaeron.aeron_logbuffer_index_by_term_count(term_count::Int32)::Csize_t
end

"""
    aeron_logbuffer_compute_position(active_term_id, term_offset, position_bits_to_shift, initial_term_id)

### Prototype
```c
inline int64_t aeron_logbuffer_compute_position( int32_t active_term_id, int32_t term_offset, size_t position_bits_to_shift, int32_t initial_term_id);
```
"""
function aeron_logbuffer_compute_position(active_term_id, term_offset, position_bits_to_shift, initial_term_id)
    @ccall libaeron.aeron_logbuffer_compute_position(active_term_id::Int32, term_offset::Int32, position_bits_to_shift::Csize_t, initial_term_id::Int32)::Int64
end

"""
    aeron_logbuffer_compute_term_begin_position(active_term_id, position_bits_to_shift, initial_term_id)

### Prototype
```c
inline int64_t aeron_logbuffer_compute_term_begin_position( int32_t active_term_id, size_t position_bits_to_shift, int32_t initial_term_id);
```
"""
function aeron_logbuffer_compute_term_begin_position(active_term_id, position_bits_to_shift, initial_term_id)
    @ccall libaeron.aeron_logbuffer_compute_term_begin_position(active_term_id::Int32, position_bits_to_shift::Csize_t, initial_term_id::Int32)::Int64
end

"""
    aeron_logbuffer_compute_term_id_from_position(position, position_bits_to_shift, initial_term_id)

### Prototype
```c
inline int32_t aeron_logbuffer_compute_term_id_from_position( int64_t position, size_t position_bits_to_shift, int32_t initial_term_id);
```
"""
function aeron_logbuffer_compute_term_id_from_position(position, position_bits_to_shift, initial_term_id)
    @ccall libaeron.aeron_logbuffer_compute_term_id_from_position(position::Int64, position_bits_to_shift::Csize_t, initial_term_id::Int32)::Int32
end

"""
    aeron_logbuffer_compute_term_offset_from_position(position, position_bits_to_shift)

### Prototype
```c
inline int32_t aeron_logbuffer_compute_term_offset_from_position(int64_t position, size_t position_bits_to_shift);
```
"""
function aeron_logbuffer_compute_term_offset_from_position(position, position_bits_to_shift)
    @ccall libaeron.aeron_logbuffer_compute_term_offset_from_position(position::Int64, position_bits_to_shift::Csize_t)::Int32
end

"""
    aeron_logbuffer_cas_raw_tail(log_meta_data, partition_index, expected_raw_tail, update_raw_tail)

### Prototype
```c
inline bool aeron_logbuffer_cas_raw_tail( aeron_logbuffer_metadata_t *log_meta_data, size_t partition_index, int64_t expected_raw_tail, int64_t update_raw_tail);
```
"""
function aeron_logbuffer_cas_raw_tail(log_meta_data, partition_index, expected_raw_tail, update_raw_tail)
    @ccall libaeron.aeron_logbuffer_cas_raw_tail(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, partition_index::Csize_t, expected_raw_tail::Int64, update_raw_tail::Int64)::Bool
end

"""
    aeron_logbuffer_active_term_count(log_meta_data)

### Prototype
```c
inline int32_t aeron_logbuffer_active_term_count(aeron_logbuffer_metadata_t *log_meta_data);
```
"""
function aeron_logbuffer_active_term_count(log_meta_data)
    @ccall libaeron.aeron_logbuffer_active_term_count(log_meta_data::Ptr{aeron_logbuffer_metadata_t})::Int32
end

"""
    aeron_logbuffer_cas_active_term_count(log_meta_data, expected_term_count, update_term_count)

### Prototype
```c
inline bool aeron_logbuffer_cas_active_term_count( aeron_logbuffer_metadata_t *log_meta_data, int32_t expected_term_count, int32_t update_term_count);
```
"""
function aeron_logbuffer_cas_active_term_count(log_meta_data, expected_term_count, update_term_count)
    @ccall libaeron.aeron_logbuffer_cas_active_term_count(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, expected_term_count::Int32, update_term_count::Int32)::Bool
end

"""
    aeron_logbuffer_rotate_log(log_meta_data, current_term_count, current_term_id)

### Prototype
```c
inline bool aeron_logbuffer_rotate_log( aeron_logbuffer_metadata_t *log_meta_data, int32_t current_term_count, int32_t current_term_id);
```
"""
function aeron_logbuffer_rotate_log(log_meta_data, current_term_count, current_term_id)
    @ccall libaeron.aeron_logbuffer_rotate_log(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, current_term_count::Int32, current_term_id::Int32)::Bool
end

"""
    aeron_logbuffer_fill_default_header(log_meta_data_buffer, session_id, stream_id, initial_term_id)

### Prototype
```c
inline void aeron_logbuffer_fill_default_header( uint8_t *log_meta_data_buffer, int32_t session_id, int32_t stream_id, int32_t initial_term_id);
```
"""
function aeron_logbuffer_fill_default_header(log_meta_data_buffer, session_id, stream_id, initial_term_id)
    @ccall libaeron.aeron_logbuffer_fill_default_header(log_meta_data_buffer::Ptr{UInt8}, session_id::Int32, stream_id::Int32, initial_term_id::Int32)::Cvoid
end

"""
    aeron_logbuffer_apply_default_header(log_meta_data_buffer, buffer)

### Prototype
```c
inline void aeron_logbuffer_apply_default_header(uint8_t *log_meta_data_buffer, uint8_t *buffer);
```
"""
function aeron_logbuffer_apply_default_header(log_meta_data_buffer, buffer)
    @ccall libaeron.aeron_logbuffer_apply_default_header(log_meta_data_buffer::Ptr{UInt8}, buffer::Ptr{UInt8})::Cvoid
end

"""
    aeron_term_gap_filler_try_fill_gap(log_meta_data, buffer, term_id, gap_offset, gap_length)

### Prototype
```c
bool aeron_term_gap_filler_try_fill_gap( aeron_logbuffer_metadata_t *log_meta_data, uint8_t *buffer, int32_t term_id, int32_t gap_offset, int32_t gap_length);
```
"""
function aeron_term_gap_filler_try_fill_gap(log_meta_data, buffer, term_id, gap_offset, gap_length)
    @ccall libaeron.aeron_term_gap_filler_try_fill_gap(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, buffer::Ptr{UInt8}, term_id::Int32, gap_offset::Int32, gap_length::Int32)::Bool
end

"""
    aeron_hash_code(value)

### Prototype
```c
inline uint64_t aeron_hash_code(uint64_t value);
```
"""
function aeron_hash_code(value)
    @ccall libaeron.aeron_hash_code(value::UInt64)::UInt64
end

"""
    aeron_hash(value, mask)

### Prototype
```c
inline size_t aeron_hash(uint64_t value, size_t mask);
```
"""
function aeron_hash(value, mask)
    @ccall libaeron.aeron_hash(value::UInt64, mask::Csize_t)::Csize_t
end

"""
    aeron_even_hash(value, mask)

### Prototype
```c
inline size_t aeron_even_hash(uint64_t value, size_t mask);
```
"""
function aeron_even_hash(value, mask)
    @ccall libaeron.aeron_even_hash(value::UInt64, mask::Csize_t)::Csize_t
end

"""
    aeron_map_compound_key(high, low)

### Prototype
```c
inline int64_t aeron_map_compound_key(int32_t high, int32_t low);
```
"""
function aeron_map_compound_key(high, low)
    @ccall libaeron.aeron_map_compound_key(high::Int32, low::Int32)::Int64
end

mutable struct aeron_int64_counter_map_stct
    entries::Ptr{Int64}
    load_factor::Cfloat
    entries_length::Csize_t
    size::Csize_t
    resize_threshold::Csize_t
    initial_value::Int64
    aeron_int64_counter_map_stct() = new()
end

const aeron_int64_counter_map_t = aeron_int64_counter_map_stct

"""
    aeron_int64_counter_map_hash_key(key, mask)

### Prototype
```c
inline size_t aeron_int64_counter_map_hash_key(int64_t key, size_t mask);
```
"""
function aeron_int64_counter_map_hash_key(key, mask)
    @ccall libaeron.aeron_int64_counter_map_hash_key(key::Int64, mask::Csize_t)::Csize_t
end

"""
    aeron_int64_counter_map_init(map, initial_value, initial_capacity, load_factor)

### Prototype
```c
inline int aeron_int64_counter_map_init( aeron_int64_counter_map_t *map, int64_t initial_value, size_t initial_capacity, float load_factor);
```
"""
function aeron_int64_counter_map_init(map, initial_value, initial_capacity, load_factor)
    @ccall libaeron.aeron_int64_counter_map_init(map::Ptr{aeron_int64_counter_map_t}, initial_value::Int64, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

"""
    aeron_int64_counter_map_delete(map)

### Prototype
```c
inline void aeron_int64_counter_map_delete(aeron_int64_counter_map_t *map);
```
"""
function aeron_int64_counter_map_delete(map)
    @ccall libaeron.aeron_int64_counter_map_delete(map::Ptr{aeron_int64_counter_map_t})::Cvoid
end

"""
    aeron_int64_counter_map_rehash(map, new_entries_length)

### Prototype
```c
inline int aeron_int64_counter_map_rehash(aeron_int64_counter_map_t *map, size_t new_entries_length);
```
"""
function aeron_int64_counter_map_rehash(map, new_entries_length)
    @ccall libaeron.aeron_int64_counter_map_rehash(map::Ptr{aeron_int64_counter_map_t}, new_entries_length::Csize_t)::Cint
end

"""
    aeron_int64_counter_map_compact_chain(map, delete_index)

### Prototype
```c
inline void aeron_int64_counter_map_compact_chain(aeron_int64_counter_map_t *map, size_t delete_index);
```
"""
function aeron_int64_counter_map_compact_chain(map, delete_index)
    @ccall libaeron.aeron_int64_counter_map_compact_chain(map::Ptr{aeron_int64_counter_map_t}, delete_index::Csize_t)::Cvoid
end

"""
    aeron_int64_counter_map_remove(map, key)

### Prototype
```c
inline int64_t aeron_int64_counter_map_remove(aeron_int64_counter_map_t *map, int64_t key);
```
"""
function aeron_int64_counter_map_remove(map, key)
    @ccall libaeron.aeron_int64_counter_map_remove(map::Ptr{aeron_int64_counter_map_t}, key::Int64)::Int64
end

"""
    aeron_int64_counter_map_put(map, key, value, existing_value)

### Prototype
```c
inline int aeron_int64_counter_map_put( aeron_int64_counter_map_t *map, const int64_t key, const int64_t value, int64_t *existing_value);
```
"""
function aeron_int64_counter_map_put(map, key, value, existing_value)
    @ccall libaeron.aeron_int64_counter_map_put(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Int64, existing_value::Ptr{Int64})::Cint
end

"""
    aeron_int64_counter_map_get(map, key)

### Prototype
```c
inline int64_t aeron_int64_counter_map_get(aeron_int64_counter_map_t *map, const int64_t key);
```
"""
function aeron_int64_counter_map_get(map, key)
    @ccall libaeron.aeron_int64_counter_map_get(map::Ptr{aeron_int64_counter_map_t}, key::Int64)::Int64
end

"""
    aeron_int64_counter_map_get_and_add(map, key, delta, value)

### Prototype
```c
inline int aeron_int64_counter_map_get_and_add( aeron_int64_counter_map_t *map, const int64_t key, const int64_t delta, int64_t *value);
```
"""
function aeron_int64_counter_map_get_and_add(map, key, delta, value)
    @ccall libaeron.aeron_int64_counter_map_get_and_add(map::Ptr{aeron_int64_counter_map_t}, key::Int64, delta::Int64, value::Ptr{Int64})::Cint
end

"""
    aeron_int64_counter_map_add_and_get(map, key, delta, value)

### Prototype
```c
inline int aeron_int64_counter_map_add_and_get( aeron_int64_counter_map_t *map, const int64_t key, int64_t delta, int64_t *value);
```
"""
function aeron_int64_counter_map_add_and_get(map, key, delta, value)
    @ccall libaeron.aeron_int64_counter_map_add_and_get(map::Ptr{aeron_int64_counter_map_t}, key::Int64, delta::Int64, value::Ptr{Int64})::Cint
end

"""
    aeron_int64_counter_map_inc_and_get(map, key, value)

### Prototype
```c
inline int aeron_int64_counter_map_inc_and_get(aeron_int64_counter_map_t *map, const int64_t key, int64_t *value);
```
"""
function aeron_int64_counter_map_inc_and_get(map, key, value)
    @ccall libaeron.aeron_int64_counter_map_inc_and_get(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Ptr{Int64})::Cint
end

"""
    aeron_int64_counter_map_dec_and_get(map, key, value)

### Prototype
```c
inline int aeron_int64_counter_map_dec_and_get(aeron_int64_counter_map_t *map, const int64_t key, int64_t *value);
```
"""
function aeron_int64_counter_map_dec_and_get(map, key, value)
    @ccall libaeron.aeron_int64_counter_map_dec_and_get(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Ptr{Int64})::Cint
end

"""
    aeron_int64_counter_map_get_and_inc(map, key, value)

### Prototype
```c
inline int aeron_int64_counter_map_get_and_inc(aeron_int64_counter_map_t *map, const int64_t key, int64_t *value);
```
"""
function aeron_int64_counter_map_get_and_inc(map, key, value)
    @ccall libaeron.aeron_int64_counter_map_get_and_inc(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Ptr{Int64})::Cint
end

"""
    aeron_int64_counter_map_get_and_dec(map, key, value)

### Prototype
```c
inline int aeron_int64_counter_map_get_and_dec(aeron_int64_counter_map_t *map, const int64_t key, int64_t *value);
```
"""
function aeron_int64_counter_map_get_and_dec(map, key, value)
    @ccall libaeron.aeron_int64_counter_map_get_and_dec(map::Ptr{aeron_int64_counter_map_t}, key::Int64, value::Ptr{Int64})::Cint
end

# typedef void ( * aeron_int64_counter_map_for_each_func_t ) ( void * clientd , int64_t key , int64_t value )
const aeron_int64_counter_map_for_each_func_t = Ptr{Cvoid}

"""
    aeron_int64_counter_map_for_each(map, func, clientd)

### Prototype
```c
inline void aeron_int64_counter_map_for_each( aeron_int64_counter_map_t *map, aeron_int64_counter_map_for_each_func_t func, void *clientd);
```
"""
function aeron_int64_counter_map_for_each(map, func, clientd)
    @ccall libaeron.aeron_int64_counter_map_for_each(map::Ptr{aeron_int64_counter_map_t}, func::aeron_int64_counter_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

mutable struct aeron_properties_parser_state_stct
    property_str::NTuple{2048, Cchar}
    name_end::Csize_t
    value_end::Csize_t
    aeron_properties_parser_state_stct() = new()
end

const aeron_properties_parser_state_t = aeron_properties_parser_state_stct

# typedef int ( * aeron_properties_file_handler_func_t ) ( void * clientd , const char * property_name , const char * property_value )
const aeron_properties_file_handler_func_t = Ptr{Cvoid}

"""
    aeron_properties_parse_init(state)

### Prototype
```c
inline void aeron_properties_parse_init(aeron_properties_parser_state_t *state);
```
"""
function aeron_properties_parse_init(state)
    @ccall libaeron.aeron_properties_parse_init(state::Ptr{aeron_properties_parser_state_t})::Cvoid
end

"""
    aeron_properties_parse_line(state, line, length, handler, clientd)

### Prototype
```c
int aeron_properties_parse_line( aeron_properties_parser_state_t *state, const char *line, size_t length, aeron_properties_file_handler_func_t handler, void *clientd);
```
"""
function aeron_properties_parse_line(state, line, length, handler, clientd)
    @ccall libaeron.aeron_properties_parse_line(state::Ptr{aeron_properties_parser_state_t}, line::Cstring, length::Csize_t, handler::aeron_properties_file_handler_func_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_properties_parse_file(filename, handler, clientd)

### Prototype
```c
int aeron_properties_parse_file(const char *filename, aeron_properties_file_handler_func_t handler, void *clientd);
```
"""
function aeron_properties_parse_file(filename, handler, clientd)
    @ccall libaeron.aeron_properties_parse_file(filename::Cstring, handler::aeron_properties_file_handler_func_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_properties_setenv(name, value)

### Prototype
```c
int aeron_properties_setenv(const char *name, const char *value);
```
"""
function aeron_properties_setenv(name, value)
    @ccall libaeron.aeron_properties_setenv(name::Cstring, value::Cstring)::Cint
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

mutable struct aeron_loss_reporter_stct
    buffer::Ptr{UInt8}
    next_record_offset::Csize_t
    capacity::Csize_t
    aeron_loss_reporter_stct() = new()
end

const aeron_loss_reporter_t = aeron_loss_reporter_stct

const aeron_loss_reporter_entry_offset_t = Int64

"""
    aeron_loss_reporter_init(reporter, buffer, length)

### Prototype
```c
int aeron_loss_reporter_init(aeron_loss_reporter_t *reporter, uint8_t *buffer, size_t length);
```
"""
function aeron_loss_reporter_init(reporter, buffer, length)
    @ccall libaeron.aeron_loss_reporter_init(reporter::Ptr{aeron_loss_reporter_t}, buffer::Ptr{UInt8}, length::Csize_t)::Cint
end

"""
    aeron_loss_reporter_create_entry(reporter, initial_bytes_lost, timestamp_ms, session_id, stream_id, channel, channel_length, source, source_length)

### Prototype
```c
aeron_loss_reporter_entry_offset_t aeron_loss_reporter_create_entry( aeron_loss_reporter_t *reporter, int64_t initial_bytes_lost, int64_t timestamp_ms, int32_t session_id, int32_t stream_id, const char *channel, size_t channel_length, const char *source, size_t source_length);
```
"""
function aeron_loss_reporter_create_entry(reporter, initial_bytes_lost, timestamp_ms, session_id, stream_id, channel, channel_length, source, source_length)
    @ccall libaeron.aeron_loss_reporter_create_entry(reporter::Ptr{aeron_loss_reporter_t}, initial_bytes_lost::Int64, timestamp_ms::Int64, session_id::Int32, stream_id::Int32, channel::Cstring, channel_length::Csize_t, source::Cstring, source_length::Csize_t)::aeron_loss_reporter_entry_offset_t
end

"""
    aeron_loss_reporter_record_observation(reporter, offset, bytes_lost, timestamp_ms)

### Prototype
```c
inline void aeron_loss_reporter_record_observation( aeron_loss_reporter_t *reporter, aeron_loss_reporter_entry_offset_t offset, int64_t bytes_lost, int64_t timestamp_ms);
```
"""
function aeron_loss_reporter_record_observation(reporter, offset, bytes_lost, timestamp_ms)
    @ccall libaeron.aeron_loss_reporter_record_observation(reporter::Ptr{aeron_loss_reporter_t}, offset::aeron_loss_reporter_entry_offset_t, bytes_lost::Int64, timestamp_ms::Int64)::Cvoid
end

"""
    aeron_loss_reporter_resolve_filename(directory, filename_buffer, filename_buffer_length)

### Prototype
```c
int aeron_loss_reporter_resolve_filename(const char *directory, char *filename_buffer, size_t filename_buffer_length);
```
"""
function aeron_loss_reporter_resolve_filename(directory, filename_buffer, filename_buffer_length)
    @ccall libaeron.aeron_loss_reporter_resolve_filename(directory::Cstring, filename_buffer::Cstring, filename_buffer_length::Csize_t)::Cint
end

"""
    aeron_loss_reporter_read(buffer, capacity, entry_func, clientd)

### Prototype
```c
size_t aeron_loss_reporter_read( const uint8_t *buffer, size_t capacity, aeron_loss_reporter_read_entry_func_t entry_func, void *clientd);
```
"""
function aeron_loss_reporter_read(buffer, capacity, entry_func, clientd)
    @ccall libaeron.aeron_loss_reporter_read(buffer::Ptr{UInt8}, capacity::Csize_t, entry_func::aeron_loss_reporter_read_entry_func_t, clientd::Ptr{Cvoid})::Csize_t
end

"""
    aeron_dlinfo(arg1, buffer, max_buffer_length)

### Prototype
```c
const char *aeron_dlinfo(const void *, char *buffer, size_t max_buffer_length);
```
"""
function aeron_dlinfo(arg1, buffer, max_buffer_length)
    @ccall libaeron.aeron_dlinfo(arg1::Ptr{Cvoid}, buffer::Cstring, max_buffer_length::Csize_t)::Cstring
end

"""
    aeron_dlinfo_func(func, buffer, max_buffer_length)

### Prototype
```c
const char *aeron_dlinfo_func(void (*func)(void), char *buffer, size_t max_buffer_length);
```
"""
function aeron_dlinfo_func(func, buffer, max_buffer_length)
    @ccall libaeron.aeron_dlinfo_func(func::Ptr{Cvoid}, buffer::Cstring, max_buffer_length::Csize_t)::Cstring
end

struct aeron_dl_loaded_lib_state_stct
    handle::Ptr{Cvoid}
end

const aeron_dl_loaded_lib_state_t = aeron_dl_loaded_lib_state_stct

mutable struct aeron_dl_loaded_libs_state_stct
    libs::Ptr{aeron_dl_loaded_lib_state_t}
    num_libs::Csize_t
    aeron_dl_loaded_libs_state_stct() = new()
end

const aeron_dl_loaded_libs_state_t = aeron_dl_loaded_libs_state_stct

"""
    aeron_dl_load_libs(state, libs)

### Prototype
```c
int aeron_dl_load_libs(aeron_dl_loaded_libs_state_t **state, const char *libs);
```
"""
function aeron_dl_load_libs(state, libs)
    @ccall libaeron.aeron_dl_load_libs(state::Ptr{Ptr{aeron_dl_loaded_libs_state_t}}, libs::Cstring)::Cint
end

"""
    aeron_dl_load_libs_delete(state)

### Prototype
```c
int aeron_dl_load_libs_delete(aeron_dl_loaded_libs_state_t *state);
```
"""
function aeron_dl_load_libs_delete(state)
    @ccall libaeron.aeron_dl_load_libs_delete(state::Ptr{aeron_dl_loaded_libs_state_t})::Cint
end

"""
    aeron_local_sockaddr_find_addrs(reader, channel_status_indicator_id, address_vec, address_vec_len)

### Prototype
```c
int aeron_local_sockaddr_find_addrs( aeron_counters_reader_t *reader, int32_t channel_status_indicator_id, aeron_iovec_t *address_vec, size_t address_vec_len);
```
"""
function aeron_local_sockaddr_find_addrs(reader, channel_status_indicator_id, address_vec, address_vec_len)
    @ccall libaeron.aeron_local_sockaddr_find_addrs(reader::Ptr{aeron_counters_reader_t}, channel_status_indicator_id::Int32, address_vec::Ptr{aeron_iovec_t}, address_vec_len::Csize_t)::Cint
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

mutable struct aeron_idle_strategy_stct
    idle::aeron_idle_strategy_func_t
    init::aeron_idle_strategy_init_func_t
    aeron_idle_strategy_stct() = new()
end

const aeron_idle_strategy_t = aeron_idle_strategy_stct

"""
    aeron_idle_strategy_sleeping_idle(state, work_count)

### Prototype
```c
void aeron_idle_strategy_sleeping_idle(void *state, int work_count);
```
"""
function aeron_idle_strategy_sleeping_idle(state, work_count)
    @ccall libaeron.aeron_idle_strategy_sleeping_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

"""
    aeron_idle_strategy_yielding_idle(state, work_count)

### Prototype
```c
void aeron_idle_strategy_yielding_idle(void *state, int work_count);
```
"""
function aeron_idle_strategy_yielding_idle(state, work_count)
    @ccall libaeron.aeron_idle_strategy_yielding_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

"""
    aeron_idle_strategy_busy_spinning_idle(state, work_count)

### Prototype
```c
void aeron_idle_strategy_busy_spinning_idle(void *state, int work_count);
```
"""
function aeron_idle_strategy_busy_spinning_idle(state, work_count)
    @ccall libaeron.aeron_idle_strategy_busy_spinning_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

"""
    aeron_idle_strategy_noop_idle(state, work_count)

### Prototype
```c
void aeron_idle_strategy_noop_idle(void *state, int work_count);
```
"""
function aeron_idle_strategy_noop_idle(state, work_count)
    @ccall libaeron.aeron_idle_strategy_noop_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

"""
    aeron_idle_strategy_backoff_idle(state, work_count)

### Prototype
```c
void aeron_idle_strategy_backoff_idle(void *state, int work_count);
```
"""
function aeron_idle_strategy_backoff_idle(state, work_count)
    @ccall libaeron.aeron_idle_strategy_backoff_idle(state::Ptr{Cvoid}, work_count::Cint)::Cvoid
end

"""
    aeron_idle_strategy_backoff_state_init(state, max_spins, max_yields, min_park_period_ns, max_park_period_ns)

### Prototype
```c
int aeron_idle_strategy_backoff_state_init( void **state, uint64_t max_spins, uint64_t max_yields, uint64_t min_park_period_ns, uint64_t max_park_period_ns);
```
"""
function aeron_idle_strategy_backoff_state_init(state, max_spins, max_yields, min_park_period_ns, max_park_period_ns)
    @ccall libaeron.aeron_idle_strategy_backoff_state_init(state::Ptr{Ptr{Cvoid}}, max_spins::UInt64, max_yields::UInt64, min_park_period_ns::UInt64, max_park_period_ns::UInt64)::Cint
end

"""
    aeron_idle_strategy_init_null(state, env_var, load_args)

### Prototype
```c
int aeron_idle_strategy_init_null(void **state, const char *env_var, const char *load_args);
```
"""
function aeron_idle_strategy_init_null(state, env_var, load_args)
    @ccall libaeron.aeron_idle_strategy_init_null(state::Ptr{Ptr{Cvoid}}, env_var::Cstring, load_args::Cstring)::Cint
end

"""
    aeron_idle_strategy_load(idle_strategy_name, idle_strategy_state, env_var, load_args)

### Prototype
```c
aeron_idle_strategy_func_t aeron_idle_strategy_load( const char *idle_strategy_name, void **idle_strategy_state, const char *env_var, const char *load_args);
```
"""
function aeron_idle_strategy_load(idle_strategy_name, idle_strategy_state, env_var, load_args)
    @ccall libaeron.aeron_idle_strategy_load(idle_strategy_name::Cstring, idle_strategy_state::Ptr{Ptr{Cvoid}}, env_var::Cstring, load_args::Cstring)::aeron_idle_strategy_func_t
end

"""
    aeron_agent_on_start_load(name)

### Prototype
```c
aeron_agent_on_start_func_t aeron_agent_on_start_load(const char *name);
```
"""
function aeron_agent_on_start_load(name)
    @ccall libaeron.aeron_agent_on_start_load(name::Cstring)::aeron_agent_on_start_func_t
end

"""
    aeron_agent_init(runner, role_name, state, on_start, on_start_state, do_work, on_close, idle_strategy_func, idle_strategy_state)

### Prototype
```c
int aeron_agent_init( aeron_agent_runner_t *runner, const char *role_name, void *state, aeron_agent_on_start_func_t on_start, void *on_start_state, aeron_agent_do_work_func_t do_work, aeron_agent_on_close_func_t on_close, aeron_idle_strategy_func_t idle_strategy_func, void *idle_strategy_state);
```
"""
function aeron_agent_init(runner, role_name, state, on_start, on_start_state, do_work, on_close, idle_strategy_func, idle_strategy_state)
    @ccall libaeron.aeron_agent_init(runner::Ptr{aeron_agent_runner_t}, role_name::Cstring, state::Ptr{Cvoid}, on_start::aeron_agent_on_start_func_t, on_start_state::Ptr{Cvoid}, do_work::aeron_agent_do_work_func_t, on_close::aeron_agent_on_close_func_t, idle_strategy_func::aeron_idle_strategy_func_t, idle_strategy_state::Ptr{Cvoid})::Cint
end

"""
    aeron_agent_start(runner)

### Prototype
```c
int aeron_agent_start(aeron_agent_runner_t *runner);
```
"""
function aeron_agent_start(runner)
    @ccall libaeron.aeron_agent_start(runner::Ptr{aeron_agent_runner_t})::Cint
end

"""
    aeron_agent_do_work(runner)

### Prototype
```c
inline int aeron_agent_do_work(aeron_agent_runner_t *runner);
```
"""
function aeron_agent_do_work(runner)
    @ccall libaeron.aeron_agent_do_work(runner::Ptr{aeron_agent_runner_t})::Cint
end

"""
    aeron_agent_is_running(runner)

### Prototype
```c
inline bool aeron_agent_is_running(aeron_agent_runner_t *runner);
```
"""
function aeron_agent_is_running(runner)
    @ccall libaeron.aeron_agent_is_running(runner::Ptr{aeron_agent_runner_t})::Bool
end

"""
    aeron_agent_idle(runner, work_count)

### Prototype
```c
inline void aeron_agent_idle(aeron_agent_runner_t *runner, int work_count);
```
"""
function aeron_agent_idle(runner, work_count)
    @ccall libaeron.aeron_agent_idle(runner::Ptr{aeron_agent_runner_t}, work_count::Cint)::Cvoid
end

"""
    aeron_agent_stop(runner)

### Prototype
```c
int aeron_agent_stop(aeron_agent_runner_t *runner);
```
"""
function aeron_agent_stop(runner)
    @ccall libaeron.aeron_agent_stop(runner::Ptr{aeron_agent_runner_t})::Cint
end

"""
    aeron_agent_close(runner)

### Prototype
```c
int aeron_agent_close(aeron_agent_runner_t *runner);
```
"""
function aeron_agent_close(runner)
    @ccall libaeron.aeron_agent_close(runner::Ptr{aeron_agent_runner_t})::Cint
end

"""
    aeron_is_directory(path)

### Prototype
```c
int aeron_is_directory(const char *path);
```
"""
function aeron_is_directory(path)
    @ccall libaeron.aeron_is_directory(path::Cstring)::Cint
end

"""
    aeron_delete_directory(directory)

### Prototype
```c
int aeron_delete_directory(const char *directory);
```
"""
function aeron_delete_directory(directory)
    @ccall libaeron.aeron_delete_directory(directory::Cstring)::Cint
end

"""
    aeron_map_new_file(mapped_file, path, fill_with_zeroes)

### Prototype
```c
int aeron_map_new_file(aeron_mapped_file_t *mapped_file, const char *path, bool fill_with_zeroes);
```
"""
function aeron_map_new_file(mapped_file, path, fill_with_zeroes)
    @ccall libaeron.aeron_map_new_file(mapped_file::Ptr{aeron_mapped_file_t}, path::Cstring, fill_with_zeroes::Bool)::Cint
end

"""
    aeron_map_existing_file(mapped_file, path)

### Prototype
```c
int aeron_map_existing_file(aeron_mapped_file_t *mapped_file, const char *path);
```
"""
function aeron_map_existing_file(mapped_file, path)
    @ccall libaeron.aeron_map_existing_file(mapped_file::Ptr{aeron_mapped_file_t}, path::Cstring)::Cint
end

"""
    aeron_unmap(mapped_file)

### Prototype
```c
int aeron_unmap(aeron_mapped_file_t *mapped_file);
```
"""
function aeron_unmap(mapped_file)
    @ccall libaeron.aeron_unmap(mapped_file::Ptr{aeron_mapped_file_t})::Cint
end

# typedef uint64_t ( * aeron_usable_fs_space_func_t ) ( const char * path )
const aeron_usable_fs_space_func_t = Ptr{Cvoid}

"""
    aeron_file_length(path)

### Prototype
```c
int64_t aeron_file_length(const char *path);
```
"""
function aeron_file_length(path)
    @ccall libaeron.aeron_file_length(path::Cstring)::Int64
end

"""
    aeron_usable_fs_space(path)

### Prototype
```c
uint64_t aeron_usable_fs_space(const char *path);
```
"""
function aeron_usable_fs_space(path)
    @ccall libaeron.aeron_usable_fs_space(path::Cstring)::UInt64
end

"""
    aeron_usable_fs_space_disabled(path)

### Prototype
```c
uint64_t aeron_usable_fs_space_disabled(const char *path);
```
"""
function aeron_usable_fs_space_disabled(path)
    @ccall libaeron.aeron_usable_fs_space_disabled(path::Cstring)::UInt64
end

"""
    aeron_ipc_publication_location(dst, length, aeron_dir, correlation_id)

### Prototype
```c
int aeron_ipc_publication_location(char *dst, size_t length, const char *aeron_dir, int64_t correlation_id);
```
"""
function aeron_ipc_publication_location(dst, length, aeron_dir, correlation_id)
    @ccall libaeron.aeron_ipc_publication_location(dst::Cstring, length::Csize_t, aeron_dir::Cstring, correlation_id::Int64)::Cint
end

"""
    aeron_network_publication_location(dst, length, aeron_dir, correlation_id)

### Prototype
```c
int aeron_network_publication_location(char *dst, size_t length, const char *aeron_dir, int64_t correlation_id);
```
"""
function aeron_network_publication_location(dst, length, aeron_dir, correlation_id)
    @ccall libaeron.aeron_network_publication_location(dst::Cstring, length::Csize_t, aeron_dir::Cstring, correlation_id::Int64)::Cint
end

"""
    aeron_publication_image_location(dst, length, aeron_dir, correlation_id)

### Prototype
```c
int aeron_publication_image_location(char *dst, size_t length, const char *aeron_dir, int64_t correlation_id);
```
"""
function aeron_publication_image_location(dst, length, aeron_dir, correlation_id)
    @ccall libaeron.aeron_publication_image_location(dst::Cstring, length::Csize_t, aeron_dir::Cstring, correlation_id::Int64)::Cint
end

"""
    aeron_temp_filename(filename, length)

### Prototype
```c
size_t aeron_temp_filename(char *filename, size_t length);
```
"""
function aeron_temp_filename(filename, length)
    @ccall libaeron.aeron_temp_filename(filename::Cstring, length::Csize_t)::Csize_t
end

# typedef int ( * aeron_raw_log_map_func_t ) ( aeron_mapped_raw_log_t * , const char * , bool , uint64_t , uint64_t )
const aeron_raw_log_map_func_t = Ptr{Cvoid}

# typedef int ( * aeron_raw_log_close_func_t ) ( aeron_mapped_raw_log_t * , const char * filename )
const aeron_raw_log_close_func_t = Ptr{Cvoid}

# typedef bool ( * aeron_raw_log_free_func_t ) ( aeron_mapped_raw_log_t * , const char * filename )
const aeron_raw_log_free_func_t = Ptr{Cvoid}

"""
    aeron_raw_log_map(mapped_raw_log, path, use_sparse_files, term_length, page_size)

### Prototype
```c
int aeron_raw_log_map( aeron_mapped_raw_log_t *mapped_raw_log, const char *path, bool use_sparse_files, uint64_t term_length, uint64_t page_size);
```
"""
function aeron_raw_log_map(mapped_raw_log, path, use_sparse_files, term_length, page_size)
    @ccall libaeron.aeron_raw_log_map(mapped_raw_log::Ptr{aeron_mapped_raw_log_t}, path::Cstring, use_sparse_files::Bool, term_length::UInt64, page_size::UInt64)::Cint
end

"""
    aeron_raw_log_map_existing(mapped_raw_log, path, pre_touch)

### Prototype
```c
int aeron_raw_log_map_existing(aeron_mapped_raw_log_t *mapped_raw_log, const char *path, bool pre_touch);
```
"""
function aeron_raw_log_map_existing(mapped_raw_log, path, pre_touch)
    @ccall libaeron.aeron_raw_log_map_existing(mapped_raw_log::Ptr{aeron_mapped_raw_log_t}, path::Cstring, pre_touch::Bool)::Cint
end

"""
    aeron_raw_log_close(mapped_raw_log, filename)

### Prototype
```c
int aeron_raw_log_close(aeron_mapped_raw_log_t *mapped_raw_log, const char *filename);
```
"""
function aeron_raw_log_close(mapped_raw_log, filename)
    @ccall libaeron.aeron_raw_log_close(mapped_raw_log::Ptr{aeron_mapped_raw_log_t}, filename::Cstring)::Cint
end

"""
    aeron_raw_log_free(mapped_raw_log, filename)

### Prototype
```c
bool aeron_raw_log_free(aeron_mapped_raw_log_t *mapped_raw_log, const char *filename);
```
"""
function aeron_raw_log_free(mapped_raw_log, filename)
    @ccall libaeron.aeron_raw_log_free(mapped_raw_log::Ptr{aeron_mapped_raw_log_t}, filename::Cstring)::Bool
end

"""
    aeron_file_resolve(parent, child, buffer, buffer_len)

### Prototype
```c
int aeron_file_resolve(const char *parent, const char *child, char *buffer, size_t buffer_len);
```
"""
function aeron_file_resolve(parent, child, buffer, buffer_len)
    @ccall libaeron.aeron_file_resolve(parent::Cstring, child::Cstring, buffer::Cstring, buffer_len::Csize_t)::Cint
end

@cenum aeron_queue_offer_result_stct::Int32 begin
    AERON_OFFER_SUCCESS = 0
    AERON_OFFER_ERROR = -2
    AERON_OFFER_FULL = -1
end

const aeron_queue_offer_result_t = aeron_queue_offer_result_stct

# typedef void ( * aeron_queue_drain_func_t ) ( void * clientd , void * item )
const aeron_queue_drain_func_t = Ptr{Cvoid}

"""
    aeron_mpsc_concurrent_array_queue_init(queue, length)

### Prototype
```c
int aeron_mpsc_concurrent_array_queue_init(aeron_mpsc_concurrent_array_queue_t *queue, size_t length);
```
"""
function aeron_mpsc_concurrent_array_queue_init(queue, length)
    @ccall libaeron.aeron_mpsc_concurrent_array_queue_init(queue::Ptr{aeron_mpsc_concurrent_array_queue_t}, length::Csize_t)::Cint
end

"""
    aeron_mpsc_concurrent_array_queue_close(queue)

### Prototype
```c
int aeron_mpsc_concurrent_array_queue_close(aeron_mpsc_concurrent_array_queue_t *queue);
```
"""
function aeron_mpsc_concurrent_array_queue_close(queue)
    @ccall libaeron.aeron_mpsc_concurrent_array_queue_close(queue::Ptr{aeron_mpsc_concurrent_array_queue_t})::Cint
end

"""
    aeron_mpsc_concurrent_array_queue_offer(queue, element)

### Prototype
```c
inline aeron_queue_offer_result_t aeron_mpsc_concurrent_array_queue_offer( aeron_mpsc_concurrent_array_queue_t *queue, void *element);
```
"""
function aeron_mpsc_concurrent_array_queue_offer(queue, element)
    @ccall libaeron.aeron_mpsc_concurrent_array_queue_offer(queue::Ptr{aeron_mpsc_concurrent_array_queue_t}, element::Ptr{Cvoid})::aeron_queue_offer_result_t
end

"""
    aeron_mpsc_concurrent_array_queue_drain(queue, func, clientd, limit)

### Prototype
```c
inline size_t aeron_mpsc_concurrent_array_queue_drain( aeron_mpsc_concurrent_array_queue_t *queue, aeron_queue_drain_func_t func, void *clientd, size_t limit);
```
"""
function aeron_mpsc_concurrent_array_queue_drain(queue, func, clientd, limit)
    @ccall libaeron.aeron_mpsc_concurrent_array_queue_drain(queue::Ptr{aeron_mpsc_concurrent_array_queue_t}, func::aeron_queue_drain_func_t, clientd::Ptr{Cvoid}, limit::Csize_t)::Csize_t
end

"""
    aeron_mpsc_concurrent_array_queue_drain_all(queue, func, clientd)

### Prototype
```c
inline size_t aeron_mpsc_concurrent_array_queue_drain_all( aeron_mpsc_concurrent_array_queue_t *queue, aeron_queue_drain_func_t func, void *clientd);
```
"""
function aeron_mpsc_concurrent_array_queue_drain_all(queue, func, clientd)
    @ccall libaeron.aeron_mpsc_concurrent_array_queue_drain_all(queue::Ptr{aeron_mpsc_concurrent_array_queue_t}, func::aeron_queue_drain_func_t, clientd::Ptr{Cvoid})::Csize_t
end

"""
    aeron_mpsc_concurrent_array_queue_size(queue)

### Prototype
```c
inline size_t aeron_mpsc_concurrent_array_queue_size(aeron_mpsc_concurrent_array_queue_t *queue);
```
"""
function aeron_mpsc_concurrent_array_queue_size(queue)
    @ccall libaeron.aeron_mpsc_concurrent_array_queue_size(queue::Ptr{aeron_mpsc_concurrent_array_queue_t})::Csize_t
end

# typedef void ( * aeron_broadcast_receiver_handler_t ) ( int32_t type_id , uint8_t * buffer , size_t length , void * clientd )
const aeron_broadcast_receiver_handler_t = Ptr{Cvoid}

"""
    aeron_broadcast_receiver_init(receiver, buffer, length)

### Prototype
```c
int aeron_broadcast_receiver_init(aeron_broadcast_receiver_t *receiver, void *buffer, size_t length);
```
"""
function aeron_broadcast_receiver_init(receiver, buffer, length)
    @ccall libaeron.aeron_broadcast_receiver_init(receiver::Ptr{aeron_broadcast_receiver_t}, buffer::Ptr{Cvoid}, length::Csize_t)::Cint
end

"""
    aeron_broadcast_receiver_validate_at(receiver, cursor)

### Prototype
```c
inline bool aeron_broadcast_receiver_validate_at(aeron_broadcast_receiver_t *receiver, int64_t cursor);
```
"""
function aeron_broadcast_receiver_validate_at(receiver, cursor)
    @ccall libaeron.aeron_broadcast_receiver_validate_at(receiver::Ptr{aeron_broadcast_receiver_t}, cursor::Int64)::Bool
end

"""
    aeron_broadcast_receiver_validate(receiver)

### Prototype
```c
inline bool aeron_broadcast_receiver_validate(aeron_broadcast_receiver_t *receiver);
```
"""
function aeron_broadcast_receiver_validate(receiver)
    @ccall libaeron.aeron_broadcast_receiver_validate(receiver::Ptr{aeron_broadcast_receiver_t})::Bool
end

"""
    aeron_broadcast_receiver_receive_next(receiver)

### Prototype
```c
inline bool aeron_broadcast_receiver_receive_next(aeron_broadcast_receiver_t *receiver);
```
"""
function aeron_broadcast_receiver_receive_next(receiver)
    @ccall libaeron.aeron_broadcast_receiver_receive_next(receiver::Ptr{aeron_broadcast_receiver_t})::Bool
end

"""
    aeron_broadcast_receiver_receive(receiver, handler, clientd)

### Prototype
```c
int aeron_broadcast_receiver_receive( aeron_broadcast_receiver_t *receiver, aeron_broadcast_receiver_handler_t handler, void *clientd);
```
"""
function aeron_broadcast_receiver_receive(receiver, handler, clientd)
    @ccall libaeron.aeron_broadcast_receiver_receive(receiver::Ptr{aeron_broadcast_receiver_t}, handler::aeron_broadcast_receiver_handler_t, clientd::Ptr{Cvoid})::Cint
end

@cenum aeron_rb_write_result_stct::Int32 begin
    AERON_RB_SUCCESS = 0
    AERON_RB_ERROR = -2
    AERON_RB_FULL = -1
end

const aeron_rb_write_result_t = aeron_rb_write_result_stct

# typedef void ( * aeron_rb_handler_t ) ( int32_t , const void * , size_t , void * )
const aeron_rb_handler_t = Ptr{Cvoid}

"""
    aeron_mpsc_rb_init(ring_buffer, buffer, length)

### Prototype
```c
int aeron_mpsc_rb_init(aeron_mpsc_rb_t *ring_buffer, void *buffer, size_t length);
```
"""
function aeron_mpsc_rb_init(ring_buffer, buffer, length)
    @ccall libaeron.aeron_mpsc_rb_init(ring_buffer::Ptr{aeron_mpsc_rb_t}, buffer::Ptr{Cvoid}, length::Csize_t)::Cint
end

"""
    aeron_mpsc_rb_write(ring_buffer, msg_type_id, msg, length)

### Prototype
```c
aeron_rb_write_result_t aeron_mpsc_rb_write( aeron_mpsc_rb_t *ring_buffer, int32_t msg_type_id, const void *msg, size_t length);
```
"""
function aeron_mpsc_rb_write(ring_buffer, msg_type_id, msg, length)
    @ccall libaeron.aeron_mpsc_rb_write(ring_buffer::Ptr{aeron_mpsc_rb_t}, msg_type_id::Int32, msg::Ptr{Cvoid}, length::Csize_t)::aeron_rb_write_result_t
end

"""
    aeron_mpsc_rb_try_claim(ring_buffer, msg_type_id, length)

### Prototype
```c
int32_t aeron_mpsc_rb_try_claim(aeron_mpsc_rb_t *ring_buffer, int32_t msg_type_id, size_t length);
```
"""
function aeron_mpsc_rb_try_claim(ring_buffer, msg_type_id, length)
    @ccall libaeron.aeron_mpsc_rb_try_claim(ring_buffer::Ptr{aeron_mpsc_rb_t}, msg_type_id::Int32, length::Csize_t)::Int32
end

"""
    aeron_mpsc_rb_commit(ring_buffer, offset)

### Prototype
```c
int aeron_mpsc_rb_commit(aeron_mpsc_rb_t *ring_buffer, int32_t offset);
```
"""
function aeron_mpsc_rb_commit(ring_buffer, offset)
    @ccall libaeron.aeron_mpsc_rb_commit(ring_buffer::Ptr{aeron_mpsc_rb_t}, offset::Int32)::Cint
end

"""
    aeron_mpsc_rb_abort(ring_buffer, offset)

### Prototype
```c
int aeron_mpsc_rb_abort(aeron_mpsc_rb_t *ring_buffer, int32_t offset);
```
"""
function aeron_mpsc_rb_abort(ring_buffer, offset)
    @ccall libaeron.aeron_mpsc_rb_abort(ring_buffer::Ptr{aeron_mpsc_rb_t}, offset::Int32)::Cint
end

"""
    aeron_mpsc_rb_read(ring_buffer, handler, clientd, message_count_limit)

### Prototype
```c
size_t aeron_mpsc_rb_read( aeron_mpsc_rb_t *ring_buffer, aeron_rb_handler_t handler, void *clientd, size_t message_count_limit);
```
"""
function aeron_mpsc_rb_read(ring_buffer, handler, clientd, message_count_limit)
    @ccall libaeron.aeron_mpsc_rb_read(ring_buffer::Ptr{aeron_mpsc_rb_t}, handler::aeron_rb_handler_t, clientd::Ptr{Cvoid}, message_count_limit::Csize_t)::Csize_t
end

"""
    aeron_mpsc_rb_next_correlation_id(ring_buffer)

### Prototype
```c
int64_t aeron_mpsc_rb_next_correlation_id(aeron_mpsc_rb_t *ring_buffer);
```
"""
function aeron_mpsc_rb_next_correlation_id(ring_buffer)
    @ccall libaeron.aeron_mpsc_rb_next_correlation_id(ring_buffer::Ptr{aeron_mpsc_rb_t})::Int64
end

"""
    aeron_mpsc_rb_consumer_heartbeat_time(ring_buffer, now_ms)

### Prototype
```c
void aeron_mpsc_rb_consumer_heartbeat_time(aeron_mpsc_rb_t *ring_buffer, int64_t now_ms);
```
"""
function aeron_mpsc_rb_consumer_heartbeat_time(ring_buffer, now_ms)
    @ccall libaeron.aeron_mpsc_rb_consumer_heartbeat_time(ring_buffer::Ptr{aeron_mpsc_rb_t}, now_ms::Int64)::Cvoid
end

"""
    aeron_mpsc_rb_consumer_heartbeat_time_value(ring_buffer)

### Prototype
```c
int64_t aeron_mpsc_rb_consumer_heartbeat_time_value(aeron_mpsc_rb_t *ring_buffer);
```
"""
function aeron_mpsc_rb_consumer_heartbeat_time_value(ring_buffer)
    @ccall libaeron.aeron_mpsc_rb_consumer_heartbeat_time_value(ring_buffer::Ptr{aeron_mpsc_rb_t})::Int64
end

"""
    aeron_mpsc_rb_unblock(ring_buffer)

### Prototype
```c
bool aeron_mpsc_rb_unblock(aeron_mpsc_rb_t *ring_buffer);
```
"""
function aeron_mpsc_rb_unblock(ring_buffer)
    @ccall libaeron.aeron_mpsc_rb_unblock(ring_buffer::Ptr{aeron_mpsc_rb_t})::Bool
end

"""
    aeron_mpsc_rb_consumer_position(ring_buffer)

### Prototype
```c
inline int64_t aeron_mpsc_rb_consumer_position(aeron_mpsc_rb_t *ring_buffer);
```
"""
function aeron_mpsc_rb_consumer_position(ring_buffer)
    @ccall libaeron.aeron_mpsc_rb_consumer_position(ring_buffer::Ptr{aeron_mpsc_rb_t})::Int64
end

"""
    aeron_mpsc_rb_producer_position(ring_buffer)

### Prototype
```c
inline int64_t aeron_mpsc_rb_producer_position(aeron_mpsc_rb_t *ring_buffer);
```
"""
function aeron_mpsc_rb_producer_position(ring_buffer)
    @ccall libaeron.aeron_mpsc_rb_producer_position(ring_buffer::Ptr{aeron_mpsc_rb_t})::Int64
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

mutable struct aeron_counters_manager_stct
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
    aeron_counters_manager_stct() = new()
end

const aeron_counters_manager_t = aeron_counters_manager_stct

"""
    aeron_counters_manager_init(manager, metadata_buffer, metadata_length, values_buffer, values_length, cached_clock, free_to_reuse_timeout_ms)

### Prototype
```c
int aeron_counters_manager_init( aeron_counters_manager_t *manager, uint8_t *metadata_buffer, size_t metadata_length, uint8_t *values_buffer, size_t values_length, aeron_clock_cache_t *cached_clock, int64_t free_to_reuse_timeout_ms);
```
"""
function aeron_counters_manager_init(manager, metadata_buffer, metadata_length, values_buffer, values_length, cached_clock, free_to_reuse_timeout_ms)
    @ccall libaeron.aeron_counters_manager_init(manager::Ptr{aeron_counters_manager_t}, metadata_buffer::Ptr{UInt8}, metadata_length::Csize_t, values_buffer::Ptr{UInt8}, values_length::Csize_t, cached_clock::Ptr{aeron_clock_cache_t}, free_to_reuse_timeout_ms::Int64)::Cint
end

"""
    aeron_counters_manager_close(manager)

### Prototype
```c
void aeron_counters_manager_close(aeron_counters_manager_t *manager);
```
"""
function aeron_counters_manager_close(manager)
    @ccall libaeron.aeron_counters_manager_close(manager::Ptr{aeron_counters_manager_t})::Cvoid
end

"""
    aeron_counters_manager_allocate(manager, type_id, key, key_length, label, label_length)

### Prototype
```c
int32_t aeron_counters_manager_allocate( aeron_counters_manager_t *manager, int32_t type_id, const uint8_t *key, size_t key_length, const char *label, size_t label_length);
```
"""
function aeron_counters_manager_allocate(manager, type_id, key, key_length, label, label_length)
    @ccall libaeron.aeron_counters_manager_allocate(manager::Ptr{aeron_counters_manager_t}, type_id::Int32, key::Ptr{UInt8}, key_length::Csize_t, label::Cstring, label_length::Csize_t)::Int32
end

"""
    aeron_counters_manager_counter_registration_id(manager, counter_id, registration_id)

### Prototype
```c
void aeron_counters_manager_counter_registration_id( aeron_counters_manager_t *manager, int32_t counter_id, int64_t registration_id);
```
"""
function aeron_counters_manager_counter_registration_id(manager, counter_id, registration_id)
    @ccall libaeron.aeron_counters_manager_counter_registration_id(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32, registration_id::Int64)::Cvoid
end

"""
    aeron_counters_manager_counter_owner_id(manager, counter_id, owner_id)

### Prototype
```c
void aeron_counters_manager_counter_owner_id( aeron_counters_manager_t *manager, int32_t counter_id, int64_t owner_id);
```
"""
function aeron_counters_manager_counter_owner_id(manager, counter_id, owner_id)
    @ccall libaeron.aeron_counters_manager_counter_owner_id(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32, owner_id::Int64)::Cvoid
end

"""
    aeron_counters_manager_update_label(manager, counter_id, label_length, label)

### Prototype
```c
void aeron_counters_manager_update_label( aeron_counters_manager_t *manager, int32_t counter_id, size_t label_length, const char *label);
```
"""
function aeron_counters_manager_update_label(manager, counter_id, label_length, label)
    @ccall libaeron.aeron_counters_manager_update_label(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32, label_length::Csize_t, label::Cstring)::Cvoid
end

"""
    aeron_counters_manager_append_to_label(manager, counter_id, length, value)

### Prototype
```c
void aeron_counters_manager_append_to_label( aeron_counters_manager_t *manager, int32_t counter_id, size_t length, const char *value);
```
"""
function aeron_counters_manager_append_to_label(manager, counter_id, length, value)
    @ccall libaeron.aeron_counters_manager_append_to_label(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32, length::Csize_t, value::Cstring)::Cvoid
end

"""
    aeron_counters_manager_next_counter_id(manager)

### Prototype
```c
int32_t aeron_counters_manager_next_counter_id(aeron_counters_manager_t *manager);
```
"""
function aeron_counters_manager_next_counter_id(manager)
    @ccall libaeron.aeron_counters_manager_next_counter_id(manager::Ptr{aeron_counters_manager_t})::Int32
end

"""
    aeron_counters_manager_free(manager, counter_id)

### Prototype
```c
int aeron_counters_manager_free(aeron_counters_manager_t *manager, int32_t counter_id);
```
"""
function aeron_counters_manager_free(manager, counter_id)
    @ccall libaeron.aeron_counters_manager_free(manager::Ptr{aeron_counters_manager_t}, counter_id::Int32)::Cint
end

# typedef void ( * aeron_counters_reader_foreach_metadata_func_t ) ( int32_t id , int32_t type_id , const uint8_t * key , size_t key_length , const uint8_t * label , size_t label_length , void * clientd )
const aeron_counters_reader_foreach_metadata_func_t = Ptr{Cvoid}

"""
    aeron_counters_reader_foreach_metadata(metadata_buffer, metadata_length, func, clientd)

### Prototype
```c
void aeron_counters_reader_foreach_metadata( uint8_t *metadata_buffer, size_t metadata_length, aeron_counters_reader_foreach_metadata_func_t func, void *clientd);
```
"""
function aeron_counters_reader_foreach_metadata(metadata_buffer, metadata_length, func, clientd)
    @ccall libaeron.aeron_counters_reader_foreach_metadata(metadata_buffer::Ptr{UInt8}, metadata_length::Csize_t, func::aeron_counters_reader_foreach_metadata_func_t, clientd::Ptr{Cvoid})::Cvoid
end

"""
    aeron_counters_manager_addr(counters_manager, counter_id)

### Prototype
```c
inline int64_t *aeron_counters_manager_addr(aeron_counters_manager_t *counters_manager, int32_t counter_id);
```
"""
function aeron_counters_manager_addr(counters_manager, counter_id)
    @ccall libaeron.aeron_counters_manager_addr(counters_manager::Ptr{aeron_counters_manager_t}, counter_id::Int32)::Ptr{Int64}
end

"""
    aeron_counters_reader_init(reader, metadata_buffer, metadata_length, values_buffer, values_length)

### Prototype
```c
inline int aeron_counters_reader_init( aeron_counters_reader_t *reader, uint8_t *metadata_buffer, size_t metadata_length, uint8_t *values_buffer, size_t values_length);
```
"""
function aeron_counters_reader_init(reader, metadata_buffer, metadata_length, values_buffer, values_length)
    @ccall libaeron.aeron_counters_reader_init(reader::Ptr{aeron_counters_reader_t}, metadata_buffer::Ptr{UInt8}, metadata_length::Csize_t, values_buffer::Ptr{UInt8}, values_length::Csize_t)::Cint
end

"""
    aeron_counter_set_ordered(addr, value)

### Prototype
```c
inline void aeron_counter_set_ordered(volatile int64_t *addr, int64_t value);
```
"""
function aeron_counter_set_ordered(addr, value)
    @ccall libaeron.aeron_counter_set_ordered(addr::Ptr{Int64}, value::Int64)::Cvoid
end

"""
    aeron_counter_get(addr)

### Prototype
```c
inline int64_t aeron_counter_get(volatile int64_t *addr);
```
"""
function aeron_counter_get(addr)
    @ccall libaeron.aeron_counter_get(addr::Ptr{Int64})::Int64
end

"""
    aeron_counter_get_volatile(addr)

### Prototype
```c
inline int64_t aeron_counter_get_volatile(volatile int64_t *addr);
```
"""
function aeron_counter_get_volatile(addr)
    @ccall libaeron.aeron_counter_get_volatile(addr::Ptr{Int64})::Int64
end

"""
    aeron_counter_increment(addr, value)

### Prototype
```c
inline int64_t aeron_counter_increment(volatile int64_t *addr, int64_t value);
```
"""
function aeron_counter_increment(addr, value)
    @ccall libaeron.aeron_counter_increment(addr::Ptr{Int64}, value::Int64)::Int64
end

"""
    aeron_counter_ordered_increment(addr, value)

### Prototype
```c
inline int64_t aeron_counter_ordered_increment(volatile int64_t *addr, int64_t value);
```
"""
function aeron_counter_ordered_increment(addr, value)
    @ccall libaeron.aeron_counter_ordered_increment(addr::Ptr{Int64}, value::Int64)::Int64
end

"""
    aeron_counter_add_ordered(addr, value)

### Prototype
```c
inline int64_t aeron_counter_add_ordered(volatile int64_t *addr, int64_t value);
```
"""
function aeron_counter_add_ordered(addr, value)
    @ccall libaeron.aeron_counter_add_ordered(addr::Ptr{Int64}, value::Int64)::Int64
end

"""
    aeron_counter_propose_max_ordered(addr, proposed_value)

### Prototype
```c
inline bool aeron_counter_propose_max_ordered(volatile int64_t *addr, int64_t proposed_value);
```
"""
function aeron_counter_propose_max_ordered(addr, proposed_value)
    @ccall libaeron.aeron_counter_propose_max_ordered(addr::Ptr{Int64}, proposed_value::Int64)::Bool
end

"""
    aeron_int64_to_ptr_hash_map_hash_key(key, mask)

### Prototype
```c
inline size_t aeron_int64_to_ptr_hash_map_hash_key(int64_t key, size_t mask);
```
"""
function aeron_int64_to_ptr_hash_map_hash_key(key, mask)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_hash_key(key::Int64, mask::Csize_t)::Csize_t
end

"""
    aeron_int64_to_ptr_hash_map_init(map, initial_capacity, load_factor)

### Prototype
```c
inline int aeron_int64_to_ptr_hash_map_init( aeron_int64_to_ptr_hash_map_t *map, size_t initial_capacity, float load_factor);
```
"""
function aeron_int64_to_ptr_hash_map_init(map, initial_capacity, load_factor)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_init(map::Ptr{aeron_int64_to_ptr_hash_map_t}, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

"""
    aeron_int64_to_ptr_hash_map_delete(map)

### Prototype
```c
inline void aeron_int64_to_ptr_hash_map_delete(aeron_int64_to_ptr_hash_map_t *map);
```
"""
function aeron_int64_to_ptr_hash_map_delete(map)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_delete(map::Ptr{aeron_int64_to_ptr_hash_map_t})::Cvoid
end

"""
    aeron_int64_to_ptr_hash_map_rehash(map, new_capacity)

### Prototype
```c
inline int aeron_int64_to_ptr_hash_map_rehash(aeron_int64_to_ptr_hash_map_t *map, size_t new_capacity);
```
"""
function aeron_int64_to_ptr_hash_map_rehash(map, new_capacity)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_rehash(map::Ptr{aeron_int64_to_ptr_hash_map_t}, new_capacity::Csize_t)::Cint
end

"""
    aeron_int64_to_ptr_hash_map_put(map, key, value)

### Prototype
```c
inline int aeron_int64_to_ptr_hash_map_put(aeron_int64_to_ptr_hash_map_t *map, const int64_t key, void *value);
```
"""
function aeron_int64_to_ptr_hash_map_put(map, key, value)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_put(map::Ptr{aeron_int64_to_ptr_hash_map_t}, key::Int64, value::Ptr{Cvoid})::Cint
end

"""
    aeron_int64_to_ptr_hash_map_get(map, key)

### Prototype
```c
inline void *aeron_int64_to_ptr_hash_map_get(aeron_int64_to_ptr_hash_map_t *map, const int64_t key);
```
"""
function aeron_int64_to_ptr_hash_map_get(map, key)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_get(map::Ptr{aeron_int64_to_ptr_hash_map_t}, key::Int64)::Ptr{Cvoid}
end

"""
    aeron_int64_to_ptr_hash_map_compact_chain(map, delete_index)

### Prototype
```c
inline void aeron_int64_to_ptr_hash_map_compact_chain(aeron_int64_to_ptr_hash_map_t *map, size_t delete_index);
```
"""
function aeron_int64_to_ptr_hash_map_compact_chain(map, delete_index)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_compact_chain(map::Ptr{aeron_int64_to_ptr_hash_map_t}, delete_index::Csize_t)::Cvoid
end

"""
    aeron_int64_to_ptr_hash_map_remove(map, key)

### Prototype
```c
inline void *aeron_int64_to_ptr_hash_map_remove(aeron_int64_to_ptr_hash_map_t *map, int64_t key);
```
"""
function aeron_int64_to_ptr_hash_map_remove(map, key)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_remove(map::Ptr{aeron_int64_to_ptr_hash_map_t}, key::Int64)::Ptr{Cvoid}
end

# typedef void ( * aeron_int64_to_ptr_hash_map_for_each_func_t ) ( void * clientd , int64_t key , void * value )
const aeron_int64_to_ptr_hash_map_for_each_func_t = Ptr{Cvoid}

# typedef bool ( * aeron_int64_to_ptr_hash_map_predicate_func_t ) ( void * clientd , int64_t key , void * value )
const aeron_int64_to_ptr_hash_map_predicate_func_t = Ptr{Cvoid}

"""
    aeron_int64_to_ptr_hash_map_for_each(map, func, clientd)

### Prototype
```c
inline void aeron_int64_to_ptr_hash_map_for_each( aeron_int64_to_ptr_hash_map_t *map, aeron_int64_to_ptr_hash_map_for_each_func_t func, void *clientd);
```
"""
function aeron_int64_to_ptr_hash_map_for_each(map, func, clientd)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_for_each(map::Ptr{aeron_int64_to_ptr_hash_map_t}, func::aeron_int64_to_ptr_hash_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

"""
    aeron_int64_to_ptr_hash_map_remove_if(map, func, clientd)

### Prototype
```c
inline void aeron_int64_to_ptr_hash_map_remove_if( aeron_int64_to_ptr_hash_map_t *map, aeron_int64_to_ptr_hash_map_predicate_func_t func, void *clientd);
```
"""
function aeron_int64_to_ptr_hash_map_remove_if(map, func, clientd)
    @ccall libaeron.aeron_int64_to_ptr_hash_map_remove_if(map::Ptr{aeron_int64_to_ptr_hash_map_t}, func::aeron_int64_to_ptr_hash_map_predicate_func_t, clientd::Ptr{Cvoid})::Cvoid
end

@cenum aeron_client_handler_cmd_type_en::UInt32 begin
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

"""
    aeron_client_conductor_init(conductor, context)

### Prototype
```c
int aeron_client_conductor_init(aeron_client_conductor_t *conductor, aeron_context_t *context);
```
"""
function aeron_client_conductor_init(conductor, context)
    @ccall libaeron.aeron_client_conductor_init(conductor::Ptr{aeron_client_conductor_t}, context::Ptr{aeron_context_t})::Cint
end

"""
    aeron_client_conductor_do_work(conductor)

### Prototype
```c
int aeron_client_conductor_do_work(aeron_client_conductor_t *conductor);
```
"""
function aeron_client_conductor_do_work(conductor)
    @ccall libaeron.aeron_client_conductor_do_work(conductor::Ptr{aeron_client_conductor_t})::Cint
end

"""
    aeron_client_conductor_on_close(conductor)

### Prototype
```c
void aeron_client_conductor_on_close(aeron_client_conductor_t *conductor);
```
"""
function aeron_client_conductor_on_close(conductor)
    @ccall libaeron.aeron_client_conductor_on_close(conductor::Ptr{aeron_client_conductor_t})::Cvoid
end

"""
    aeron_client_conductor_force_close_resources(conductor)

### Prototype
```c
void aeron_client_conductor_force_close_resources(aeron_client_conductor_t *conductor);
```
"""
function aeron_client_conductor_force_close_resources(conductor)
    @ccall libaeron.aeron_client_conductor_force_close_resources(conductor::Ptr{aeron_client_conductor_t})::Cvoid
end

"""
    aeron_client_conductor_on_cmd_add_publication(clientd, item)

### Prototype
```c
void aeron_client_conductor_on_cmd_add_publication(void *clientd, void *item);
```
"""
function aeron_client_conductor_on_cmd_add_publication(clientd, item)
    @ccall libaeron.aeron_client_conductor_on_cmd_add_publication(clientd::Ptr{Cvoid}, item::Ptr{Cvoid})::Cvoid
end

"""
    aeron_client_conductor_on_cmd_close_publication(clientd, item)

### Prototype
```c
void aeron_client_conductor_on_cmd_close_publication(void *clientd, void *item);
```
"""
function aeron_client_conductor_on_cmd_close_publication(clientd, item)
    @ccall libaeron.aeron_client_conductor_on_cmd_close_publication(clientd::Ptr{Cvoid}, item::Ptr{Cvoid})::Cvoid
end

"""
    aeron_client_conductor_async_add_publication(async, conductor, uri, stream_id)

### Prototype
```c
int aeron_client_conductor_async_add_publication( aeron_async_add_publication_t **async, aeron_client_conductor_t *conductor, const char *uri, int32_t stream_id);
```
"""
function aeron_client_conductor_async_add_publication(async, conductor, uri, stream_id)
    @ccall libaeron.aeron_client_conductor_async_add_publication(async::Ptr{Ptr{aeron_async_add_publication_t}}, conductor::Ptr{aeron_client_conductor_t}, uri::Cstring, stream_id::Int32)::Cint
end

"""
    aeron_client_conductor_async_close_publication(conductor, publication, on_close_complete, on_close_complete_clientd)

### Prototype
```c
int aeron_client_conductor_async_close_publication( aeron_client_conductor_t *conductor, aeron_publication_t *publication, aeron_notification_t on_close_complete, void *on_close_complete_clientd);
```
"""
function aeron_client_conductor_async_close_publication(conductor, publication, on_close_complete, on_close_complete_clientd)
    @ccall libaeron.aeron_client_conductor_async_close_publication(conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_publication_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_client_conductor_async_add_exclusive_publication(async, conductor, uri, stream_id)

### Prototype
```c
int aeron_client_conductor_async_add_exclusive_publication( aeron_async_add_exclusive_publication_t **async, aeron_client_conductor_t *conductor, const char *uri, int32_t stream_id);
```
"""
function aeron_client_conductor_async_add_exclusive_publication(async, conductor, uri, stream_id)
    @ccall libaeron.aeron_client_conductor_async_add_exclusive_publication(async::Ptr{Ptr{aeron_async_add_exclusive_publication_t}}, conductor::Ptr{aeron_client_conductor_t}, uri::Cstring, stream_id::Int32)::Cint
end

"""
    aeron_client_conductor_async_close_exclusive_publication(conductor, publication, on_close_complete, on_close_complete_clientd)

### Prototype
```c
int aeron_client_conductor_async_close_exclusive_publication( aeron_client_conductor_t *conductor, aeron_exclusive_publication_t *publication, aeron_notification_t on_close_complete, void *on_close_complete_clientd);
```
"""
function aeron_client_conductor_async_close_exclusive_publication(conductor, publication, on_close_complete, on_close_complete_clientd)
    @ccall libaeron.aeron_client_conductor_async_close_exclusive_publication(conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_exclusive_publication_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_client_conductor_async_add_subscription(async, conductor, uri, stream_id, on_available_image_handler, on_available_image_clientd, on_unavailable_image_handler, on_unavailable_image_clientd)

### Prototype
```c
int aeron_client_conductor_async_add_subscription( aeron_async_add_subscription_t **async, aeron_client_conductor_t *conductor, const char *uri, int32_t stream_id, aeron_on_available_image_t on_available_image_handler, void *on_available_image_clientd, aeron_on_unavailable_image_t on_unavailable_image_handler, void *on_unavailable_image_clientd);
```
"""
function aeron_client_conductor_async_add_subscription(async, conductor, uri, stream_id, on_available_image_handler, on_available_image_clientd, on_unavailable_image_handler, on_unavailable_image_clientd)
    @ccall libaeron.aeron_client_conductor_async_add_subscription(async::Ptr{Ptr{aeron_async_add_subscription_t}}, conductor::Ptr{aeron_client_conductor_t}, uri::Cstring, stream_id::Int32, on_available_image_handler::aeron_on_available_image_t, on_available_image_clientd::Ptr{Cvoid}, on_unavailable_image_handler::aeron_on_unavailable_image_t, on_unavailable_image_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_client_conductor_async_close_subscription(conductor, subscription, on_close_complete, on_close_complete_clientd)

### Prototype
```c
int aeron_client_conductor_async_close_subscription( aeron_client_conductor_t *conductor, aeron_subscription_t *subscription, aeron_notification_t on_close_complete, void *on_close_complete_clientd);
```
"""
function aeron_client_conductor_async_close_subscription(conductor, subscription, on_close_complete, on_close_complete_clientd)
    @ccall libaeron.aeron_client_conductor_async_close_subscription(conductor::Ptr{aeron_client_conductor_t}, subscription::Ptr{aeron_subscription_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_client_conductor_async_add_counter(async, conductor, type_id, key_buffer, key_buffer_length, label_buffer, label_buffer_length)

### Prototype
```c
int aeron_client_conductor_async_add_counter( aeron_async_add_counter_t **async, aeron_client_conductor_t *conductor, int32_t type_id, const uint8_t *key_buffer, size_t key_buffer_length, const char *label_buffer, size_t label_buffer_length);
```
"""
function aeron_client_conductor_async_add_counter(async, conductor, type_id, key_buffer, key_buffer_length, label_buffer, label_buffer_length)
    @ccall libaeron.aeron_client_conductor_async_add_counter(async::Ptr{Ptr{aeron_async_add_counter_t}}, conductor::Ptr{aeron_client_conductor_t}, type_id::Int32, key_buffer::Ptr{UInt8}, key_buffer_length::Csize_t, label_buffer::Cstring, label_buffer_length::Csize_t)::Cint
end

"""
    aeron_client_conductor_async_close_counter(conductor, counter, on_close_complete, on_close_complete_clientd)

### Prototype
```c
int aeron_client_conductor_async_close_counter( aeron_client_conductor_t *conductor, aeron_counter_t *counter, aeron_notification_t on_close_complete, void *on_close_complete_clientd);
```
"""
function aeron_client_conductor_async_close_counter(conductor, counter, on_close_complete, on_close_complete_clientd)
    @ccall libaeron.aeron_client_conductor_async_close_counter(conductor::Ptr{aeron_client_conductor_t}, counter::Ptr{aeron_counter_t}, on_close_complete::aeron_notification_t, on_close_complete_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_client_conductor_async_add_publication_destination(async, conductor, publication, uri)

### Prototype
```c
int aeron_client_conductor_async_add_publication_destination( aeron_async_destination_t **async, aeron_client_conductor_t *conductor, aeron_publication_t *publication, const char *uri);
```
"""
function aeron_client_conductor_async_add_publication_destination(async, conductor, publication, uri)
    @ccall libaeron.aeron_client_conductor_async_add_publication_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_publication_t}, uri::Cstring)::Cint
end

"""
    aeron_client_conductor_async_remove_publication_destination(async, conductor, publication, uri)

### Prototype
```c
int aeron_client_conductor_async_remove_publication_destination( aeron_async_destination_t **async, aeron_client_conductor_t *conductor, aeron_publication_t *publication, const char *uri);
```
"""
function aeron_client_conductor_async_remove_publication_destination(async, conductor, publication, uri)
    @ccall libaeron.aeron_client_conductor_async_remove_publication_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_publication_t}, uri::Cstring)::Cint
end

"""
    aeron_client_conductor_async_add_exclusive_publication_destination(async, conductor, publication, uri)

### Prototype
```c
int aeron_client_conductor_async_add_exclusive_publication_destination( aeron_async_destination_t **async, aeron_client_conductor_t *conductor, aeron_exclusive_publication_t *publication, const char *uri);
```
"""
function aeron_client_conductor_async_add_exclusive_publication_destination(async, conductor, publication, uri)
    @ccall libaeron.aeron_client_conductor_async_add_exclusive_publication_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_exclusive_publication_t}, uri::Cstring)::Cint
end

"""
    aeron_client_conductor_async_remove_exclusive_publication_destination(async, conductor, publication, uri)

### Prototype
```c
int aeron_client_conductor_async_remove_exclusive_publication_destination( aeron_async_destination_t **async, aeron_client_conductor_t *conductor, aeron_exclusive_publication_t *publication, const char *uri);
```
"""
function aeron_client_conductor_async_remove_exclusive_publication_destination(async, conductor, publication, uri)
    @ccall libaeron.aeron_client_conductor_async_remove_exclusive_publication_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, publication::Ptr{aeron_exclusive_publication_t}, uri::Cstring)::Cint
end

"""
    aeron_client_conductor_async_add_subscription_destination(async, conductor, subscription, uri)

### Prototype
```c
int aeron_client_conductor_async_add_subscription_destination( aeron_async_destination_t **async, aeron_client_conductor_t *conductor, aeron_subscription_t *subscription, const char *uri);
```
"""
function aeron_client_conductor_async_add_subscription_destination(async, conductor, subscription, uri)
    @ccall libaeron.aeron_client_conductor_async_add_subscription_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, subscription::Ptr{aeron_subscription_t}, uri::Cstring)::Cint
end

"""
    aeron_client_conductor_async_remove_subscription_destination(async, conductor, subscription, uri)

### Prototype
```c
int aeron_client_conductor_async_remove_subscription_destination( aeron_async_destination_t **async, aeron_client_conductor_t *conductor, aeron_subscription_t *subscription, const char *uri);
```
"""
function aeron_client_conductor_async_remove_subscription_destination(async, conductor, subscription, uri)
    @ccall libaeron.aeron_client_conductor_async_remove_subscription_destination(async::Ptr{Ptr{aeron_async_destination_t}}, conductor::Ptr{aeron_client_conductor_t}, subscription::Ptr{aeron_subscription_t}, uri::Cstring)::Cint
end

"""
    aeron_client_conductor_async_handler(conductor, cmd)

### Prototype
```c
int aeron_client_conductor_async_handler(aeron_client_conductor_t *conductor, aeron_client_handler_cmd_t *cmd);
```
"""
function aeron_client_conductor_async_handler(conductor, cmd)
    @ccall libaeron.aeron_client_conductor_async_handler(conductor::Ptr{aeron_client_conductor_t}, cmd::Ptr{aeron_client_handler_cmd_t})::Cint
end

"""
    aeron_client_conductor_on_error(conductor, response)

### Prototype
```c
int aeron_client_conductor_on_error(aeron_client_conductor_t *conductor, aeron_error_response_t *response);
```
"""
function aeron_client_conductor_on_error(conductor, response)
    @ccall libaeron.aeron_client_conductor_on_error(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_error_response_t})::Cint
end

"""
    aeron_client_conductor_on_publication_ready(conductor, response)

### Prototype
```c
int aeron_client_conductor_on_publication_ready( aeron_client_conductor_t *conductor, aeron_publication_buffers_ready_t *response);
```
"""
function aeron_client_conductor_on_publication_ready(conductor, response)
    @ccall libaeron.aeron_client_conductor_on_publication_ready(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_publication_buffers_ready_t})::Cint
end

"""
    aeron_client_conductor_on_subscription_ready(conductor, response)

### Prototype
```c
int aeron_client_conductor_on_subscription_ready( aeron_client_conductor_t *conductor, aeron_subscription_ready_t *response);
```
"""
function aeron_client_conductor_on_subscription_ready(conductor, response)
    @ccall libaeron.aeron_client_conductor_on_subscription_ready(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_subscription_ready_t})::Cint
end

"""
    aeron_client_conductor_on_operation_success(conductor, response)

### Prototype
```c
int aeron_client_conductor_on_operation_success( aeron_client_conductor_t *conductor, aeron_operation_succeeded_t *response);
```
"""
function aeron_client_conductor_on_operation_success(conductor, response)
    @ccall libaeron.aeron_client_conductor_on_operation_success(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_operation_succeeded_t})::Cint
end

"""
    aeron_client_conductor_on_available_image(conductor, response, log_file_length, log_file, source_identity_length, source_identity)

### Prototype
```c
int aeron_client_conductor_on_available_image( aeron_client_conductor_t *conductor, aeron_image_buffers_ready_t *response, int32_t log_file_length, const char *log_file, int32_t source_identity_length, const char *source_identity);
```
"""
function aeron_client_conductor_on_available_image(conductor, response, log_file_length, log_file, source_identity_length, source_identity)
    @ccall libaeron.aeron_client_conductor_on_available_image(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_image_buffers_ready_t}, log_file_length::Int32, log_file::Cstring, source_identity_length::Int32, source_identity::Cstring)::Cint
end

"""
    aeron_client_conductor_on_unavailable_image(conductor, response)

### Prototype
```c
int aeron_client_conductor_on_unavailable_image(aeron_client_conductor_t *conductor, aeron_image_message_t *response);
```
"""
function aeron_client_conductor_on_unavailable_image(conductor, response)
    @ccall libaeron.aeron_client_conductor_on_unavailable_image(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_image_message_t})::Cint
end

"""
    aeron_client_conductor_on_counter_ready(conductor, response)

### Prototype
```c
int aeron_client_conductor_on_counter_ready(aeron_client_conductor_t *conductor, aeron_counter_update_t *response);
```
"""
function aeron_client_conductor_on_counter_ready(conductor, response)
    @ccall libaeron.aeron_client_conductor_on_counter_ready(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_counter_update_t})::Cint
end

"""
    aeron_client_conductor_on_unavailable_counter(conductor, response)

### Prototype
```c
int aeron_client_conductor_on_unavailable_counter( aeron_client_conductor_t *conductor, aeron_counter_update_t *response);
```
"""
function aeron_client_conductor_on_unavailable_counter(conductor, response)
    @ccall libaeron.aeron_client_conductor_on_unavailable_counter(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_counter_update_t})::Cint
end

"""
    aeron_client_conductor_on_client_timeout(conductor, response)

### Prototype
```c
int aeron_client_conductor_on_client_timeout(aeron_client_conductor_t *conductor, aeron_client_timeout_t *response);
```
"""
function aeron_client_conductor_on_client_timeout(conductor, response)
    @ccall libaeron.aeron_client_conductor_on_client_timeout(conductor::Ptr{aeron_client_conductor_t}, response::Ptr{aeron_client_timeout_t})::Cint
end

"""
    aeron_client_conductor_get_or_create_log_buffer(conductor, log_buffer, log_file, original_registration_id, pre_touch)

### Prototype
```c
int aeron_client_conductor_get_or_create_log_buffer( aeron_client_conductor_t *conductor, aeron_log_buffer_t **log_buffer, const char *log_file, int64_t original_registration_id, bool pre_touch);
```
"""
function aeron_client_conductor_get_or_create_log_buffer(conductor, log_buffer, log_file, original_registration_id, pre_touch)
    @ccall libaeron.aeron_client_conductor_get_or_create_log_buffer(conductor::Ptr{aeron_client_conductor_t}, log_buffer::Ptr{Ptr{aeron_log_buffer_t}}, log_file::Cstring, original_registration_id::Int64, pre_touch::Bool)::Cint
end

"""
    aeron_client_conductor_release_log_buffer(conductor, log_buffer)

### Prototype
```c
int aeron_client_conductor_release_log_buffer(aeron_client_conductor_t *conductor, aeron_log_buffer_t *log_buffer);
```
"""
function aeron_client_conductor_release_log_buffer(conductor, log_buffer)
    @ccall libaeron.aeron_client_conductor_release_log_buffer(conductor::Ptr{aeron_client_conductor_t}, log_buffer::Ptr{aeron_log_buffer_t})::Cint
end

"""
    aeron_client_conductor_linger_image(conductor, image)

### Prototype
```c
int aeron_client_conductor_linger_image(aeron_client_conductor_t *conductor, aeron_image_t *image);
```
"""
function aeron_client_conductor_linger_image(conductor, image)
    @ccall libaeron.aeron_client_conductor_linger_image(conductor::Ptr{aeron_client_conductor_t}, image::Ptr{aeron_image_t})::Cint
end

"""
    aeron_client_conductor_offer_remove_command(conductor, registration_id, command_type)

### Prototype
```c
int aeron_client_conductor_offer_remove_command( aeron_client_conductor_t *conductor, int64_t registration_id, int32_t command_type);
```
"""
function aeron_client_conductor_offer_remove_command(conductor, registration_id, command_type)
    @ccall libaeron.aeron_client_conductor_offer_remove_command(conductor::Ptr{aeron_client_conductor_t}, registration_id::Int64, command_type::Int32)::Cint
end

"""
    aeron_client_conductor_offer_destination_command(conductor, registration_id, command_type, uri, correlation_id)

### Prototype
```c
int aeron_client_conductor_offer_destination_command( aeron_client_conductor_t *conductor, int64_t registration_id, int32_t command_type, const char *uri, int64_t *correlation_id);
```
"""
function aeron_client_conductor_offer_destination_command(conductor, registration_id, command_type, uri, correlation_id)
    @ccall libaeron.aeron_client_conductor_offer_destination_command(conductor::Ptr{aeron_client_conductor_t}, registration_id::Int64, command_type::Int32, uri::Cstring, correlation_id::Ptr{Int64})::Cint
end

"""
    aeron_counter_heartbeat_timestamp_find_counter_id_by_registration_id(counters_reader, type_id, registration_id)

### Prototype
```c
inline int aeron_counter_heartbeat_timestamp_find_counter_id_by_registration_id( aeron_counters_reader_t *counters_reader, int32_t type_id, int64_t registration_id);
```
"""
function aeron_counter_heartbeat_timestamp_find_counter_id_by_registration_id(counters_reader, type_id, registration_id)
    @ccall libaeron.aeron_counter_heartbeat_timestamp_find_counter_id_by_registration_id(counters_reader::Ptr{aeron_counters_reader_t}, type_id::Int32, registration_id::Int64)::Cint
end

"""
    aeron_counter_heartbeat_timestamp_is_active(counters_reader, counter_id, type_id, registration_id)

### Prototype
```c
inline bool aeron_counter_heartbeat_timestamp_is_active( aeron_counters_reader_t *counters_reader, int32_t counter_id, int32_t type_id, int64_t registration_id);
```
"""
function aeron_counter_heartbeat_timestamp_is_active(counters_reader, counter_id, type_id, registration_id)
    @ccall libaeron.aeron_counter_heartbeat_timestamp_is_active(counters_reader::Ptr{aeron_counters_reader_t}, counter_id::Int32, type_id::Int32, registration_id::Int64)::Bool
end

"""
    aeron_client_conductor_notify_close_handlers(conductor)

### Prototype
```c
inline void aeron_client_conductor_notify_close_handlers(aeron_client_conductor_t *conductor);
```
"""
function aeron_client_conductor_notify_close_handlers(conductor)
    @ccall libaeron.aeron_client_conductor_notify_close_handlers(conductor::Ptr{aeron_client_conductor_t})::Cvoid
end

"""
    aeron_client_conductor_is_closed(conductor)

### Prototype
```c
inline bool aeron_client_conductor_is_closed(aeron_client_conductor_t *conductor);
```
"""
function aeron_client_conductor_is_closed(conductor)
    @ccall libaeron.aeron_client_conductor_is_closed(conductor::Ptr{aeron_client_conductor_t})::Bool
end

"""
    aeron_subscription_create(subscription, conductor, channel, stream_id, registration_id, channel_status_indicator_id, channel_status_indicator_addr, on_available_image, on_available_image_clientd, on_unavailable_image, on_unavailable_image_clientd)

### Prototype
```c
int aeron_subscription_create( aeron_subscription_t **subscription, aeron_client_conductor_t *conductor, const char *channel, int32_t stream_id, int64_t registration_id, int32_t channel_status_indicator_id, int64_t *channel_status_indicator_addr, aeron_on_available_image_t on_available_image, void *on_available_image_clientd, aeron_on_unavailable_image_t on_unavailable_image, void *on_unavailable_image_clientd);
```
"""
function aeron_subscription_create(subscription, conductor, channel, stream_id, registration_id, channel_status_indicator_id, channel_status_indicator_addr, on_available_image, on_available_image_clientd, on_unavailable_image, on_unavailable_image_clientd)
    @ccall libaeron.aeron_subscription_create(subscription::Ptr{Ptr{aeron_subscription_t}}, conductor::Ptr{aeron_client_conductor_t}, channel::Cstring, stream_id::Int32, registration_id::Int64, channel_status_indicator_id::Int32, channel_status_indicator_addr::Ptr{Int64}, on_available_image::aeron_on_available_image_t, on_available_image_clientd::Ptr{Cvoid}, on_unavailable_image::aeron_on_unavailable_image_t, on_unavailable_image_clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_subscription_delete(subscription)

### Prototype
```c
int aeron_subscription_delete(aeron_subscription_t *subscription);
```
"""
function aeron_subscription_delete(subscription)
    @ccall libaeron.aeron_subscription_delete(subscription::Ptr{aeron_subscription_t})::Cint
end

"""
    aeron_subscription_force_close(subscription)

### Prototype
```c
void aeron_subscription_force_close(aeron_subscription_t *subscription);
```
"""
function aeron_subscription_force_close(subscription)
    @ccall libaeron.aeron_subscription_force_close(subscription::Ptr{aeron_subscription_t})::Cvoid
end

"""
    aeron_subscription_alloc_image_list(image_list, length)

### Prototype
```c
int aeron_subscription_alloc_image_list(volatile aeron_image_list_t **image_list, size_t length);
```
"""
function aeron_subscription_alloc_image_list(image_list, length)
    @ccall libaeron.aeron_subscription_alloc_image_list(image_list::Ptr{Ptr{aeron_image_list_t}}, length::Csize_t)::Cint
end

"""
    aeron_client_conductor_subscription_add_image(subscription, image)

### Prototype
```c
int aeron_client_conductor_subscription_add_image(aeron_subscription_t *subscription, aeron_image_t *image);
```
"""
function aeron_client_conductor_subscription_add_image(subscription, image)
    @ccall libaeron.aeron_client_conductor_subscription_add_image(subscription::Ptr{aeron_subscription_t}, image::Ptr{aeron_image_t})::Cint
end

"""
    aeron_client_conductor_subscription_remove_image(subscription, image)

### Prototype
```c
int aeron_client_conductor_subscription_remove_image(aeron_subscription_t *subscription, aeron_image_t *image);
```
"""
function aeron_client_conductor_subscription_remove_image(subscription, image)
    @ccall libaeron.aeron_client_conductor_subscription_remove_image(subscription::Ptr{aeron_subscription_t}, image::Ptr{aeron_image_t})::Cint
end

"""
    aeron_client_conductor_subscription_image_list(subscription)

### Prototype
```c
inline volatile aeron_image_list_t *aeron_client_conductor_subscription_image_list(aeron_subscription_t *subscription);
```
"""
function aeron_client_conductor_subscription_image_list(subscription)
    @ccall libaeron.aeron_client_conductor_subscription_image_list(subscription::Ptr{aeron_subscription_t})::Ptr{aeron_image_list_t}
end

"""
    aeron_client_conductor_subscription_install_new_image_list(subscription, image_list)

### Prototype
```c
int aeron_client_conductor_subscription_install_new_image_list( aeron_subscription_t *subscription, volatile aeron_image_list_t *image_list);
```
"""
function aeron_client_conductor_subscription_install_new_image_list(subscription, image_list)
    @ccall libaeron.aeron_client_conductor_subscription_install_new_image_list(subscription::Ptr{aeron_subscription_t}, image_list::Ptr{aeron_image_list_t})::Cint
end

"""
    aeron_client_conductor_subscription_prune_image_lists(subscription)

### Prototype
```c
int aeron_client_conductor_subscription_prune_image_lists(aeron_subscription_t *subscription);
```
"""
function aeron_client_conductor_subscription_prune_image_lists(subscription)
    @ccall libaeron.aeron_client_conductor_subscription_prune_image_lists(subscription::Ptr{aeron_subscription_t})::Cint
end

"""
    aeron_subscription_find_image_index(image_list, image)

### Prototype
```c
inline int aeron_subscription_find_image_index(volatile aeron_image_list_t *image_list, aeron_image_t *image);
```
"""
function aeron_subscription_find_image_index(image_list, image)
    @ccall libaeron.aeron_subscription_find_image_index(image_list::Ptr{aeron_image_list_t}, image::Ptr{aeron_image_t})::Cint
end

"""
    aeron_subscription_last_image_list_change_number(subscription)

### Prototype
```c
inline int64_t aeron_subscription_last_image_list_change_number(aeron_subscription_t *subscription);
```
"""
function aeron_subscription_last_image_list_change_number(subscription)
    @ccall libaeron.aeron_subscription_last_image_list_change_number(subscription::Ptr{aeron_subscription_t})::Int64
end

"""
    aeron_subscription_propose_last_image_change_number(subscription, change_number)

### Prototype
```c
inline void aeron_subscription_propose_last_image_change_number( aeron_subscription_t *subscription, int64_t change_number);
```
"""
function aeron_subscription_propose_last_image_change_number(subscription, change_number)
    @ccall libaeron.aeron_subscription_propose_last_image_change_number(subscription::Ptr{aeron_subscription_t}, change_number::Int64)::Cvoid
end

"""
    aeron_format_date(str, count, timestamp)

### Prototype
```c
void aeron_format_date(char *str, size_t count, int64_t timestamp);
```
"""
function aeron_format_date(str, count, timestamp)
    @ccall libaeron.aeron_format_date(str::Cstring, count::Csize_t, timestamp::Int64)::Cvoid
end

"""
    aeron_format_number_to_locale(value, buffer, buffer_len)

### Prototype
```c
char *aeron_format_number_to_locale(long long value, char *buffer, size_t buffer_len);
```
"""
function aeron_format_number_to_locale(value, buffer, buffer_len)
    @ccall libaeron.aeron_format_number_to_locale(value::Clonglong, buffer::Cstring, buffer_len::Csize_t)::Cstring
end

"""
    aeron_format_to_hex(str, str_length, data, data_len)

### Prototype
```c
void aeron_format_to_hex(char *str, size_t str_length, uint8_t *data, size_t data_len);
```
"""
function aeron_format_to_hex(str, str_length, data, data_len)
    @ccall libaeron.aeron_format_to_hex(str::Cstring, str_length::Csize_t, data::Ptr{UInt8}, data_len::Csize_t)::Cvoid
end

"""
    aeron_fnv_64a_buf(buf, len)

### Prototype
```c
inline uint64_t aeron_fnv_64a_buf(uint8_t *buf, size_t len);
```
"""
function aeron_fnv_64a_buf(buf, len)
    @ccall libaeron.aeron_fnv_64a_buf(buf::Ptr{UInt8}, len::Csize_t)::UInt64
end

"""
    aeron_tokenise(input, delimiter, max_tokens, tokens)

### Prototype
```c
int aeron_tokenise(char *input, char delimiter, int max_tokens, char **tokens);
```
"""
function aeron_tokenise(input, delimiter, max_tokens, tokens)
    @ccall libaeron.aeron_tokenise(input::Cstring, delimiter::Cchar, max_tokens::Cint, tokens::Ptr{Cstring})::Cint
end

"""
    aeron_str_length(str, length_bound, length)

Checks that the string length is strictly less than the specified bound.

### Parameters
* `str`: String to be compared.
* `length_bound`: Limit to the length of the string being checked.
* `length`: Out parameter for the actual length of the string (if non-null and less than length\\_bound). NULL values for this parameter are permitted. If str is NULL this value is unmodified. If the function returns false, the value is also unmodified.
### Returns
true if less than the specified bound, NULL is always true.
### Prototype
```c
inline bool aeron_str_length(const char *str, size_t length_bound, size_t *length);
```
"""
function aeron_str_length(str, length_bound, length)
    @ccall libaeron.aeron_str_length(str::Cstring, length_bound::Csize_t, length::Ptr{Csize_t})::Bool
end

struct aeron_array_to_ptr_hash_map_key_stct
    arr::Ptr{UInt8}
    hash_code::UInt64
    arr_length::Csize_t
end

const aeron_array_to_ptr_hash_map_key_t = aeron_array_to_ptr_hash_map_key_stct

mutable struct aeron_array_to_ptr_hash_map_stct
    keys::Ptr{aeron_array_to_ptr_hash_map_key_t}
    values::Ptr{Ptr{Cvoid}}
    load_factor::Cfloat
    capacity::Csize_t
    size::Csize_t
    resize_threshold::Csize_t
    aeron_array_to_ptr_hash_map_stct() = new()
end

const aeron_array_to_ptr_hash_map_t = aeron_array_to_ptr_hash_map_stct

"""
    aeron_array_hash(arr, length)

### Prototype
```c
inline uint64_t aeron_array_hash(const uint8_t *arr, size_t length);
```
"""
function aeron_array_hash(arr, length)
    @ccall libaeron.aeron_array_hash(arr::Ptr{UInt8}, length::Csize_t)::UInt64
end

"""
    aeron_array_to_ptr_hash_map_hash_key(key_hash_code, mask)

### Prototype
```c
inline size_t aeron_array_to_ptr_hash_map_hash_key(uint64_t key_hash_code, size_t mask);
```
"""
function aeron_array_to_ptr_hash_map_hash_key(key_hash_code, mask)
    @ccall libaeron.aeron_array_to_ptr_hash_map_hash_key(key_hash_code::UInt64, mask::Csize_t)::Csize_t
end

"""
    aeron_array_to_ptr_hash_map_compare(key, key_arr, key_arr_len, key_hash_code)

### Prototype
```c
inline bool aeron_array_to_ptr_hash_map_compare( aeron_array_to_ptr_hash_map_key_t *key, const uint8_t *key_arr, size_t key_arr_len, uint64_t key_hash_code);
```
"""
function aeron_array_to_ptr_hash_map_compare(key, key_arr, key_arr_len, key_hash_code)
    @ccall libaeron.aeron_array_to_ptr_hash_map_compare(key::Ptr{aeron_array_to_ptr_hash_map_key_t}, key_arr::Ptr{UInt8}, key_arr_len::Csize_t, key_hash_code::UInt64)::Bool
end

"""
    aeron_array_to_ptr_hash_map_init(map, initial_capacity, load_factor)

### Prototype
```c
inline int aeron_array_to_ptr_hash_map_init( aeron_array_to_ptr_hash_map_t *map, size_t initial_capacity, float load_factor);
```
"""
function aeron_array_to_ptr_hash_map_init(map, initial_capacity, load_factor)
    @ccall libaeron.aeron_array_to_ptr_hash_map_init(map::Ptr{aeron_array_to_ptr_hash_map_t}, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

"""
    aeron_array_to_ptr_hash_map_delete(map)

### Prototype
```c
inline void aeron_array_to_ptr_hash_map_delete(aeron_array_to_ptr_hash_map_t *map);
```
"""
function aeron_array_to_ptr_hash_map_delete(map)
    @ccall libaeron.aeron_array_to_ptr_hash_map_delete(map::Ptr{aeron_array_to_ptr_hash_map_t})::Cvoid
end

"""
    aeron_array_to_ptr_hash_map_rehash(map, new_capacity)

### Prototype
```c
inline int aeron_array_to_ptr_hash_map_rehash(aeron_array_to_ptr_hash_map_t *map, size_t new_capacity);
```
"""
function aeron_array_to_ptr_hash_map_rehash(map, new_capacity)
    @ccall libaeron.aeron_array_to_ptr_hash_map_rehash(map::Ptr{aeron_array_to_ptr_hash_map_t}, new_capacity::Csize_t)::Cint
end

"""
    aeron_array_to_ptr_hash_map_put(map, key, key_len, value)

### Prototype
```c
inline int aeron_array_to_ptr_hash_map_put( aeron_array_to_ptr_hash_map_t *map, const uint8_t *key, size_t key_len, void *value);
```
"""
function aeron_array_to_ptr_hash_map_put(map, key, key_len, value)
    @ccall libaeron.aeron_array_to_ptr_hash_map_put(map::Ptr{aeron_array_to_ptr_hash_map_t}, key::Ptr{UInt8}, key_len::Csize_t, value::Ptr{Cvoid})::Cint
end

"""
    aeron_array_to_ptr_hash_map_get(map, key, key_len)

### Prototype
```c
inline void *aeron_array_to_ptr_hash_map_get(aeron_array_to_ptr_hash_map_t *map, const uint8_t *key, size_t key_len);
```
"""
function aeron_array_to_ptr_hash_map_get(map, key, key_len)
    @ccall libaeron.aeron_array_to_ptr_hash_map_get(map::Ptr{aeron_array_to_ptr_hash_map_t}, key::Ptr{UInt8}, key_len::Csize_t)::Ptr{Cvoid}
end

"""
    aeron_array_to_ptr_hash_map_compact_chain(map, delete_index)

### Prototype
```c
inline void aeron_array_to_ptr_hash_map_compact_chain(aeron_array_to_ptr_hash_map_t *map, size_t delete_index);
```
"""
function aeron_array_to_ptr_hash_map_compact_chain(map, delete_index)
    @ccall libaeron.aeron_array_to_ptr_hash_map_compact_chain(map::Ptr{aeron_array_to_ptr_hash_map_t}, delete_index::Csize_t)::Cvoid
end

"""
    aeron_array_to_ptr_hash_map_remove(map, key, key_len)

### Prototype
```c
inline void *aeron_array_to_ptr_hash_map_remove(aeron_array_to_ptr_hash_map_t *map, const uint8_t *key, size_t key_len);
```
"""
function aeron_array_to_ptr_hash_map_remove(map, key, key_len)
    @ccall libaeron.aeron_array_to_ptr_hash_map_remove(map::Ptr{aeron_array_to_ptr_hash_map_t}, key::Ptr{UInt8}, key_len::Csize_t)::Ptr{Cvoid}
end

# typedef void ( * aeron_array_to_ptr_hash_map_for_each_func_t ) ( void * clientd , const uint8_t * key , size_t key_len , void * value )
const aeron_array_to_ptr_hash_map_for_each_func_t = Ptr{Cvoid}

"""
    aeron_array_to_ptr_hash_map_for_each(map, func, clientd)

### Prototype
```c
inline void aeron_array_to_ptr_hash_map_for_each( aeron_array_to_ptr_hash_map_t *map, aeron_array_to_ptr_hash_map_for_each_func_t func, void *clientd);
```
"""
function aeron_array_to_ptr_hash_map_for_each(map, func, clientd)
    @ccall libaeron.aeron_array_to_ptr_hash_map_for_each(map::Ptr{aeron_array_to_ptr_hash_map_t}, func::aeron_array_to_ptr_hash_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

@cenum aeron_term_unblocker_status_enum::UInt32 begin
    AERON_TERM_UNBLOCKER_STATUS_NO_ACTION = 0
    AERON_TERM_UNBLOCKER_STATUS_UNBLOCKED = 1
    AERON_TERM_UNBLOCKER_STATUS_UNBLOCKED_TO_END = 2
end

const aeron_term_unblocker_status_t = aeron_term_unblocker_status_enum

"""
    aeron_term_unblocker_unblock(log_meta_data, buffer, term_length, blocked_offset, tail_offset, term_id)

### Prototype
```c
aeron_term_unblocker_status_t aeron_term_unblocker_unblock( aeron_logbuffer_metadata_t *log_meta_data, uint8_t *buffer, size_t term_length, int32_t blocked_offset, int32_t tail_offset, int32_t term_id);
```
"""
function aeron_term_unblocker_unblock(log_meta_data, buffer, term_length, blocked_offset, tail_offset, term_id)
    @ccall libaeron.aeron_term_unblocker_unblock(log_meta_data::Ptr{aeron_logbuffer_metadata_t}, buffer::Ptr{UInt8}, term_length::Csize_t, blocked_offset::Int32, tail_offset::Int32, term_id::Int32)::aeron_term_unblocker_status_t
end

"""
    aeron_env_set(key, val)

### Prototype
```c
int aeron_env_set(const char *key, const char *val);
```
"""
function aeron_env_set(key, val)
    @ccall libaeron.aeron_env_set(key::Cstring, val::Cstring)::Cint
end

"""
    aeron_env_unset(key)

### Prototype
```c
int aeron_env_unset(const char *key);
```
"""
function aeron_env_unset(key)
    @ccall libaeron.aeron_env_unset(key::Cstring)::Cint
end

mutable struct var"##Ctag#2339"
    tail::UInt64
    head_cache::UInt64
    padding::NTuple{48, Int8}
    var"##Ctag#2339"() = new()
end
function Base.getproperty(x::Ptr{var"##Ctag#2339"}, f::Symbol)
    f === :tail && return Ptr{UInt64}(x + 0)
    f === :head_cache && return Ptr{UInt64}(x + 8)
    f === :padding && return Ptr{NTuple{48, Int8}}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#2339", f::Symbol)
    r = Ref{var"##Ctag#2339"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#2339"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#2339"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct aeron_spsc_concurrent_array_queue_stct
    data::NTuple{208, UInt8}
end

function Base.getproperty(x::Ptr{aeron_spsc_concurrent_array_queue_stct}, f::Symbol)
    f === :padding && return Ptr{NTuple{56, Int8}}(x + 0)
    f === :producer && return Ptr{var"##Ctag#2339"}(x + 56)
    f === :consumer && return Ptr{var"##Ctag#2340"}(x + 120)
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

"""
    aeron_spsc_concurrent_array_queue_init(queue, length)

### Prototype
```c
int aeron_spsc_concurrent_array_queue_init(aeron_spsc_concurrent_array_queue_t *queue, size_t length);
```
"""
function aeron_spsc_concurrent_array_queue_init(queue, length)
    @ccall libaeron.aeron_spsc_concurrent_array_queue_init(queue::Ptr{aeron_spsc_concurrent_array_queue_t}, length::Csize_t)::Cint
end

"""
    aeron_spsc_concurrent_array_queue_close(queue)

### Prototype
```c
int aeron_spsc_concurrent_array_queue_close(aeron_spsc_concurrent_array_queue_t *queue);
```
"""
function aeron_spsc_concurrent_array_queue_close(queue)
    @ccall libaeron.aeron_spsc_concurrent_array_queue_close(queue::Ptr{aeron_spsc_concurrent_array_queue_t})::Cint
end

"""
    aeron_spsc_concurrent_array_queue_offer(queue, element)

### Prototype
```c
inline aeron_queue_offer_result_t aeron_spsc_concurrent_array_queue_offer( aeron_spsc_concurrent_array_queue_t *queue, void *element);
```
"""
function aeron_spsc_concurrent_array_queue_offer(queue, element)
    @ccall libaeron.aeron_spsc_concurrent_array_queue_offer(queue::Ptr{aeron_spsc_concurrent_array_queue_t}, element::Ptr{Cvoid})::aeron_queue_offer_result_t
end

"""
    aeron_spsc_concurrent_array_queue_poll(queue)

### Prototype
```c
inline void *aeron_spsc_concurrent_array_queue_poll(aeron_spsc_concurrent_array_queue_t *queue);
```
"""
function aeron_spsc_concurrent_array_queue_poll(queue)
    @ccall libaeron.aeron_spsc_concurrent_array_queue_poll(queue::Ptr{aeron_spsc_concurrent_array_queue_t})::Ptr{Cvoid}
end

"""
    aeron_spsc_concurrent_array_queue_drain(queue, func, clientd, limit)

### Prototype
```c
inline size_t aeron_spsc_concurrent_array_queue_drain( aeron_spsc_concurrent_array_queue_t *queue, aeron_queue_drain_func_t func, void *clientd, size_t limit);
```
"""
function aeron_spsc_concurrent_array_queue_drain(queue, func, clientd, limit)
    @ccall libaeron.aeron_spsc_concurrent_array_queue_drain(queue::Ptr{aeron_spsc_concurrent_array_queue_t}, func::aeron_queue_drain_func_t, clientd::Ptr{Cvoid}, limit::Csize_t)::Csize_t
end

"""
    aeron_spsc_concurrent_array_queue_drain_all(queue, func, clientd)

### Prototype
```c
inline size_t aeron_spsc_concurrent_array_queue_drain_all( aeron_spsc_concurrent_array_queue_t *queue, aeron_queue_drain_func_t func, void *clientd);
```
"""
function aeron_spsc_concurrent_array_queue_drain_all(queue, func, clientd)
    @ccall libaeron.aeron_spsc_concurrent_array_queue_drain_all(queue::Ptr{aeron_spsc_concurrent_array_queue_t}, func::aeron_queue_drain_func_t, clientd::Ptr{Cvoid})::Csize_t
end

"""
    aeron_spsc_concurrent_array_queue_size(queue)

### Prototype
```c
inline size_t aeron_spsc_concurrent_array_queue_size(aeron_spsc_concurrent_array_queue_t *queue);
```
"""
function aeron_spsc_concurrent_array_queue_size(queue)
    @ccall libaeron.aeron_spsc_concurrent_array_queue_size(queue::Ptr{aeron_spsc_concurrent_array_queue_t})::Csize_t
end

mutable struct aeron_broadcast_transmitter_stct
    buffer::Ptr{UInt8}
    descriptor::Ptr{aeron_broadcast_descriptor_t}
    capacity::Csize_t
    max_message_length::Csize_t
    aeron_broadcast_transmitter_stct() = new()
end

const aeron_broadcast_transmitter_t = aeron_broadcast_transmitter_stct

"""
    aeron_broadcast_transmitter_init(transmitter, buffer, length)

### Prototype
```c
int aeron_broadcast_transmitter_init(aeron_broadcast_transmitter_t *transmitter, void *buffer, size_t length);
```
"""
function aeron_broadcast_transmitter_init(transmitter, buffer, length)
    @ccall libaeron.aeron_broadcast_transmitter_init(transmitter::Ptr{aeron_broadcast_transmitter_t}, buffer::Ptr{Cvoid}, length::Csize_t)::Cint
end

"""
    aeron_broadcast_transmitter_transmit(transmitter, msg_type_id, msg, length)

### Prototype
```c
int aeron_broadcast_transmitter_transmit( aeron_broadcast_transmitter_t *transmitter, int32_t msg_type_id, const void *msg, size_t length);
```
"""
function aeron_broadcast_transmitter_transmit(transmitter, msg_type_id, msg, length)
    @ccall libaeron.aeron_broadcast_transmitter_transmit(transmitter::Ptr{aeron_broadcast_transmitter_t}, msg_type_id::Int32, msg::Ptr{Cvoid}, length::Csize_t)::Cint
end

"""
    aeron_exclusive_publication_create(publication, conductor, channel, stream_id, session_id, position_limit_counter_id, position_limit_addr, channel_status_indicator_id, channel_status_addr, log_buffer, original_registration_id, registration_id)

### Prototype
```c
int aeron_exclusive_publication_create( aeron_exclusive_publication_t **publication, aeron_client_conductor_t *conductor, const char *channel, int32_t stream_id, int32_t session_id, int32_t position_limit_counter_id, int64_t *position_limit_addr, int32_t channel_status_indicator_id, int64_t *channel_status_addr, aeron_log_buffer_t *log_buffer, int64_t original_registration_id, int64_t registration_id);
```
"""
function aeron_exclusive_publication_create(publication, conductor, channel, stream_id, session_id, position_limit_counter_id, position_limit_addr, channel_status_indicator_id, channel_status_addr, log_buffer, original_registration_id, registration_id)
    @ccall libaeron.aeron_exclusive_publication_create(publication::Ptr{Ptr{aeron_exclusive_publication_t}}, conductor::Ptr{aeron_client_conductor_t}, channel::Cstring, stream_id::Int32, session_id::Int32, position_limit_counter_id::Int32, position_limit_addr::Ptr{Int64}, channel_status_indicator_id::Int32, channel_status_addr::Ptr{Int64}, log_buffer::Ptr{aeron_log_buffer_t}, original_registration_id::Int64, registration_id::Int64)::Cint
end

"""
    aeron_exclusive_publication_delete(publication)

### Prototype
```c
int aeron_exclusive_publication_delete(aeron_exclusive_publication_t *publication);
```
"""
function aeron_exclusive_publication_delete(publication)
    @ccall libaeron.aeron_exclusive_publication_delete(publication::Ptr{aeron_exclusive_publication_t})::Cint
end

"""
    aeron_exclusive_publication_force_close(publication)

### Prototype
```c
void aeron_exclusive_publication_force_close(aeron_exclusive_publication_t *publication);
```
"""
function aeron_exclusive_publication_force_close(publication)
    @ccall libaeron.aeron_exclusive_publication_force_close(publication::Ptr{aeron_exclusive_publication_t})::Cvoid
end

"""
    aeron_exclusive_publication_rotate_term(publication)

### Prototype
```c
inline void aeron_exclusive_publication_rotate_term(aeron_exclusive_publication_t *publication);
```
"""
function aeron_exclusive_publication_rotate_term(publication)
    @ccall libaeron.aeron_exclusive_publication_rotate_term(publication::Ptr{aeron_exclusive_publication_t})::Cvoid
end

"""
    aeron_exclusive_publication_new_position(publication, resulting_offset)

### Prototype
```c
inline int64_t aeron_exclusive_publication_new_position( aeron_exclusive_publication_t *publication, int32_t resulting_offset);
```
"""
function aeron_exclusive_publication_new_position(publication, resulting_offset)
    @ccall libaeron.aeron_exclusive_publication_new_position(publication::Ptr{aeron_exclusive_publication_t}, resulting_offset::Int32)::Int64
end

"""
    aeron_exclusive_publication_back_pressure_status(publication, current_position, message_length)

### Prototype
```c
inline int64_t aeron_exclusive_publication_back_pressure_status( aeron_exclusive_publication_t *publication, int64_t current_position, int32_t message_length);
```
"""
function aeron_exclusive_publication_back_pressure_status(publication, current_position, message_length)
    @ccall libaeron.aeron_exclusive_publication_back_pressure_status(publication::Ptr{aeron_exclusive_publication_t}, current_position::Int64, message_length::Int32)::Int64
end

const aeron_socket_t = Cint

"""
    aeron_set_socket_non_blocking(fd)

### Prototype
```c
int aeron_set_socket_non_blocking(aeron_socket_t fd);
```
"""
function aeron_set_socket_non_blocking(fd)
    @ccall libaeron.aeron_set_socket_non_blocking(fd::aeron_socket_t)::Cint
end

"""
    aeron_socket(domain, type, protocol)

### Prototype
```c
aeron_socket_t aeron_socket(int domain, int type, int protocol);
```
"""
function aeron_socket(domain, type, protocol)
    @ccall libaeron.aeron_socket(domain::Cint, type::Cint, protocol::Cint)::aeron_socket_t
end

"""
    aeron_close_socket(socket)

### Prototype
```c
void aeron_close_socket(aeron_socket_t socket);
```
"""
function aeron_close_socket(socket)
    @ccall libaeron.aeron_close_socket(socket::aeron_socket_t)::Cvoid
end

"""
    aeron_connect(fd, address, address_length)

### Prototype
```c
int aeron_connect(aeron_socket_t fd, struct sockaddr *address, socklen_t address_length);
```
"""
function aeron_connect(fd, address, address_length)
    @ccall libaeron.aeron_connect(fd::aeron_socket_t, address::Ptr{sockaddr}, address_length::socklen_t)::Cint
end

"""
    aeron_bind(fd, address, address_length)

### Prototype
```c
int aeron_bind(aeron_socket_t fd, struct sockaddr *address, socklen_t address_length);
```
"""
function aeron_bind(fd, address, address_length)
    @ccall libaeron.aeron_bind(fd::aeron_socket_t, address::Ptr{sockaddr}, address_length::socklen_t)::Cint
end

"""
    aeron_net_init()

### Prototype
```c
int aeron_net_init(void);
```
"""
function aeron_net_init()
    @ccall libaeron.aeron_net_init()::Cint
end

"""
    aeron_getsockopt(fd, level, optname, optval, optlen)

### Prototype
```c
int aeron_getsockopt(aeron_socket_t fd, int level, int optname, void *optval, socklen_t *optlen);
```
"""
function aeron_getsockopt(fd, level, optname, optval, optlen)
    @ccall libaeron.aeron_getsockopt(fd::aeron_socket_t, level::Cint, optname::Cint, optval::Ptr{Cvoid}, optlen::Ptr{socklen_t})::Cint
end

"""
    aeron_setsockopt(fd, level, optname, optval, optlen)

### Prototype
```c
int aeron_setsockopt(aeron_socket_t fd, int level, int optname, const void *optval, socklen_t optlen);
```
"""
function aeron_setsockopt(fd, level, optname, optval, optlen)
    @ccall libaeron.aeron_setsockopt(fd::aeron_socket_t, level::Cint, optname::Cint, optval::Ptr{Cvoid}, optlen::socklen_t)::Cint
end

"""
    aeron_getifaddrs(ifap)

### Prototype
```c
int aeron_getifaddrs(struct ifaddrs **ifap);
```
"""
function aeron_getifaddrs(ifap)
    @ccall libaeron.aeron_getifaddrs(ifap::Ptr{Ptr{ifaddrs}})::Cint
end

"""
    aeron_freeifaddrs(ifa)

### Prototype
```c
void aeron_freeifaddrs(struct ifaddrs *ifa);
```
"""
function aeron_freeifaddrs(ifa)
    @ccall libaeron.aeron_freeifaddrs(ifa::Ptr{ifaddrs})::Cvoid
end

"""
    aeron_sendmsg(fd, msghdr, flags)

### Prototype
```c
ssize_t aeron_sendmsg(aeron_socket_t fd, struct msghdr *msghdr, int flags);
```
"""
function aeron_sendmsg(fd, msghdr, flags)
    @ccall libaeron.aeron_sendmsg(fd::aeron_socket_t, msghdr::Ptr{Cvoid}, flags::Cint)::Cssize_t
end

"""
    aeron_send(fd, buf, len, flags)

### Prototype
```c
ssize_t aeron_send(aeron_socket_t fd, const void *buf, size_t len, int flags);
```
"""
function aeron_send(fd, buf, len, flags)
    @ccall libaeron.aeron_send(fd::aeron_socket_t, buf::Ptr{Cvoid}, len::Csize_t, flags::Cint)::Cssize_t
end

"""
    aeron_recvmsg(fd, msghdr, flags)

### Prototype
```c
ssize_t aeron_recvmsg(aeron_socket_t fd, struct msghdr *msghdr, int flags);
```
"""
function aeron_recvmsg(fd, msghdr, flags)
    @ccall libaeron.aeron_recvmsg(fd::aeron_socket_t, msghdr::Ptr{Cvoid}, flags::Cint)::Cssize_t
end

"""
    aeron_poll(fds, nfds, timeout)

### Prototype
```c
int aeron_poll(struct pollfd *fds, unsigned long nfds, int timeout);
```
"""
function aeron_poll(fds, nfds, timeout)
    @ccall libaeron.aeron_poll(fds::Ptr{Cvoid}, nfds::Culong, timeout::Cint)::Cint
end

mutable struct aeron_parsed_address_stct
    host::NTuple{384, Cchar}
    port::NTuple{8, Cchar}
    ip_version_hint::Cint
    aeron_parsed_address_stct() = new()
end

const aeron_parsed_address_t = aeron_parsed_address_stct

mutable struct aeron_parsed_interface_stct
    host::NTuple{384, Cchar}
    port::NTuple{8, Cchar}
    prefix::NTuple{8, Cchar}
    ip_version_hint::Cint
    aeron_parsed_interface_stct() = new()
end

const aeron_parsed_interface_t = aeron_parsed_interface_stct

"""
    aeron_parse_size64(str, result)

### Prototype
```c
int aeron_parse_size64(const char *str, uint64_t *result);
```
"""
function aeron_parse_size64(str, result)
    @ccall libaeron.aeron_parse_size64(str::Cstring, result::Ptr{UInt64})::Cint
end

"""
    aeron_parse_duration_ns(str, result)

### Prototype
```c
int aeron_parse_duration_ns(const char *str, uint64_t *result);
```
"""
function aeron_parse_duration_ns(str, result)
    @ccall libaeron.aeron_parse_duration_ns(str::Cstring, result::Ptr{UInt64})::Cint
end

"""
    aeron_parse_bool(str, def)

### Prototype
```c
bool aeron_parse_bool(const char *str, bool def);
```
"""
function aeron_parse_bool(str, def)
    @ccall libaeron.aeron_parse_bool(str::Cstring, def::Bool)::Bool
end

"""
    aeron_address_split(address_str, parsed_address)

### Prototype
```c
int aeron_address_split(const char *address_str, aeron_parsed_address_t *parsed_address);
```
"""
function aeron_address_split(address_str, parsed_address)
    @ccall libaeron.aeron_address_split(address_str::Cstring, parsed_address::Ptr{aeron_parsed_address_t})::Cint
end

"""
    aeron_interface_split(interface_str, parsed_interface)

### Prototype
```c
int aeron_interface_split(const char *interface_str, aeron_parsed_interface_t *parsed_interface);
```
"""
function aeron_interface_split(interface_str, parsed_interface)
    @ccall libaeron.aeron_interface_split(interface_str::Cstring, parsed_interface::Ptr{aeron_parsed_interface_t})::Cint
end

"""
    aeron_parse_get_line(line, max_length, buffer)

### Prototype
```c
int aeron_parse_get_line(char *line, size_t max_length, const char *buffer);
```
"""
function aeron_parse_get_line(line, max_length, buffer)
    @ccall libaeron.aeron_parse_get_line(line::Cstring, max_length::Csize_t, buffer::Cstring)::Cint
end

mutable struct aeron_http_parsed_url_stct
    userinfo::NTuple{384, Cchar}
    host_and_port::NTuple{393, Cchar}
    path_and_query::NTuple{512, Cchar}
    address::sockaddr_storage
    ip_version_hint::Cint
    aeron_http_parsed_url_stct() = new()
end

const aeron_http_parsed_url_t = aeron_http_parsed_url_stct

"""
    aeron_http_parse_url(url, parsed_url)

### Prototype
```c
int aeron_http_parse_url(const char *url, aeron_http_parsed_url_t *parsed_url);
```
"""
function aeron_http_parse_url(url, parsed_url)
    @ccall libaeron.aeron_http_parse_url(url::Cstring, parsed_url::Ptr{aeron_http_parsed_url_t})::Cint
end

mutable struct aeron_http_response_stct
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
    aeron_http_response_stct() = new()
end

const aeron_http_response_t = aeron_http_response_stct

"""
    aeron_http_response_delete(response)

### Prototype
```c
inline void aeron_http_response_delete(aeron_http_response_t *response);
```
"""
function aeron_http_response_delete(response)
    @ccall libaeron.aeron_http_response_delete(response::Ptr{aeron_http_response_t})::Cvoid
end

"""
    aeron_http_retrieve(response, url, timeout_ns)

### Prototype
```c
int aeron_http_retrieve(aeron_http_response_t **response, const char *url, int64_t timeout_ns);
```
"""
function aeron_http_retrieve(response, url, timeout_ns)
    @ccall libaeron.aeron_http_retrieve(response::Ptr{Ptr{aeron_http_response_t}}, url::Cstring, timeout_ns::Int64)::Cint
end

"""
    aeron_http_header_get(response, header_name, line, max_length)

### Prototype
```c
int aeron_http_header_get(aeron_http_response_t *response, const char *header_name, char *line, size_t max_length);
```
"""
function aeron_http_header_get(response, header_name, line, max_length)
    @ccall libaeron.aeron_http_header_get(response::Ptr{aeron_http_response_t}, header_name::Cstring, line::Cstring, max_length::Csize_t)::Cint
end

"""
    aeron_array_ensure_capacity(array, element_size, old_capacity, new_capacity)

### Prototype
```c
inline int aeron_array_ensure_capacity(uint8_t **array, size_t element_size, size_t old_capacity, size_t new_capacity);
```
"""
function aeron_array_ensure_capacity(array, element_size, old_capacity, new_capacity)
    @ccall libaeron.aeron_array_ensure_capacity(array::Ptr{Ptr{UInt8}}, element_size::Csize_t, old_capacity::Csize_t, new_capacity::Csize_t)::Cint
end

"""
    aeron_array_fast_unordered_remove(array, element_size, index, last_index)

### Prototype
```c
inline void aeron_array_fast_unordered_remove( uint8_t *restrict array, size_t element_size, size_t index, size_t last_index);
```
"""
function aeron_array_fast_unordered_remove(array, element_size, index, last_index)
    @ccall libaeron.aeron_array_fast_unordered_remove(array::Ptr{UInt8}, element_size::Csize_t, index::Csize_t, last_index::Csize_t)::Cvoid
end

"""
    aeron_array_add(array, element_size, new_length, element_to_add)

### Prototype
```c
inline int aeron_array_add(uint8_t **array, size_t element_size, size_t new_length, uint8_t *restrict element_to_add);
```
"""
function aeron_array_add(array, element_size, new_length, element_to_add)
    @ccall libaeron.aeron_array_add(array::Ptr{Ptr{UInt8}}, element_size::Csize_t, new_length::Csize_t, element_to_add::Ptr{UInt8})::Cint
end

"""
    aeron_array_remove(array, element_size, index, old_length)

### Prototype
```c
inline int aeron_array_remove(uint8_t **array, size_t element_size, size_t index, size_t old_length);
```
"""
function aeron_array_remove(array, element_size, index, old_length)
    @ccall libaeron.aeron_array_remove(array::Ptr{Ptr{UInt8}}, element_size::Csize_t, index::Csize_t, old_length::Csize_t)::Cint
end

"""
    aeron_log_buffer_create(log_buffer, log_file, correlation_id, pre_touch)

### Prototype
```c
int aeron_log_buffer_create( aeron_log_buffer_t **log_buffer, const char *log_file, int64_t correlation_id, bool pre_touch);
```
"""
function aeron_log_buffer_create(log_buffer, log_file, correlation_id, pre_touch)
    @ccall libaeron.aeron_log_buffer_create(log_buffer::Ptr{Ptr{aeron_log_buffer_t}}, log_file::Cstring, correlation_id::Int64, pre_touch::Bool)::Cint
end

"""
    aeron_log_buffer_delete(log_buffer)

### Prototype
```c
int aeron_log_buffer_delete(aeron_log_buffer_t *log_buffer);
```
"""
function aeron_log_buffer_delete(log_buffer)
    @ccall libaeron.aeron_log_buffer_delete(log_buffer::Ptr{aeron_log_buffer_t})::Cint
end

"""
    aeron_term_scanner_scan_for_availability(buffer, term_length_left, max_length, padding)

### Prototype
```c
inline size_t aeron_term_scanner_scan_for_availability( const uint8_t *buffer, size_t term_length_left, size_t max_length, size_t *padding);
```
"""
function aeron_term_scanner_scan_for_availability(buffer, term_length_left, max_length, padding)
    @ccall libaeron.aeron_term_scanner_scan_for_availability(buffer::Ptr{UInt8}, term_length_left::Csize_t, max_length::Csize_t, padding::Ptr{Csize_t})::Csize_t
end

"""
    aeron_buffer_builder_create(buffer_builder)

### Prototype
```c
int aeron_buffer_builder_create(aeron_buffer_builder_t **buffer_builder);
```
"""
function aeron_buffer_builder_create(buffer_builder)
    @ccall libaeron.aeron_buffer_builder_create(buffer_builder::Ptr{Ptr{aeron_buffer_builder_t}})::Cint
end

"""
    aeron_buffer_builder_find_suitable_capacity(current_capacity, required_capacity)

### Prototype
```c
int aeron_buffer_builder_find_suitable_capacity(size_t current_capacity, size_t required_capacity);
```
"""
function aeron_buffer_builder_find_suitable_capacity(current_capacity, required_capacity)
    @ccall libaeron.aeron_buffer_builder_find_suitable_capacity(current_capacity::Csize_t, required_capacity::Csize_t)::Cint
end

"""
    aeron_buffer_builder_ensure_capacity(buffer_builder, additional_capacity)

### Prototype
```c
int aeron_buffer_builder_ensure_capacity(aeron_buffer_builder_t *buffer_builder, size_t additional_capacity);
```
"""
function aeron_buffer_builder_ensure_capacity(buffer_builder, additional_capacity)
    @ccall libaeron.aeron_buffer_builder_ensure_capacity(buffer_builder::Ptr{aeron_buffer_builder_t}, additional_capacity::Csize_t)::Cint
end

"""
    aeron_buffer_builder_delete(buffer_builder)

### Prototype
```c
void aeron_buffer_builder_delete(aeron_buffer_builder_t *buffer_builder);
```
"""
function aeron_buffer_builder_delete(buffer_builder)
    @ccall libaeron.aeron_buffer_builder_delete(buffer_builder::Ptr{aeron_buffer_builder_t})::Cvoid
end

"""
    aeron_buffer_builder_reset(buffer_builder)

### Prototype
```c
inline void aeron_buffer_builder_reset(aeron_buffer_builder_t *buffer_builder);
```
"""
function aeron_buffer_builder_reset(buffer_builder)
    @ccall libaeron.aeron_buffer_builder_reset(buffer_builder::Ptr{aeron_buffer_builder_t})::Cvoid
end

"""
    aeron_buffer_builder_append(buffer_builder, buffer, length)

### Prototype
```c
inline int aeron_buffer_builder_append( aeron_buffer_builder_t *buffer_builder, const uint8_t *buffer, size_t length);
```
"""
function aeron_buffer_builder_append(buffer_builder, buffer, length)
    @ccall libaeron.aeron_buffer_builder_append(buffer_builder::Ptr{aeron_buffer_builder_t}, buffer::Ptr{UInt8}, length::Csize_t)::Cint
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

"""
    aeron_term_rebuilder_insert(dest, src, length)

### Prototype
```c
inline void aeron_term_rebuilder_insert(uint8_t *dest, const uint8_t *src, size_t length);
```
"""
function aeron_term_rebuilder_insert(dest, src, length)
    @ccall libaeron.aeron_term_rebuilder_insert(dest::Ptr{UInt8}, src::Ptr{UInt8}, length::Csize_t)::Cvoid
end

mutable struct aeron_spsc_rb_stct
    buffer::Ptr{UInt8}
    descriptor::Ptr{aeron_rb_descriptor_t}
    capacity::Csize_t
    max_message_length::Csize_t
    aeron_spsc_rb_stct() = new()
end

const aeron_spsc_rb_t = aeron_spsc_rb_stct

"""
    aeron_spsc_rb_init(ring_buffer, buffer, length)

### Prototype
```c
int aeron_spsc_rb_init(aeron_spsc_rb_t *ring_buffer, void *buffer, size_t length);
```
"""
function aeron_spsc_rb_init(ring_buffer, buffer, length)
    @ccall libaeron.aeron_spsc_rb_init(ring_buffer::Ptr{aeron_spsc_rb_t}, buffer::Ptr{Cvoid}, length::Csize_t)::Cint
end

"""
    aeron_spsc_rb_write(ring_buffer, msg_type_id, msg, length)

### Prototype
```c
aeron_rb_write_result_t aeron_spsc_rb_write( aeron_spsc_rb_t *ring_buffer, int32_t msg_type_id, const void *msg, size_t length);
```
"""
function aeron_spsc_rb_write(ring_buffer, msg_type_id, msg, length)
    @ccall libaeron.aeron_spsc_rb_write(ring_buffer::Ptr{aeron_spsc_rb_t}, msg_type_id::Int32, msg::Ptr{Cvoid}, length::Csize_t)::aeron_rb_write_result_t
end

"""
    aeron_spsc_rb_writev(ring_buffer, msg_type_id, iov, iovcnt)

### Prototype
```c
aeron_rb_write_result_t aeron_spsc_rb_writev( aeron_spsc_rb_t *ring_buffer, int32_t msg_type_id, const struct iovec* iov, int iovcnt);
```
"""
function aeron_spsc_rb_writev(ring_buffer, msg_type_id, iov, iovcnt)
    @ccall libaeron.aeron_spsc_rb_writev(ring_buffer::Ptr{aeron_spsc_rb_t}, msg_type_id::Int32, iov::Ptr{Cvoid}, iovcnt::Cint)::aeron_rb_write_result_t
end

"""
    aeron_spsc_rb_try_claim(ring_buffer, msg_type_id, length)

### Prototype
```c
int32_t aeron_spsc_rb_try_claim(aeron_spsc_rb_t *ring_buffer, int32_t msg_type_id, size_t length);
```
"""
function aeron_spsc_rb_try_claim(ring_buffer, msg_type_id, length)
    @ccall libaeron.aeron_spsc_rb_try_claim(ring_buffer::Ptr{aeron_spsc_rb_t}, msg_type_id::Int32, length::Csize_t)::Int32
end

"""
    aeron_spsc_rb_commit(ring_buffer, offset)

### Prototype
```c
int aeron_spsc_rb_commit(aeron_spsc_rb_t *ring_buffer, int32_t offset);
```
"""
function aeron_spsc_rb_commit(ring_buffer, offset)
    @ccall libaeron.aeron_spsc_rb_commit(ring_buffer::Ptr{aeron_spsc_rb_t}, offset::Int32)::Cint
end

"""
    aeron_spsc_rb_abort(ring_buffer, offset)

### Prototype
```c
int aeron_spsc_rb_abort(aeron_spsc_rb_t *ring_buffer, int32_t offset);
```
"""
function aeron_spsc_rb_abort(ring_buffer, offset)
    @ccall libaeron.aeron_spsc_rb_abort(ring_buffer::Ptr{aeron_spsc_rb_t}, offset::Int32)::Cint
end

"""
    aeron_spsc_rb_read(ring_buffer, handler, clientd, message_count_limit)

### Prototype
```c
size_t aeron_spsc_rb_read( aeron_spsc_rb_t *ring_buffer, aeron_rb_handler_t handler, void *clientd, size_t message_count_limit);
```
"""
function aeron_spsc_rb_read(ring_buffer, handler, clientd, message_count_limit)
    @ccall libaeron.aeron_spsc_rb_read(ring_buffer::Ptr{aeron_spsc_rb_t}, handler::aeron_rb_handler_t, clientd::Ptr{Cvoid}, message_count_limit::Csize_t)::Csize_t
end

"""
    aeron_spsc_rb_next_correlation_id(ring_buffer)

### Prototype
```c
int64_t aeron_spsc_rb_next_correlation_id(aeron_spsc_rb_t *ring_buffer);
```
"""
function aeron_spsc_rb_next_correlation_id(ring_buffer)
    @ccall libaeron.aeron_spsc_rb_next_correlation_id(ring_buffer::Ptr{aeron_spsc_rb_t})::Int64
end

"""
    aeron_spsc_rb_consumer_heartbeat_time(ring_buffer, time_ms)

### Prototype
```c
void aeron_spsc_rb_consumer_heartbeat_time(aeron_spsc_rb_t *ring_buffer, int64_t time_ms);
```
"""
function aeron_spsc_rb_consumer_heartbeat_time(ring_buffer, time_ms)
    @ccall libaeron.aeron_spsc_rb_consumer_heartbeat_time(ring_buffer::Ptr{aeron_spsc_rb_t}, time_ms::Int64)::Cvoid
end

"""
    aeron_client_connect_to_driver(cnc_mmap, context)

### Prototype
```c
int aeron_client_connect_to_driver(aeron_mapped_file_t *cnc_mmap, aeron_context_t *context);
```
"""
function aeron_client_connect_to_driver(cnc_mmap, context)
    @ccall libaeron.aeron_client_connect_to_driver(cnc_mmap::Ptr{aeron_mapped_file_t}, context::Ptr{aeron_context_t})::Cint
end

struct aeron_str_to_ptr_hash_map_key_stct
    str::Cstring
    hash_code::UInt64
    str_length::Csize_t
end

const aeron_str_to_ptr_hash_map_key_t = aeron_str_to_ptr_hash_map_key_stct

mutable struct aeron_str_to_ptr_hash_map_stct
    keys::Ptr{aeron_str_to_ptr_hash_map_key_t}
    values::Ptr{Ptr{Cvoid}}
    load_factor::Cfloat
    capacity::Csize_t
    size::Csize_t
    resize_threshold::Csize_t
    aeron_str_to_ptr_hash_map_stct() = new()
end

const aeron_str_to_ptr_hash_map_t = aeron_str_to_ptr_hash_map_stct

"""
    aeron_str_to_ptr_hash_map_hash_key(key_hash_code, mask)

### Prototype
```c
inline size_t aeron_str_to_ptr_hash_map_hash_key(uint64_t key_hash_code, size_t mask);
```
"""
function aeron_str_to_ptr_hash_map_hash_key(key_hash_code, mask)
    @ccall libaeron.aeron_str_to_ptr_hash_map_hash_key(key_hash_code::UInt64, mask::Csize_t)::Csize_t
end

"""
    aeron_str_to_ptr_hash_map_compare(key, key_str, key_str_len, key_hash_code)

### Prototype
```c
inline bool aeron_str_to_ptr_hash_map_compare( aeron_str_to_ptr_hash_map_key_t *key, const char *key_str, size_t key_str_len, uint64_t key_hash_code);
```
"""
function aeron_str_to_ptr_hash_map_compare(key, key_str, key_str_len, key_hash_code)
    @ccall libaeron.aeron_str_to_ptr_hash_map_compare(key::Ptr{aeron_str_to_ptr_hash_map_key_t}, key_str::Cstring, key_str_len::Csize_t, key_hash_code::UInt64)::Bool
end

"""
    aeron_str_to_ptr_hash_map_init(map, initial_capacity, load_factor)

### Prototype
```c
inline int aeron_str_to_ptr_hash_map_init(aeron_str_to_ptr_hash_map_t *map, size_t initial_capacity, float load_factor);
```
"""
function aeron_str_to_ptr_hash_map_init(map, initial_capacity, load_factor)
    @ccall libaeron.aeron_str_to_ptr_hash_map_init(map::Ptr{aeron_str_to_ptr_hash_map_t}, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

"""
    aeron_str_to_ptr_hash_map_delete(map)

### Prototype
```c
inline void aeron_str_to_ptr_hash_map_delete(aeron_str_to_ptr_hash_map_t *map);
```
"""
function aeron_str_to_ptr_hash_map_delete(map)
    @ccall libaeron.aeron_str_to_ptr_hash_map_delete(map::Ptr{aeron_str_to_ptr_hash_map_t})::Cvoid
end

"""
    aeron_str_to_ptr_hash_map_rehash(map, new_capacity)

### Prototype
```c
inline int aeron_str_to_ptr_hash_map_rehash(aeron_str_to_ptr_hash_map_t *map, size_t new_capacity);
```
"""
function aeron_str_to_ptr_hash_map_rehash(map, new_capacity)
    @ccall libaeron.aeron_str_to_ptr_hash_map_rehash(map::Ptr{aeron_str_to_ptr_hash_map_t}, new_capacity::Csize_t)::Cint
end

"""
    aeron_str_to_ptr_hash_map_put(map, key, key_len, value)

### Prototype
```c
inline int aeron_str_to_ptr_hash_map_put(aeron_str_to_ptr_hash_map_t *map, const char *key, size_t key_len, void *value);
```
"""
function aeron_str_to_ptr_hash_map_put(map, key, key_len, value)
    @ccall libaeron.aeron_str_to_ptr_hash_map_put(map::Ptr{aeron_str_to_ptr_hash_map_t}, key::Cstring, key_len::Csize_t, value::Ptr{Cvoid})::Cint
end

"""
    aeron_str_to_ptr_hash_map_get(map, key, key_len)

### Prototype
```c
inline void *aeron_str_to_ptr_hash_map_get(aeron_str_to_ptr_hash_map_t *map, const char *key, size_t key_len);
```
"""
function aeron_str_to_ptr_hash_map_get(map, key, key_len)
    @ccall libaeron.aeron_str_to_ptr_hash_map_get(map::Ptr{aeron_str_to_ptr_hash_map_t}, key::Cstring, key_len::Csize_t)::Ptr{Cvoid}
end

"""
    aeron_str_to_ptr_hash_map_compact_chain(map, delete_index)

### Prototype
```c
inline void aeron_str_to_ptr_hash_map_compact_chain(aeron_str_to_ptr_hash_map_t *map, size_t delete_index);
```
"""
function aeron_str_to_ptr_hash_map_compact_chain(map, delete_index)
    @ccall libaeron.aeron_str_to_ptr_hash_map_compact_chain(map::Ptr{aeron_str_to_ptr_hash_map_t}, delete_index::Csize_t)::Cvoid
end

"""
    aeron_str_to_ptr_hash_map_remove(map, key, key_len)

### Prototype
```c
inline void *aeron_str_to_ptr_hash_map_remove(aeron_str_to_ptr_hash_map_t *map, const char *key, size_t key_len);
```
"""
function aeron_str_to_ptr_hash_map_remove(map, key, key_len)
    @ccall libaeron.aeron_str_to_ptr_hash_map_remove(map::Ptr{aeron_str_to_ptr_hash_map_t}, key::Cstring, key_len::Csize_t)::Ptr{Cvoid}
end

# typedef void ( * aeron_str_to_ptr_hash_map_for_each_func_t ) ( void * clientd , const char * key , size_t key_len , void * value )
const aeron_str_to_ptr_hash_map_for_each_func_t = Ptr{Cvoid}

"""
    aeron_str_to_ptr_hash_map_for_each(map, func, clientd)

### Prototype
```c
inline void aeron_str_to_ptr_hash_map_for_each( aeron_str_to_ptr_hash_map_t *map, aeron_str_to_ptr_hash_map_for_each_func_t func, void *clientd);
```
"""
function aeron_str_to_ptr_hash_map_for_each(map, func, clientd)
    @ccall libaeron.aeron_str_to_ptr_hash_map_for_each(map::Ptr{aeron_str_to_ptr_hash_map_t}, func::aeron_str_to_ptr_hash_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

"""
    aeron_publication_create(publication, conductor, channel, stream_id, session_id, position_limit_counter_id, position_limit_addr, channel_status_indicator_id, channel_status_addr, log_buffer, original_registration_id, registration_id)

### Prototype
```c
int aeron_publication_create( aeron_publication_t **publication, aeron_client_conductor_t *conductor, const char *channel, int32_t stream_id, int32_t session_id, int32_t position_limit_counter_id, int64_t *position_limit_addr, int32_t channel_status_indicator_id, int64_t *channel_status_addr, aeron_log_buffer_t *log_buffer, int64_t original_registration_id, int64_t registration_id);
```
"""
function aeron_publication_create(publication, conductor, channel, stream_id, session_id, position_limit_counter_id, position_limit_addr, channel_status_indicator_id, channel_status_addr, log_buffer, original_registration_id, registration_id)
    @ccall libaeron.aeron_publication_create(publication::Ptr{Ptr{aeron_publication_t}}, conductor::Ptr{aeron_client_conductor_t}, channel::Cstring, stream_id::Int32, session_id::Int32, position_limit_counter_id::Int32, position_limit_addr::Ptr{Int64}, channel_status_indicator_id::Int32, channel_status_addr::Ptr{Int64}, log_buffer::Ptr{aeron_log_buffer_t}, original_registration_id::Int64, registration_id::Int64)::Cint
end

"""
    aeron_publication_delete(publication)

### Prototype
```c
int aeron_publication_delete(aeron_publication_t *publication);
```
"""
function aeron_publication_delete(publication)
    @ccall libaeron.aeron_publication_delete(publication::Ptr{aeron_publication_t})::Cint
end

"""
    aeron_publication_force_close(publication)

### Prototype
```c
void aeron_publication_force_close(aeron_publication_t *publication);
```
"""
function aeron_publication_force_close(publication)
    @ccall libaeron.aeron_publication_force_close(publication::Ptr{aeron_publication_t})::Cvoid
end

"""
    aeron_publication_back_pressure_status(publication, current_position, message_length)

### Prototype
```c
inline int64_t aeron_publication_back_pressure_status( aeron_publication_t *publication, int64_t current_position, int32_t message_length);
```
"""
function aeron_publication_back_pressure_status(publication, current_position, message_length)
    @ccall libaeron.aeron_publication_back_pressure_status(publication::Ptr{aeron_publication_t}, current_position::Int64, message_length::Int32)::Int64
end

"""
    aeron_counter_create(counter, conductor, registration_id, counter_id, counter_addr)

### Prototype
```c
int aeron_counter_create( aeron_counter_t **counter, aeron_client_conductor_t *conductor, int64_t registration_id, int32_t counter_id, int64_t *counter_addr);
```
"""
function aeron_counter_create(counter, conductor, registration_id, counter_id, counter_addr)
    @ccall libaeron.aeron_counter_create(counter::Ptr{Ptr{aeron_counter_t}}, conductor::Ptr{aeron_client_conductor_t}, registration_id::Int64, counter_id::Int32, counter_addr::Ptr{Int64})::Cint
end

"""
    aeron_counter_delete(counter)

### Prototype
```c
int aeron_counter_delete(aeron_counter_t *counter);
```
"""
function aeron_counter_delete(counter)
    @ccall libaeron.aeron_counter_delete(counter::Ptr{aeron_counter_t})::Cint
end

"""
    aeron_counter_force_close(counter)

### Prototype
```c
void aeron_counter_force_close(aeron_counter_t *counter);
```
"""
function aeron_counter_force_close(counter)
    @ccall libaeron.aeron_counter_force_close(counter::Ptr{aeron_counter_t})::Cvoid
end

struct aeron_int64_to_tagged_ptr_entry_stct
    value::Ptr{Cvoid}
    internal_flags::UInt32
    tag::UInt32
end

const aeron_int64_to_tagged_ptr_entry_t = aeron_int64_to_tagged_ptr_entry_stct

mutable struct aeron_int64_to_tagged_ptr_hash_map_stct
    keys::Ptr{Int64}
    entries::Ptr{aeron_int64_to_tagged_ptr_entry_t}
    load_factor::Cfloat
    capacity::Csize_t
    size::Csize_t
    resize_threshold::Csize_t
    aeron_int64_to_tagged_ptr_hash_map_stct() = new()
end

const aeron_int64_to_tagged_ptr_hash_map_t = aeron_int64_to_tagged_ptr_hash_map_stct

"""
    aeron_int64_to_tagged_ptr_hash_map_hash_key(key, mask)

### Prototype
```c
inline size_t aeron_int64_to_tagged_ptr_hash_map_hash_key(int64_t key, size_t mask);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_hash_key(key, mask)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_hash_key(key::Int64, mask::Csize_t)::Csize_t
end

"""
    aeron_int64_to_tagged_ptr_hash_map_init(map, initial_capacity, load_factor)

### Prototype
```c
inline int aeron_int64_to_tagged_ptr_hash_map_init( aeron_int64_to_tagged_ptr_hash_map_t *map, size_t initial_capacity, float load_factor);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_init(map, initial_capacity, load_factor)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_init(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, initial_capacity::Csize_t, load_factor::Cfloat)::Cint
end

"""
    aeron_int64_to_tagged_ptr_hash_map_delete(map)

### Prototype
```c
inline void aeron_int64_to_tagged_ptr_hash_map_delete(aeron_int64_to_tagged_ptr_hash_map_t *map);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_delete(map)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_delete(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t})::Cvoid
end

"""
    aeron_int64_to_tagged_ptr_hash_map_rehash(map, new_capacity)

### Prototype
```c
inline int aeron_int64_to_tagged_ptr_hash_map_rehash(aeron_int64_to_tagged_ptr_hash_map_t *map, size_t new_capacity);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_rehash(map, new_capacity)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_rehash(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, new_capacity::Csize_t)::Cint
end

"""
    aeron_int64_to_tagged_ptr_hash_map_put(map, key, tag, value)

### Prototype
```c
inline int aeron_int64_to_tagged_ptr_hash_map_put( aeron_int64_to_tagged_ptr_hash_map_t *map, const int64_t key, int32_t tag, void *value);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_put(map, key, tag, value)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_put(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, key::Int64, tag::Int32, value::Ptr{Cvoid})::Cint
end

"""
    aeron_int64_to_tagged_ptr_hash_map_get(map, key, tag, value)

### Prototype
```c
inline bool aeron_int64_to_tagged_ptr_hash_map_get( aeron_int64_to_tagged_ptr_hash_map_t *map, const int64_t key, uint32_t *tag, void **value);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_get(map, key, tag, value)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_get(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, key::Int64, tag::Ptr{UInt32}, value::Ptr{Ptr{Cvoid}})::Bool
end

"""
    aeron_int64_to_tagged_ptr_hash_map_compact_chain(map, delete_index)

### Prototype
```c
inline void aeron_int64_to_tagged_ptr_hash_map_compact_chain( aeron_int64_to_tagged_ptr_hash_map_t *map, size_t delete_index);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_compact_chain(map, delete_index)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_compact_chain(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, delete_index::Csize_t)::Cvoid
end

"""
    aeron_int64_to_tagged_ptr_hash_map_remove(map, key, tag, value)

### Prototype
```c
inline bool aeron_int64_to_tagged_ptr_hash_map_remove( aeron_int64_to_tagged_ptr_hash_map_t *map, int64_t key, uint32_t *tag, void **value);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_remove(map, key, tag, value)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_remove(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, key::Int64, tag::Ptr{UInt32}, value::Ptr{Ptr{Cvoid}})::Bool
end

# typedef void ( * aeron_int64_to_tagged_ptr_hash_map_for_each_func_t ) ( void * clientd , int64_t key , uint32_t tag , void * value )
const aeron_int64_to_tagged_ptr_hash_map_for_each_func_t = Ptr{Cvoid}

# typedef bool ( * aeron_int64_to_tagged_ptr_hash_map_predicate_func_t ) ( void * clientd , int64_t key , uint32_t tag , void * value )
const aeron_int64_to_tagged_ptr_hash_map_predicate_func_t = Ptr{Cvoid}

"""
    aeron_int64_to_tagged_ptr_hash_map_for_each(map, func, clientd)

### Prototype
```c
inline void aeron_int64_to_tagged_ptr_hash_map_for_each( aeron_int64_to_tagged_ptr_hash_map_t *map, aeron_int64_to_tagged_ptr_hash_map_for_each_func_t func, void *clientd);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_for_each(map, func, clientd)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_for_each(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, func::aeron_int64_to_tagged_ptr_hash_map_for_each_func_t, clientd::Ptr{Cvoid})::Cvoid
end

"""
    aeron_int64_to_tagged_ptr_hash_map_remove_if(map, func, clientd)

### Prototype
```c
inline void aeron_int64_to_tagged_ptr_hash_map_remove_if( aeron_int64_to_tagged_ptr_hash_map_t *map, aeron_int64_to_tagged_ptr_hash_map_predicate_func_t func, void *clientd);
```
"""
function aeron_int64_to_tagged_ptr_hash_map_remove_if(map, func, clientd)
    @ccall libaeron.aeron_int64_to_tagged_ptr_hash_map_remove_if(map::Ptr{aeron_int64_to_tagged_ptr_hash_map_t}, func::aeron_int64_to_tagged_ptr_hash_map_predicate_func_t, clientd::Ptr{Cvoid})::Cvoid
end

mutable struct aeron_symbol_table_obj_stct
    alias::Cstring
    name::Cstring
    object::Ptr{Cvoid}
    aeron_symbol_table_obj_stct() = new()
end

const aeron_symbol_table_obj_t = aeron_symbol_table_obj_stct

"""
    aeron_symbol_table_obj_load(table, table_length, name, component_name)

### Prototype
```c
void* aeron_symbol_table_obj_load( const aeron_symbol_table_obj_t *table, size_t table_length, const char *name, const char *component_name);
```
"""
function aeron_symbol_table_obj_load(table, table_length, name, component_name)
    @ccall libaeron.aeron_symbol_table_obj_load(table::Ptr{aeron_symbol_table_obj_t}, table_length::Csize_t, name::Cstring, component_name::Cstring)::Ptr{Cvoid}
end

mutable struct aeron_symbol_table_func_stct
    alias::Cstring
    name::Cstring
    _function::aeron_fptr_t
    aeron_symbol_table_func_stct() = new()
end

const aeron_symbol_table_func_t = aeron_symbol_table_func_stct

"""
    aeron_symbol_table_func_load(table, table_length, name, component_name)

### Prototype
```c
aeron_fptr_t aeron_symbol_table_func_load( const aeron_symbol_table_func_t *table, size_t table_length, const char *name, const char *component_name);
```
"""
function aeron_symbol_table_func_load(table, table_length, name, component_name)
    @ccall libaeron.aeron_symbol_table_func_load(table::Ptr{aeron_symbol_table_func_t}, table_length::Csize_t, name::Cstring, component_name::Cstring)::aeron_fptr_t
end

# typedef void ( * aeron_term_gap_scanner_on_gap_detected_func_t ) ( void * clientd , int32_t term_id , int32_t term_offset , size_t length )
const aeron_term_gap_scanner_on_gap_detected_func_t = Ptr{Cvoid}

"""
    aeron_term_gap_scanner_scan_for_gap(buffer, term_id, term_offset, limit_offset, on_gap_detected, clientd)

### Prototype
```c
inline int32_t aeron_term_gap_scanner_scan_for_gap( const uint8_t *buffer, int32_t term_id, int32_t term_offset, int32_t limit_offset, aeron_term_gap_scanner_on_gap_detected_func_t on_gap_detected, void *clientd);
```
"""
function aeron_term_gap_scanner_scan_for_gap(buffer, term_id, term_offset, limit_offset, on_gap_detected, clientd)
    @ccall libaeron.aeron_term_gap_scanner_scan_for_gap(buffer::Ptr{UInt8}, term_id::Int32, term_offset::Int32, limit_offset::Int32, on_gap_detected::aeron_term_gap_scanner_on_gap_detected_func_t, clientd::Ptr{Cvoid})::Int32
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

@cenum aeron_cnc_load_result_stct::Int32 begin
    AERON_CNC_LOAD_FAILED = -1
    AERON_CNC_LOAD_SUCCESS = 0
    AERON_CNC_LOAD_AWAIT_FILE = 1
    AERON_CNC_LOAD_AWAIT_MMAP = 2
    AERON_CNC_LOAD_AWAIT_VERSION = 3
    AERON_CNC_LOAD_AWAIT_CNC_DATA = 4
end

const aeron_cnc_load_result_t = aeron_cnc_load_result_stct

"""
    aeron_cnc_to_driver_buffer(metadata)

### Prototype
```c
inline uint8_t *aeron_cnc_to_driver_buffer(aeron_cnc_metadata_t *metadata);
```
"""
function aeron_cnc_to_driver_buffer(metadata)
    @ccall libaeron.aeron_cnc_to_driver_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

"""
    aeron_cnc_to_clients_buffer(metadata)

### Prototype
```c
inline uint8_t *aeron_cnc_to_clients_buffer(aeron_cnc_metadata_t *metadata);
```
"""
function aeron_cnc_to_clients_buffer(metadata)
    @ccall libaeron.aeron_cnc_to_clients_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

"""
    aeron_cnc_counters_metadata_buffer(metadata)

### Prototype
```c
inline uint8_t *aeron_cnc_counters_metadata_buffer(aeron_cnc_metadata_t *metadata);
```
"""
function aeron_cnc_counters_metadata_buffer(metadata)
    @ccall libaeron.aeron_cnc_counters_metadata_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

"""
    aeron_cnc_counters_values_buffer(metadata)

### Prototype
```c
inline uint8_t *aeron_cnc_counters_values_buffer(aeron_cnc_metadata_t *metadata);
```
"""
function aeron_cnc_counters_values_buffer(metadata)
    @ccall libaeron.aeron_cnc_counters_values_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

"""
    aeron_cnc_error_log_buffer(metadata)

### Prototype
```c
inline uint8_t *aeron_cnc_error_log_buffer(aeron_cnc_metadata_t *metadata);
```
"""
function aeron_cnc_error_log_buffer(metadata)
    @ccall libaeron.aeron_cnc_error_log_buffer(metadata::Ptr{aeron_cnc_metadata_t})::Ptr{UInt8}
end

"""
    aeron_cnc_computed_length(total_length_of_buffers, alignment)

### Prototype
```c
inline size_t aeron_cnc_computed_length(size_t total_length_of_buffers, size_t alignment);
```
"""
function aeron_cnc_computed_length(total_length_of_buffers, alignment)
    @ccall libaeron.aeron_cnc_computed_length(total_length_of_buffers::Csize_t, alignment::Csize_t)::Csize_t
end

"""
    aeron_cnc_is_file_length_sufficient(cnc_mmap)

### Prototype
```c
inline bool aeron_cnc_is_file_length_sufficient(aeron_mapped_file_t *cnc_mmap);
```
"""
function aeron_cnc_is_file_length_sufficient(cnc_mmap)
    @ccall libaeron.aeron_cnc_is_file_length_sufficient(cnc_mmap::Ptr{aeron_mapped_file_t})::Bool
end

"""
    aeron_cnc_version_volatile(metadata)

### Prototype
```c
int32_t aeron_cnc_version_volatile(aeron_cnc_metadata_t *metadata);
```
"""
function aeron_cnc_version_volatile(metadata)
    @ccall libaeron.aeron_cnc_version_volatile(metadata::Ptr{aeron_cnc_metadata_t})::Int32
end

"""
    aeron_cnc_map_file_and_load_metadata(dir, mapped_file, metadata)

### Prototype
```c
aeron_cnc_load_result_t aeron_cnc_map_file_and_load_metadata( const char *dir, aeron_mapped_file_t *mapped_file, aeron_cnc_metadata_t **metadata);
```
"""
function aeron_cnc_map_file_and_load_metadata(dir, mapped_file, metadata)
    @ccall libaeron.aeron_cnc_map_file_and_load_metadata(dir::Cstring, mapped_file::Ptr{aeron_mapped_file_t}, metadata::Ptr{Ptr{aeron_cnc_metadata_t}})::aeron_cnc_load_result_t
end

"""
    aeron_cnc_resolve_filename(directory, filename_buffer, filename_buffer_length)

### Prototype
```c
int aeron_cnc_resolve_filename(const char *directory, char *filename_buffer, size_t filename_buffer_length);
```
"""
function aeron_cnc_resolve_filename(directory, filename_buffer, filename_buffer_length)
    @ccall libaeron.aeron_cnc_resolve_filename(directory::Cstring, filename_buffer::Cstring, filename_buffer_length::Csize_t)::Cint
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

mutable struct aeron_udp_channel_params_stct
    endpoint::Cstring
    bind_interface::Cstring
    control::Cstring
    control_mode::Cstring
    channel_tag::Cstring
    entity_tag::Cstring
    ttl::Cstring
    additional_params::aeron_uri_params_t
    aeron_udp_channel_params_stct() = new()
end

const aeron_udp_channel_params_t = aeron_udp_channel_params_stct

mutable struct aeron_ipc_channel_params_stct
    channel_tag::Cstring
    entity_tag::Cstring
    additional_params::aeron_uri_params_t
    aeron_ipc_channel_params_stct() = new()
end

const aeron_ipc_channel_params_t = aeron_ipc_channel_params_stct

@cenum aeron_uri_type_enum::UInt32 begin
    AERON_URI_UDP = 0
    AERON_URI_IPC = 1
    AERON_URI_UNKNOWN = 2
end

const aeron_uri_type_t = aeron_uri_type_enum

struct var"##Ctag#2341"
    data::NTuple{72, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#2341"}, f::Symbol)
    f === :udp && return Ptr{aeron_udp_channel_params_t}(x + 0)
    f === :ipc && return Ptr{aeron_ipc_channel_params_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#2341", f::Symbol)
    r = Ref{var"##Ctag#2341"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#2341"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#2341"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct aeron_uri_stct
    data::NTuple{464, UInt8}
end

function Base.getproperty(x::Ptr{aeron_uri_stct}, f::Symbol)
    f === :mutable_uri && return Ptr{NTuple{384, Cchar}}(x + 0)
    f === :type && return Ptr{aeron_uri_type_t}(x + 384)
    f === :params && return Ptr{var"##Ctag#2341"}(x + 392)
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

@cenum aeron_uri_ats_status_en::UInt32 begin
    AERON_URI_ATS_STATUS_DEFAULT = 0
    AERON_URI_ATS_STATUS_ENABLED = 1
    AERON_URI_ATS_STATUS_DISABLED = 2
end

const aeron_uri_ats_status_t = aeron_uri_ats_status_en

# typedef int ( * aeron_uri_parse_callback_t ) ( void * clientd , const char * key , const char * value )
const aeron_uri_parse_callback_t = Ptr{Cvoid}

"""
    aeron_uri_parse_params(uri, param_func, clientd)

### Prototype
```c
int aeron_uri_parse_params(char *uri, aeron_uri_parse_callback_t param_func, void *clientd);
```
"""
function aeron_uri_parse_params(uri, param_func, clientd)
    @ccall libaeron.aeron_uri_parse_params(uri::Cstring, param_func::aeron_uri_parse_callback_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_udp_uri_parse(uri, params)

### Prototype
```c
int aeron_udp_uri_parse(char *uri, aeron_udp_channel_params_t *params);
```
"""
function aeron_udp_uri_parse(uri, params)
    @ccall libaeron.aeron_udp_uri_parse(uri::Cstring, params::Ptr{aeron_udp_channel_params_t})::Cint
end

"""
    aeron_ipc_uri_parse(uri, params)

### Prototype
```c
int aeron_ipc_uri_parse(char *uri, aeron_ipc_channel_params_t *params);
```
"""
function aeron_ipc_uri_parse(uri, params)
    @ccall libaeron.aeron_ipc_uri_parse(uri::Cstring, params::Ptr{aeron_ipc_channel_params_t})::Cint
end

"""
    aeron_uri_parse(uri_length, uri, params)

### Prototype
```c
int aeron_uri_parse(size_t uri_length, const char *uri, aeron_uri_t *params);
```
"""
function aeron_uri_parse(uri_length, uri, params)
    @ccall libaeron.aeron_uri_parse(uri_length::Csize_t, uri::Cstring, params::Ptr{aeron_uri_t})::Cint
end

"""
    aeron_uri_close(params)

### Prototype
```c
void aeron_uri_close(aeron_uri_t *params);
```
"""
function aeron_uri_close(params)
    @ccall libaeron.aeron_uri_close(params::Ptr{aeron_uri_t})::Cvoid
end

"""
    aeron_uri_multicast_ttl(uri)

### Prototype
```c
uint8_t aeron_uri_multicast_ttl(aeron_uri_t *uri);
```
"""
function aeron_uri_multicast_ttl(uri)
    @ccall libaeron.aeron_uri_multicast_ttl(uri::Ptr{aeron_uri_t})::UInt8
end

"""
    aeron_uri_find_param_value(uri_params, key)

### Prototype
```c
const char *aeron_uri_find_param_value(const aeron_uri_params_t *uri_params, const char *key);
```
"""
function aeron_uri_find_param_value(uri_params, key)
    @ccall libaeron.aeron_uri_find_param_value(uri_params::Ptr{aeron_uri_params_t}, key::Cstring)::Cstring
end

"""
    aeron_uri_get_int32(uri_params, key, retval)

### Prototype
```c
int aeron_uri_get_int32(aeron_uri_params_t *uri_params, const char *key, int32_t *retval);
```
"""
function aeron_uri_get_int32(uri_params, key, retval)
    @ccall libaeron.aeron_uri_get_int32(uri_params::Ptr{aeron_uri_params_t}, key::Cstring, retval::Ptr{Int32})::Cint
end

"""
    aeron_uri_get_int64(uri_params, key, retval)

### Prototype
```c
int aeron_uri_get_int64(aeron_uri_params_t *uri_params, const char *key, int64_t *retval);
```
"""
function aeron_uri_get_int64(uri_params, key, retval)
    @ccall libaeron.aeron_uri_get_int64(uri_params::Ptr{aeron_uri_params_t}, key::Cstring, retval::Ptr{Int64})::Cint
end

"""
    aeron_uri_get_bool(uri_params, key, retval)

### Prototype
```c
int aeron_uri_get_bool(aeron_uri_params_t *uri_params, const char *key, bool *retval);
```
"""
function aeron_uri_get_bool(uri_params, key, retval)
    @ccall libaeron.aeron_uri_get_bool(uri_params::Ptr{aeron_uri_params_t}, key::Cstring, retval::Ptr{Bool})::Cint
end

"""
    aeron_uri_get_ats(uri_params, uri_ats_status)

### Prototype
```c
int aeron_uri_get_ats(aeron_uri_params_t *uri_params, aeron_uri_ats_status_t *uri_ats_status);
```
"""
function aeron_uri_get_ats(uri_params, uri_ats_status)
    @ccall libaeron.aeron_uri_get_ats(uri_params::Ptr{aeron_uri_params_t}, uri_ats_status::Ptr{aeron_uri_ats_status_t})::Cint
end

"""
    aeron_uri_sprint(uri, buffer, buffer_len)

### Prototype
```c
int aeron_uri_sprint(aeron_uri_t *uri, char *buffer, size_t buffer_len);
```
"""
function aeron_uri_sprint(uri, buffer, buffer_len)
    @ccall libaeron.aeron_uri_sprint(uri::Ptr{aeron_uri_t}, buffer::Cstring, buffer_len::Csize_t)::Cint
end

"""
    aeron_uri_get_socket_buf_lengths(uri_params, socket_sndbuf_length, socket_rcvbuf_length)

### Prototype
```c
int aeron_uri_get_socket_buf_lengths( aeron_uri_params_t *uri_params, size_t *socket_sndbuf_length, size_t *socket_rcvbuf_length);
```
"""
function aeron_uri_get_socket_buf_lengths(uri_params, socket_sndbuf_length, socket_rcvbuf_length)
    @ccall libaeron.aeron_uri_get_socket_buf_lengths(uri_params::Ptr{aeron_uri_params_t}, socket_sndbuf_length::Ptr{Csize_t}, socket_rcvbuf_length::Ptr{Csize_t})::Cint
end

"""
    aeron_uri_get_receiver_window_length(uri_params, receiver_window_length)

### Prototype
```c
int aeron_uri_get_receiver_window_length(aeron_uri_params_t *uri_params, size_t *receiver_window_length);
```
"""
function aeron_uri_get_receiver_window_length(uri_params, receiver_window_length)
    @ccall libaeron.aeron_uri_get_receiver_window_length(uri_params::Ptr{aeron_uri_params_t}, receiver_window_length::Ptr{Csize_t})::Cint
end

"""
    aeron_uri_parse_tag(tag_str)

### Prototype
```c
int64_t aeron_uri_parse_tag(const char *tag_str);
```
"""
function aeron_uri_parse_tag(tag_str)
    @ccall libaeron.aeron_uri_parse_tag(tag_str::Cstring)::Int64
end

"""
    aeron_image_create(image, subscription, conductor, log_buffer, subscriber_position_id, subscriber_position, correlation_id, session_id, source_identity, source_identity_length)

### Prototype
```c
int aeron_image_create( aeron_image_t **image, aeron_subscription_t *subscription, aeron_client_conductor_t *conductor, aeron_log_buffer_t *log_buffer, int32_t subscriber_position_id, int64_t *subscriber_position, int64_t correlation_id, int32_t session_id, const char *source_identity, size_t source_identity_length);
```
"""
function aeron_image_create(image, subscription, conductor, log_buffer, subscriber_position_id, subscriber_position, correlation_id, session_id, source_identity, source_identity_length)
    @ccall libaeron.aeron_image_create(image::Ptr{Ptr{aeron_image_t}}, subscription::Ptr{aeron_subscription_t}, conductor::Ptr{aeron_client_conductor_t}, log_buffer::Ptr{aeron_log_buffer_t}, subscriber_position_id::Int32, subscriber_position::Ptr{Int64}, correlation_id::Int64, session_id::Int32, source_identity::Cstring, source_identity_length::Csize_t)::Cint
end

"""
    aeron_image_delete(image)

### Prototype
```c
int aeron_image_delete(aeron_image_t *image);
```
"""
function aeron_image_delete(image)
    @ccall libaeron.aeron_image_delete(image::Ptr{aeron_image_t})::Cint
end

"""
    aeron_image_force_close(image)

### Prototype
```c
void aeron_image_force_close(aeron_image_t *image);
```
"""
function aeron_image_force_close(image)
    @ccall libaeron.aeron_image_force_close(image::Ptr{aeron_image_t})::Cvoid
end

"""
    aeron_image_removal_change_number(image)

### Prototype
```c
inline int64_t aeron_image_removal_change_number(aeron_image_t *image);
```
"""
function aeron_image_removal_change_number(image)
    @ccall libaeron.aeron_image_removal_change_number(image::Ptr{aeron_image_t})::Int64
end

"""
    aeron_image_is_in_use_by_subscription(image, last_change_number)

### Prototype
```c
inline bool aeron_image_is_in_use_by_subscription(aeron_image_t *image, int64_t last_change_number);
```
"""
function aeron_image_is_in_use_by_subscription(image, last_change_number)
    @ccall libaeron.aeron_image_is_in_use_by_subscription(image::Ptr{aeron_image_t}, last_change_number::Int64)::Bool
end

"""
    aeron_image_validate_position(image, position)

### Prototype
```c
inline int aeron_image_validate_position(aeron_image_t *image, int64_t position);
```
"""
function aeron_image_validate_position(image, position)
    @ccall libaeron.aeron_image_validate_position(image::Ptr{aeron_image_t}, position::Int64)::Cint
end

"""
    aeron_image_incr_refcnt(image)

### Prototype
```c
inline int64_t aeron_image_incr_refcnt(aeron_image_t *image);
```
"""
function aeron_image_incr_refcnt(image)
    @ccall libaeron.aeron_image_incr_refcnt(image::Ptr{aeron_image_t})::Int64
end

"""
    aeron_image_decr_refcnt(image)

### Prototype
```c
inline int64_t aeron_image_decr_refcnt(aeron_image_t *image);
```
"""
function aeron_image_decr_refcnt(image)
    @ccall libaeron.aeron_image_decr_refcnt(image::Ptr{aeron_image_t})::Int64
end

"""
    aeron_image_refcnt_volatile(image)

### Prototype
```c
inline int64_t aeron_image_refcnt_volatile(aeron_image_t *image);
```
"""
function aeron_image_refcnt_volatile(image)
    @ccall libaeron.aeron_image_refcnt_volatile(image::Ptr{aeron_image_t})::Int64
end

# typedef int ( * aeron_uri_hostname_resolver_func_t ) ( void * clientd , const char * host , struct addrinfo * hints , struct addrinfo * * info )
const aeron_uri_hostname_resolver_func_t = Ptr{Cvoid}

# typedef int ( * aeron_getifaddrs_func_t ) ( struct ifaddrs * * )
const aeron_getifaddrs_func_t = Ptr{Cvoid}

# typedef void ( * aeron_freeifaddrs_func_t ) ( struct ifaddrs * )
const aeron_freeifaddrs_func_t = Ptr{Cvoid}

# typedef int ( * aeron_ifaddr_func_t ) ( void * clientd , const char * name , struct sockaddr * addr , struct sockaddr * netmask , unsigned int flags )
const aeron_ifaddr_func_t = Ptr{Cvoid}

"""
    aeron_ip_addr_resolver(host, sockaddr_, family_hint, protocol)

### Prototype
```c
int aeron_ip_addr_resolver(const char *host, struct sockaddr_storage *sockaddr, int family_hint, int protocol);
```
"""
function aeron_ip_addr_resolver(host, sockaddr_, family_hint, protocol)
    @ccall libaeron.aeron_ip_addr_resolver(host::Cstring, sockaddr_::Ptr{sockaddr_storage}, family_hint::Cint, protocol::Cint)::Cint
end

"""
    aeron_udp_port_resolver(port_str, optional)

### Prototype
```c
int aeron_udp_port_resolver(const char *port_str, bool optional);
```
"""
function aeron_udp_port_resolver(port_str, optional)
    @ccall libaeron.aeron_udp_port_resolver(port_str::Cstring, optional::Bool)::Cint
end

"""
    aeron_try_parse_ipv4(host, sockaddr_)

### Prototype
```c
bool aeron_try_parse_ipv4(const char *host, struct sockaddr_storage *sockaddr);
```
"""
function aeron_try_parse_ipv4(host, sockaddr_)
    @ccall libaeron.aeron_try_parse_ipv4(host::Cstring, sockaddr_::Ptr{sockaddr_storage})::Bool
end

"""
    aeron_ipv4_addr_resolver(host, protocol, sockaddr_)

### Prototype
```c
int aeron_ipv4_addr_resolver(const char *host, int protocol, struct sockaddr_storage *sockaddr);
```
"""
function aeron_ipv4_addr_resolver(host, protocol, sockaddr_)
    @ccall libaeron.aeron_ipv4_addr_resolver(host::Cstring, protocol::Cint, sockaddr_::Ptr{sockaddr_storage})::Cint
end

"""
    aeron_try_parse_ipv6(host, sockaddr_)

### Prototype
```c
bool aeron_try_parse_ipv6(const char *host, struct sockaddr_storage *sockaddr);
```
"""
function aeron_try_parse_ipv6(host, sockaddr_)
    @ccall libaeron.aeron_try_parse_ipv6(host::Cstring, sockaddr_::Ptr{sockaddr_storage})::Bool
end

"""
    aeron_ipv6_addr_resolver(host, protocol, sockaddr_)

### Prototype
```c
int aeron_ipv6_addr_resolver(const char *host, int protocol, struct sockaddr_storage *sockaddr);
```
"""
function aeron_ipv6_addr_resolver(host, protocol, sockaddr_)
    @ccall libaeron.aeron_ipv6_addr_resolver(host::Cstring, protocol::Cint, sockaddr_::Ptr{sockaddr_storage})::Cint
end

"""
    aeron_lookup_interfaces(func, clientd)

### Prototype
```c
int aeron_lookup_interfaces(aeron_ifaddr_func_t func, void *clientd);
```
"""
function aeron_lookup_interfaces(func, clientd)
    @ccall libaeron.aeron_lookup_interfaces(func::aeron_ifaddr_func_t, clientd::Ptr{Cvoid})::Cint
end

"""
    aeron_lookup_interfaces_from_ifaddrs(func, clientd, ifaddrs_)

### Prototype
```c
int aeron_lookup_interfaces_from_ifaddrs(aeron_ifaddr_func_t func, void *clientd, struct ifaddrs *ifaddrs);
```
"""
function aeron_lookup_interfaces_from_ifaddrs(func, clientd, ifaddrs_)
    @ccall libaeron.aeron_lookup_interfaces_from_ifaddrs(func::aeron_ifaddr_func_t, clientd::Ptr{Cvoid}, ifaddrs_::Ptr{ifaddrs})::Cint
end

"""
    aeron_set_getifaddrs(get_func, free_func)

### Prototype
```c
void aeron_set_getifaddrs(aeron_getifaddrs_func_t get_func, aeron_freeifaddrs_func_t free_func);
```
"""
function aeron_set_getifaddrs(get_func, free_func)
    @ccall libaeron.aeron_set_getifaddrs(get_func::aeron_getifaddrs_func_t, free_func::aeron_freeifaddrs_func_t)::Cvoid
end

"""
    aeron_interface_parse_and_resolve(interface_str, sockaddr_, prefixlen)

### Prototype
```c
int aeron_interface_parse_and_resolve(const char *interface_str, struct sockaddr_storage *sockaddr, size_t *prefixlen);
```
"""
function aeron_interface_parse_and_resolve(interface_str, sockaddr_, prefixlen)
    @ccall libaeron.aeron_interface_parse_and_resolve(interface_str::Cstring, sockaddr_::Ptr{sockaddr_storage}, prefixlen::Ptr{Csize_t})::Cint
end

"""
    aeron_set_ipv4_wildcard_host_and_port(sockaddr_)

### Prototype
```c
void aeron_set_ipv4_wildcard_host_and_port(struct sockaddr_storage *sockaddr);
```
"""
function aeron_set_ipv4_wildcard_host_and_port(sockaddr_)
    @ccall libaeron.aeron_set_ipv4_wildcard_host_and_port(sockaddr_::Ptr{sockaddr_storage})::Cvoid
end

"""
    aeron_set_ipv6_wildcard_host_and_port(sockaddr_)

### Prototype
```c
void aeron_set_ipv6_wildcard_host_and_port(struct sockaddr_storage *sockaddr);
```
"""
function aeron_set_ipv6_wildcard_host_and_port(sockaddr_)
    @ccall libaeron.aeron_set_ipv6_wildcard_host_and_port(sockaddr_::Ptr{sockaddr_storage})::Cvoid
end

"""
    aeron_ipv4_does_prefix_match(in_addr1, in_addr2, prefixlen)

### Prototype
```c
bool aeron_ipv4_does_prefix_match(struct in_addr *in_addr1, struct in_addr *in_addr2, size_t prefixlen);
```
"""
function aeron_ipv4_does_prefix_match(in_addr1, in_addr2, prefixlen)
    @ccall libaeron.aeron_ipv4_does_prefix_match(in_addr1::Ptr{Cvoid}, in_addr2::Ptr{Cvoid}, prefixlen::Csize_t)::Bool
end

"""
    aeron_ipv6_does_prefix_match(in6_addr1, in6_addr2, prefixlen)

### Prototype
```c
bool aeron_ipv6_does_prefix_match(struct in6_addr *in6_addr1, struct in6_addr *in6_addr2, size_t prefixlen);
```
"""
function aeron_ipv6_does_prefix_match(in6_addr1, in6_addr2, prefixlen)
    @ccall libaeron.aeron_ipv6_does_prefix_match(in6_addr1::Ptr{Cvoid}, in6_addr2::Ptr{Cvoid}, prefixlen::Csize_t)::Bool
end

"""
    aeron_ipv4_netmask_to_prefixlen(netmask)

### Prototype
```c
size_t aeron_ipv4_netmask_to_prefixlen(struct in_addr *netmask);
```
"""
function aeron_ipv4_netmask_to_prefixlen(netmask)
    @ccall libaeron.aeron_ipv4_netmask_to_prefixlen(netmask::Ptr{Cvoid})::Csize_t
end

"""
    aeron_ipv6_netmask_to_prefixlen(netmask)

### Prototype
```c
size_t aeron_ipv6_netmask_to_prefixlen(struct in6_addr *netmask);
```
"""
function aeron_ipv6_netmask_to_prefixlen(netmask)
    @ccall libaeron.aeron_ipv6_netmask_to_prefixlen(netmask::Ptr{Cvoid})::Csize_t
end

"""
    aeron_find_interface(interface_str, if_addr, if_index)

### Prototype
```c
int aeron_find_interface(const char *interface_str, struct sockaddr_storage *if_addr, unsigned int *if_index);
```
"""
function aeron_find_interface(interface_str, if_addr, if_index)
    @ccall libaeron.aeron_find_interface(interface_str::Cstring, if_addr::Ptr{sockaddr_storage}, if_index::Ptr{Cuint})::Cint
end

"""
    aeron_find_unicast_interface(family, interface_str, interface_addr, interface_index)

### Prototype
```c
int aeron_find_unicast_interface( int family, const char *interface_str, struct sockaddr_storage *interface_addr, unsigned int *interface_index);
```
"""
function aeron_find_unicast_interface(family, interface_str, interface_addr, interface_index)
    @ccall libaeron.aeron_find_unicast_interface(family::Cint, interface_str::Cstring, interface_addr::Ptr{sockaddr_storage}, interface_index::Ptr{Cuint})::Cint
end

"""
    aeron_is_addr_multicast(addr)

### Prototype
```c
bool aeron_is_addr_multicast(struct sockaddr_storage *addr);
```
"""
function aeron_is_addr_multicast(addr)
    @ccall libaeron.aeron_is_addr_multicast(addr::Ptr{sockaddr_storage})::Bool
end

"""
    aeron_is_wildcard_addr(addr)

### Prototype
```c
bool aeron_is_wildcard_addr(struct sockaddr_storage *addr);
```
"""
function aeron_is_wildcard_addr(addr)
    @ccall libaeron.aeron_is_wildcard_addr(addr::Ptr{sockaddr_storage})::Bool
end

"""
    aeron_is_wildcard_port(addr)

### Prototype
```c
bool aeron_is_wildcard_port(struct sockaddr_storage *addr);
```
"""
function aeron_is_wildcard_port(addr)
    @ccall libaeron.aeron_is_wildcard_port(addr::Ptr{sockaddr_storage})::Bool
end

"""
    aeron_format_source_identity(buffer, length, addr)

### Prototype
```c
int aeron_format_source_identity(char *buffer, size_t length, struct sockaddr_storage *addr);
```
"""
function aeron_format_source_identity(buffer, length, addr)
    @ccall libaeron.aeron_format_source_identity(buffer::Cstring, length::Csize_t, addr::Ptr{sockaddr_storage})::Cint
end

"""
    aeron_netutil_get_so_buf_lengths(default_so_rcvbuf, default_so_sndbuf)

### Prototype
```c
int aeron_netutil_get_so_buf_lengths(size_t *default_so_rcvbuf, size_t *default_so_sndbuf);
```
"""
function aeron_netutil_get_so_buf_lengths(default_so_rcvbuf, default_so_sndbuf)
    @ccall libaeron.aeron_netutil_get_so_buf_lengths(default_so_rcvbuf::Ptr{Csize_t}, default_so_sndbuf::Ptr{Csize_t})::Cint
end

mutable struct __pthread_mutex_s
    __lock::Cint
    __count::Cuint
    __owner::Cint
    __nusers::Cuint
    __kind::Cint
    __spins::Cint
    __list::__pthread_list_t
    __pthread_mutex_s() = new()
end

mutable struct var"##Ctag#2338"
    head::UInt64
    padding::NTuple{56, Int8}
    var"##Ctag#2338"() = new()
end
function Base.getproperty(x::Ptr{var"##Ctag#2338"}, f::Symbol)
    f === :head && return Ptr{UInt64}(x + 0)
    f === :padding && return Ptr{NTuple{56, Int8}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#2338", f::Symbol)
    r = Ref{var"##Ctag#2338"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#2338"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#2338"}, f::Symbol, v)
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
