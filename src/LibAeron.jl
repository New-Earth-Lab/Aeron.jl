module LibAeron
using Aeron_jll
using CEnum

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

mutable struct aeron_context_stct end

const aeron_context_t = aeron_context_stct

mutable struct aeron_stct end

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

mutable struct aeron_publication_stct end

const aeron_publication_t = aeron_publication_stct

mutable struct aeron_exclusive_publication_stct end

const aeron_exclusive_publication_t = aeron_exclusive_publication_stct

mutable struct aeron_header_stct end

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

mutable struct aeron_subscription_stct end

const aeron_subscription_t = aeron_subscription_stct

mutable struct aeron_image_stct end

const aeron_image_t = aeron_image_stct

mutable struct aeron_counter_stct end

const aeron_counter_t = aeron_counter_stct

mutable struct aeron_log_buffer_stct end

const aeron_log_buffer_t = aeron_log_buffer_stct

mutable struct aeron_counters_reader_stct end

const aeron_counters_reader_t = aeron_counters_reader_stct

mutable struct aeron_client_registering_resource_stct end

const aeron_async_add_publication_t = aeron_client_registering_resource_stct

const aeron_async_add_exclusive_publication_t = aeron_client_registering_resource_stct

const aeron_async_add_subscription_t = aeron_client_registering_resource_stct

const aeron_async_add_counter_t = aeron_client_registering_resource_stct

const aeron_async_destination_t = aeron_client_registering_resource_stct

mutable struct aeron_image_fragment_assembler_stct end

const aeron_image_fragment_assembler_t = aeron_image_fragment_assembler_stct

mutable struct aeron_image_controlled_fragment_assembler_stct end

const aeron_image_controlled_fragment_assembler_t = aeron_image_controlled_fragment_assembler_stct

mutable struct aeron_fragment_assembler_stct end

const aeron_fragment_assembler_t = aeron_fragment_assembler_stct

mutable struct aeron_controlled_fragment_assembler_stct end

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

# typedef void ( * aeron_error_handler_t ) ( void * clientd , int errcode , const char * message )
"""
The error handler to be called when an error occurs.
"""
const aeron_error_handler_t = Ptr{Cvoid}

# typedef void ( * aeron_notification_t ) ( void * clientd )
"""
Generalised notification callback.
"""
const aeron_notification_t = Ptr{Cvoid}

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

# typedef void ( * aeron_on_close_client_t ) ( void * clientd )
"""
Function called by aeron\\_client\\_t to deliver notifications that the client is closing.

### Parameters
* `clientd`: to be returned in the call.
"""
const aeron_on_close_client_t = Ptr{Cvoid}

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

# typedef void ( * aeron_agent_on_start_func_t ) ( void * state , const char * role_name )
const aeron_agent_on_start_func_t = Ptr{Cvoid}

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

mutable struct aeron_on_available_counter_pair_stct
    handler::aeron_on_available_counter_t
    clientd::Ptr{Cvoid}
    aeron_on_available_counter_pair_stct() = new()
end

const aeron_on_available_counter_pair_t = aeron_on_available_counter_pair_stct

mutable struct aeron_on_unavailable_counter_pair_stct
    handler::aeron_on_unavailable_counter_t
    clientd::Ptr{Cvoid}
    aeron_on_unavailable_counter_pair_stct() = new()
end

const aeron_on_unavailable_counter_pair_t = aeron_on_unavailable_counter_pair_stct

mutable struct aeron_on_close_client_pair_stct
    handler::aeron_on_close_client_t
    clientd::Ptr{Cvoid}
    aeron_on_close_client_pair_stct() = new()
end

const aeron_on_close_client_pair_t = aeron_on_close_client_pair_stct

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

@cenum aeron_controlled_fragment_handler_action_en::UInt32 begin
    AERON_ACTION_ABORT = 1
    AERON_ACTION_BREAK = 2
    AERON_ACTION_COMMIT = 3
    AERON_ACTION_CONTINUE = 4
end

const aeron_controlled_fragment_handler_action_t = aeron_controlled_fragment_handler_action_en

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

# typedef int64_t ( * aeron_clock_func_t ) ( void )
"""
Clock function used by aeron.
"""
const aeron_clock_func_t = Ptr{Cvoid}

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

const aeron_thread_t = pthread_t

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

# typedef void ( * aeron_idle_strategy_func_t ) ( void * state , int work_count )
const aeron_idle_strategy_func_t = Ptr{Cvoid}

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

# typedef int ( * aeron_agent_do_work_func_t ) ( void * )
const aeron_agent_do_work_func_t = Ptr{Cvoid}

# typedef void ( * aeron_agent_on_close_func_t ) ( void * )
const aeron_agent_on_close_func_t = Ptr{Cvoid}

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

mutable struct aeron_agent_runner_stct
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
    aeron_agent_runner_stct() = new()
end

const aeron_agent_runner_t = aeron_agent_runner_stct

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

const AERON_NULL_VALUE = -1

const AERON_CLIENT_ERROR_DRIVER_TIMEOUT = -1000

const AERON_CLIENT_ERROR_CLIENT_TIMEOUT = -1001

const AERON_CLIENT_ERROR_CONDUCTOR_SERVICE_TIMEOUT = -1002

const AERON_CLIENT_ERROR_BUFFER_FULL = -1003

const AERON_CLIENT_MAX_LOCAL_ADDRESS_STR_LEN = 64

const AERON_DIR_ENV_VAR = "AERON_DIR"

const AERON_DRIVER_TIMEOUT_ENV_VAR = "AERON_DRIVER_TIMEOUT"

const AERON_CLIENT_RESOURCE_LINGER_DURATION_ENV_VAR = "AERON_CLIENT_RESOURCE_LINGER_DURATION"

const AERON_CLIENT_PRE_TOUCH_MAPPED_MEMORY_ENV_VAR = "AERON_CLIENT_PRE_TOUCH_MAPPED_MEMORY"

const AERON_AGENT_ON_START_FUNCTION_ENV_VAR = "AERON_AGENT_ON_START_FUNCTION"

const AERON_COUNTER_CACHE_LINE_LENGTH = Cuint(64)

# Skipping MacroDefinition: AERON_COUNTER_VALUE_LENGTH sizeof ( aeron_counter_value_descriptor_t )

const AERON_COUNTER_REGISTRATION_ID_OFFSET = offsetof(aeron_counter_value_descriptor_t, registration_id)

# Skipping MacroDefinition: AERON_COUNTER_METADATA_LENGTH sizeof ( aeron_counter_metadata_descriptor_t )

const AERON_COUNTER_TYPE_ID_OFFSET = offsetof(aeron_counter_metadata_descriptor_t, type_id)

const AERON_COUNTER_FREE_FOR_REUSE_DEADLINE_OFFSET = offsetof(aeron_counter_metadata_descriptor_t, free_for_reuse_deadline_ms)

const AERON_COUNTER_KEY_OFFSET = offsetof(aeron_counter_metadata_descriptor_t, key)

const AERON_COUNTER_LABEL_LENGTH_OFFSET = offsetof(aeron_counter_metadata_descriptor_t, label)

# Skipping MacroDefinition: AERON_COUNTER_MAX_LABEL_LENGTH sizeof ( ( ( aeron_counter_metadata_descriptor_t * ) NULL ) -> label )

# Skipping MacroDefinition: AERON_COUNTER_MAX_KEY_LENGTH sizeof ( ( ( aeron_counter_metadata_descriptor_t * ) NULL ) -> key )

const AERON_COUNTER_RECORD_UNUSED = 0

const AERON_COUNTER_RECORD_ALLOCATED = 1

const AERON_COUNTER_RECORD_RECLAIMED = -1

const AERON_COUNTER_REGISTRATION_ID_DEFAULT = INT64_C(0)

const AERON_COUNTER_NOT_FREE_TO_REUSE = INT64_MAX

const AERON_COUNTER_OWNER_ID_DEFAULT = INT64_C(0)

const AERON_NULL_COUNTER_ID = -1

const AERON_PUBLICATION_NOT_CONNECTED = -(Clong(1))

const AERON_PUBLICATION_BACK_PRESSURED = -(Clong(2))

const AERON_PUBLICATION_ADMIN_ACTION = -(Clong(3))

const AERON_PUBLICATION_CLOSED = -(Clong(4))

const AERON_PUBLICATION_MAX_POSITION_EXCEEDED = -(Clong(5))

const AERON_PUBLICATION_ERROR = -(Clong(6))

const AERON_COMPILER_GCC = 1

const AERON_COMPILER_LLVM = 1

const AERON_CPU_X64 = 1

const AERON_FORMAT_NUMBER_TO_LOCALE_STR_LEN = 32

const AERON_EXPORT = __declspec(dllimport)

const AERON_MAX_HOST_LENGTH = 384

const AERON_MAX_PORT_LENGTH = 8

const AERON_MAX_PREFIX_LENGTH = 8

# const AERON_INIT_ONCE = pthread_once_t

# const AERON_INIT_ONCE_VALUE = PTHREAD_ONCE_INIT

# const aeron_mutex_init = pthread_mutex_init

# const aeron_mutex_lock = pthread_mutex_lock

# const aeron_mutex_unlock = pthread_mutex_unlock

# const aeron_mutex_destroy = pthread_mutex_destroy

# const aeron_thread_once = pthread_once

# const aeron_thread_attr_init = pthread_attr_init

# const aeron_thread_create = pthread_create

# const aeron_thread_join = pthread_join

# const aeron_thread_key_create = pthread_key_create

# const aeron_thread_key_delete = pthread_key_delete

# const aeron_thread_get_specific = pthread_getspecific

# const aeron_thread_set_specific = pthread_setspecific

const AERON_MAX_PATH = 384

const AERON_AGENT_STATE_UNUSED = 0

const AERON_AGENT_STATE_INITED = 1

const AERON_AGENT_STATE_STARTED = 2

const AERON_AGENT_STATE_MANUAL = 3

const AERON_AGENT_STATE_STOPPING = 4

const AERON_AGENT_STATE_STOPPED = 5

const AERON_IDLE_STRATEGY_BACKOFF_MAX_SPINS = 10

const AERON_IDLE_STRATEGY_BACKOFF_MAX_YIELDS = 20

const AERON_IDLE_STRATEGY_BACKOFF_MIN_PARK_PERIOD_NS = Clonglong(1000)

const AERON_IDLE_STRATEGY_BACKOFF_MAX_PARK_PERIOD_NS = 1 * 1000 * Clonglong(1000)

const AERON_RES_HEADER_ADDRESS_LENGTH_IP4 = Cuint(4)

const AERON_RES_HEADER_ADDRESS_LENGTH_IP6 = Cuint(16)

const AERON_FRAME_HEADER_VERSION = 0

const AERON_HDR_TYPE_PAD = 0x00

const AERON_HDR_TYPE_DATA = 0x01

const AERON_HDR_TYPE_NAK = 0x02

const AERON_HDR_TYPE_SM = 0x03

const AERON_HDR_TYPE_ERR = 0x04

const AERON_HDR_TYPE_SETUP = 0x05

const AERON_HDR_TYPE_RTTM = 0x06

const AERON_HDR_TYPE_RES = 0x07

const AERON_HDR_TYPE_ATS_DATA = 0x08

const AERON_HDR_TYPE_ATS_SETUP = 0x09

const AERON_HDR_TYPE_ATS_SM = 0x0a

const AERON_HDR_TYPE_EXT = 0xffff

# Skipping MacroDefinition: AERON_DATA_HEADER_LENGTH ( sizeof ( aeron_data_header_t ) )

const AERON_DATA_HEADER_BEGIN_FLAG = UINT8_C(0x80)

const AERON_DATA_HEADER_END_FLAG = UINT8_C(0x40)

const AERON_DATA_HEADER_EOS_FLAG = UINT8_C(0x20)

const AERON_DATA_HEADER_UNFRAGMENTED = UINT8_C(AERON_DATA_HEADER_BEGIN_FLAG | AERON_DATA_HEADER_END_FLAG)

const AERON_DATA_HEADER_DEFAULT_RESERVED_VALUE = INT64_C(0)

const AERON_STATUS_MESSAGE_HEADER_SEND_SETUP_FLAG = UINT8_C(0x80)

const AERON_STATUS_MESSAGE_HEADER_EOS_FLAG = UINT8_C(0x40)

const AERON_RTTM_HEADER_REPLY_FLAG = UINT8_C(0x80)

const AERON_RES_HEADER_TYPE_NAME_TO_IP4_MD = 0x01

const AERON_RES_HEADER_TYPE_NAME_TO_IP6_MD = 0x02

const AERON_RES_HEADER_SELF_FLAG = UINT8_C(0x80)

const AERON_FRAME_MAX_MESSAGE_LENGTH = Cuint(16) * Cuint(1024) * Cuint(1024)

const AERON_OPTION_HEADER_IGNORE_FLAG = UINT16_C(0x8000)

const AERON_OPT_HDR_TYPE_ATS_SUITE = UINT16_C(0x0001)

const AERON_OPT_HDR_TYPE_ATS_RSA_KEY = UINT16_C(0x0002)

const AERON_OPT_HDR_TYPE_ATS_RSA_KEY_ID = UINT16_C(0x0003)

const AERON_OPT_HDR_TYPE_ATS_EC_KEY = UINT16_C(0x0004)

const AERON_OPT_HDR_TYPE_ATS_EC_SIG = UINT16_C(0x0005)

const AERON_OPT_HDR_TYPE_ATS_SECRET = UINT16_C(0x0006)

const AERON_OPT_HDR_TYPE_ATS_GROUP_TAG = UINT16_C(0x0007)

const AERON_OPT_HDR_ALIGNMENT = Cuint(4)


# Ignore these bad macro translations by setting this dummy function
# offsetof(args...) = nothing
# registration_id=nothing
# type_id=nothing
# free_for_reuse_deadline_ms=nothing
# key=nothing
# label=nothing
# PTHREAD_ONCE_INIT=nothing
# pthread_once_t=nothing
# pthread_mutex_init=nothing
# pthread_mutex_lock=nothing
# pthread_mutex_unlock=nothing
# pthread_mutex_destroy=nothing
# pthread_once=nothing
# pthread_attr_init=nothing
# pthread_create=nothing
# pthread_join=nothing
# pthread_key_create=nothing
# pthread_key_delete=nothing
# pthread_getspecific=nothing
# pthread_setspecific=nothing
# __FILE__=nothing
# strrchr(args...)=nothing
# dllimport=nothing
# __declspec(args...)=nothing
const AERON_NULL_VALUE = -1
const AERON_CLIENT_ERROR_DRIVER_TIMEOUT = -1000
const AERON_CLIENT_ERROR_CLIENT_TIMEOUT = -1001
const AERON_CLIENT_ERROR_CONDUCTOR_SERVICE_TIMEOUT = -1002
const AERON_CLIENT_ERROR_BUFFER_FULL = -1003
const AERON_CLIENT_MAX_LOCAL_ADDRESS_STR_LEN = 64
const AERON_DIR_ENV_VAR = "AERON_DIR"
const AERON_DRIVER_TIMEOUT_ENV_VAR = "AERON_DRIVER_TIMEOUT"
const AERON_CLIENT_RESOURCE_LINGER_DURATION_ENV_VAR = "AERON_CLIENT_RESOURCE_LINGER_DURATION"
const AERON_CLIENT_PRE_TOUCH_MAPPED_MEMORY_ENV_VAR = "AERON_CLIENT_PRE_TOUCH_MAPPED_MEMORY"
const AERON_AGENT_ON_START_FUNCTION_ENV_VAR = "AERON_AGENT_ON_START_FUNCTION"
const AERON_COUNTER_CACHE_LINE_LENGTH = Cuint(64)

# Skipping MacroDefinition: AERON_COUNTER_VALUE_LENGTH sizeof ( aeron_counter_value_descriptor_t )
# const AERON_COUNTER_REGISTRATION_ID_OFFSET = offsetof(aeron_counter_value_descriptor_t, registration_id)

# Skipping MacroDefinition: AERON_COUNTER_METADATA_LENGTH sizeof ( aeron_counter_metadata_descriptor_t )
# const AERON_COUNTER_TYPE_ID_OFFSET = offsetof(aeron_counter_metadata_descriptor_t, type_id)
# const AERON_COUNTER_FREE_FOR_REUSE_DEADLINE_OFFSET = offsetof(aeron_counter_metadata_descriptor_t, free_for_reuse_deadline_ms)
# const AERON_COUNTER_KEY_OFFSET = offsetof(aeron_counter_metadata_descriptor_t, key)
# const AERON_COUNTER_LABEL_LENGTH_OFFSET = offsetof(aeron_counter_metadata_descriptor_t, label)

# Skipping MacroDefinition: AERON_COUNTER_MAX_LABEL_LENGTH sizeof ( ( ( aeron_counter_metadata_descriptor_t * ) NULL ) -> label )

# Skipping MacroDefinition: AERON_COUNTER_MAX_KEY_LENGTH sizeof ( ( ( aeron_counter_metadata_descriptor_t * ) NULL ) -> key )
const AERON_COUNTER_RECORD_UNUSED = 0
const AERON_COUNTER_RECORD_ALLOCATED = 1
const AERON_COUNTER_RECORD_RECLAIMED = -1
const AERON_COUNTER_REGISTRATION_ID_DEFAULT = INT64_C(0)
const AERON_COUNTER_NOT_FREE_TO_REUSE = INT64_MAX
const AERON_COUNTER_OWNER_ID_DEFAULT = INT64_C(0)
const AERON_NULL_COUNTER_ID = -1
const AERON_PUBLICATION_NOT_CONNECTED = -(Clong(1))
const AERON_PUBLICATION_BACK_PRESSURED = -(Clong(2))
const AERON_PUBLICATION_ADMIN_ACTION = -(Clong(3))
const AERON_PUBLICATION_CLOSED = -(Clong(4))
const AERON_PUBLICATION_MAX_POSITION_EXCEEDED = -(Clong(5))
const AERON_PUBLICATION_ERROR = -(Clong(6))
const AERON_COMPILER_GCC = 1
const AERON_COMPILER_LLVM = 1
const AERON_CPU_X64 = 1
const AERON_CACHE_LINE_LENGTH = Cuint(64)
# const AERON_INIT_ONCE = pthread_once_t
# const AERON_INIT_ONCE_VALUE = PTHREAD_ONCE_INIT
# const aeron_mutex_init = pthread_mutex_init
# const aeron_mutex_lock = pthread_mutex_lock
# const aeron_mutex_unlock = pthread_mutex_unlock
# const aeron_mutex_destroy = pthread_mutex_destroy
# const aeron_thread_once = pthread_once
# const aeron_thread_attr_init = pthread_attr_init
# const aeron_thread_create = pthread_create
# const aeron_thread_join = pthread_join
# const aeron_thread_key_create = pthread_key_create
# const aeron_thread_key_delete = pthread_key_delete
# const aeron_thread_get_specific = pthread_getspecific
# const aeron_thread_set_specific = pthread_setspecific

# Skipping MacroDefinition: AERON_ERROR_LOG_HEADER_LENGTH ( sizeof ( aeron_error_log_entry_t ) )

# Skipping MacroDefinition: AERON_ERROR_LOG_RECORD_ALIGNMENT ( sizeof ( int64_t ) )
const AERON_MAX_PATH = 384
const AERON_ERROR_MAX_TOTAL_LENGTH = 8192

const AERON_RES_HEADER_ADDRESS_LENGTH_IP4 = Cuint(4)
const AERON_RES_HEADER_ADDRESS_LENGTH_IP6 = Cuint(16)
const AERON_FRAME_HEADER_VERSION = 0
const AERON_HDR_TYPE_PAD = 0x00
const AERON_HDR_TYPE_DATA = 0x01
const AERON_HDR_TYPE_NAK = 0x02
const AERON_HDR_TYPE_SM = 0x03
const AERON_HDR_TYPE_ERR = 0x04
const AERON_HDR_TYPE_SETUP = 0x05
const AERON_HDR_TYPE_RTTM = 0x06
const AERON_HDR_TYPE_RES = 0x07
const AERON_HDR_TYPE_ATS_DATA = 0x08
const AERON_HDR_TYPE_ATS_SETUP = 0x09
const AERON_HDR_TYPE_ATS_SM = 0x0a
const AERON_HDR_TYPE_EXT = 0xffff

# Skipping MacroDefinition: AERON_DATA_HEADER_LENGTH ( sizeof ( aeron_data_header_t ) )
const AERON_DATA_HEADER_BEGIN_FLAG = UINT8_C(0x80)
const AERON_DATA_HEADER_END_FLAG = UINT8_C(0x40)
const AERON_DATA_HEADER_EOS_FLAG = UINT8_C(0x20)
const AERON_DATA_HEADER_UNFRAGMENTED = UINT8_C(AERON_DATA_HEADER_BEGIN_FLAG | AERON_DATA_HEADER_END_FLAG)
const AERON_DATA_HEADER_DEFAULT_RESERVED_VALUE = INT64_C(0)
const AERON_STATUS_MESSAGE_HEADER_SEND_SETUP_FLAG = UINT8_C(0x80)
const AERON_STATUS_MESSAGE_HEADER_EOS_FLAG = UINT8_C(0x40)
const AERON_RTTM_HEADER_REPLY_FLAG = UINT8_C(0x80)
const AERON_RES_HEADER_TYPE_NAME_TO_IP4_MD = 0x01
const AERON_RES_HEADER_TYPE_NAME_TO_IP6_MD = 0x02
const AERON_RES_HEADER_SELF_FLAG = UINT8_C(0x80)
const AERON_FRAME_MAX_MESSAGE_LENGTH = Cuint(16) * Cuint(1024) * Cuint(1024)
const AERON_OPTION_HEADER_IGNORE_FLAG = UINT16_C(0x8000)
const AERON_OPT_HDR_TYPE_ATS_SUITE = UINT16_C(0x0001)
const AERON_OPT_HDR_TYPE_ATS_RSA_KEY = UINT16_C(0x0002)
const AERON_OPT_HDR_TYPE_ATS_RSA_KEY_ID = UINT16_C(0x0003)
const AERON_OPT_HDR_TYPE_ATS_EC_KEY = UINT16_C(0x0004)
const AERON_OPT_HDR_TYPE_ATS_EC_SIG = UINT16_C(0x0005)
const AERON_OPT_HDR_TYPE_ATS_SECRET = UINT16_C(0x0006)
const AERON_OPT_HDR_TYPE_ATS_GROUP_TAG = UINT16_C(0x0007)
const AERON_OPT_HDR_ALIGNMENT = Cuint(4)
const AERON_LOGBUFFER_PARTITION_COUNT = 3
const AERON_LOGBUFFER_TERM_MIN_LENGTH = 64 * 1024
const AERON_LOGBUFFER_TERM_MAX_LENGTH = 1024 * 1024 * 1024
const AERON_PAGE_MIN_SIZE = 4 * 1024
const AERON_PAGE_MAX_SIZE = 1024 * 1024 * 1024
const AERON_LOGBUFFER_DEFAULT_FRAME_HEADER_MAX_LENGTH = AERON_CACHE_LINE_LENGTH * 2
const AERON_MAX_UDP_PAYLOAD_LENGTH = 65504

# Skipping MacroDefinition: AERON_LOGBUFFER_META_DATA_LENGTH ( AERON_ALIGN ( ( sizeof ( aeron_logbuffer_metadata_t ) + AERON_LOGBUFFER_DEFAULT_FRAME_HEADER_MAX_LENGTH ) , AERON_PAGE_MIN_SIZE ) )
const AERON_LOGBUFFER_FRAME_ALIGNMENT = 32
const AERON_MAP_DEFAULT_LOAD_FACTOR = Float32(0.65)
const AERON_PROPERTIES_MAX_LENGTH = 2048
const AERON_HTTP_PROPERTIES_TIMEOUT_NS = 10 * 1000 * 1000 * Clonglong(1000)
const AERON_LOSS_REPORT_FILE = "loss-report.dat"
const AERON_LOSS_REPORTER_ENTRY_ALIGNMENT = AERON_CACHE_LINE_LENGTH
# const aeron_dlsym = dlsym
# const aeron_dlerror = dlerror
const AERON_AGENT_STATE_UNUSED = 0
const AERON_AGENT_STATE_INITED = 1
const AERON_AGENT_STATE_STARTED = 2
const AERON_AGENT_STATE_MANUAL = 3
const AERON_AGENT_STATE_STOPPING = 4
const AERON_AGENT_STATE_STOPPED = 5
const AERON_IDLE_STRATEGY_BACKOFF_MAX_SPINS = 10
const AERON_IDLE_STRATEGY_BACKOFF_MAX_YIELDS = 20
const AERON_IDLE_STRATEGY_BACKOFF_MIN_PARK_PERIOD_NS = Clonglong(1000)
const AERON_IDLE_STRATEGY_BACKOFF_MAX_PARK_PERIOD_NS = 1 * 1000 * Clonglong(1000)
# const aeron_mkdir = mkdir
# const aeron_ftruncate = ftruncate
const AERON_PUBLICATIONS_DIR = "publications"
const AERON_IMAGES_DIR = "images"
const AERON_CNC_FILE = "cnc.dat"
const AERON_CLIENT_COMMAND_QUEUE_CAPACITY = 256

# Skipping MacroDefinition: AERON_BROADCAST_BUFFER_TRAILER_LENGTH ( sizeof ( aeron_broadcast_descriptor_t ) )
const AERON_BROADCAST_PADDING_MSG_TYPE_ID = -1

# Skipping MacroDefinition: AERON_BROADCAST_RECORD_HEADER_LENGTH ( sizeof ( aeron_broadcast_record_descriptor_t ) )
const AERON_BROADCAST_SCRATCH_BUFFER_LENGTH = Cuint(4096)

# Skipping MacroDefinition: AERON_RB_TRAILER_LENGTH ( sizeof ( aeron_rb_descriptor_t ) )

# Skipping MacroDefinition: AERON_RB_ALIGNMENT ( 2 * sizeof ( int32_t ) )

# Skipping MacroDefinition: AERON_RB_RECORD_HEADER_LENGTH ( sizeof ( aeron_rb_record_descriptor_t ) )
const AERON_RB_PADDING_MSG_TYPE_ID = -1
# const AERON_MPSC_RB_MIN_CAPACITY = AERON_RB_RECORD_HEADER_LENGTH
const AERON_COMMAND_ADD_PUBLICATION = 0x01
const AERON_COMMAND_REMOVE_PUBLICATION = 0x02
const AERON_COMMAND_ADD_EXCLUSIVE_PUBLICATION = 0x03
const AERON_COMMAND_ADD_SUBSCRIPTION = 0x04
const AERON_COMMAND_REMOVE_SUBSCRIPTION = 0x05
const AERON_COMMAND_CLIENT_KEEPALIVE = 0x06
const AERON_COMMAND_ADD_DESTINATION = 0x07
const AERON_COMMAND_REMOVE_DESTINATION = 0x08
const AERON_COMMAND_ADD_COUNTER = 0x09
const AERON_COMMAND_REMOVE_COUNTER = 0x0a
const AERON_COMMAND_CLIENT_CLOSE = 0x0b
const AERON_COMMAND_ADD_RCV_DESTINATION = 0x0c
const AERON_COMMAND_REMOVE_RCV_DESTINATION = 0x0d
const AERON_COMMAND_TERMINATE_DRIVER = 0x0e
const AERON_RESPONSE_ON_ERROR = 0x0f01
const AERON_RESPONSE_ON_AVAILABLE_IMAGE = 0x0f02
const AERON_RESPONSE_ON_PUBLICATION_READY = 0x0f03
const AERON_RESPONSE_ON_OPERATION_SUCCESS = 0x0f04
const AERON_RESPONSE_ON_UNAVAILABLE_IMAGE = 0x0f05
const AERON_RESPONSE_ON_EXCLUSIVE_PUBLICATION_READY = 0x0f06
const AERON_RESPONSE_ON_SUBSCRIPTION_READY = 0x0f07
const AERON_RESPONSE_ON_COUNTER_READY = 0x0f08
const AERON_RESPONSE_ON_UNAVAILABLE_COUNTER = 0x0f09
const AERON_RESPONSE_ON_CLIENT_TIMEOUT = 0x0f0a
const AERON_ERROR_CODE_UNKNOWN_CODE_VALUE = -1
const AERON_ERROR_CODE_UNUSED = 0
const AERON_ERROR_CODE_INVALID_CHANNEL = 1
const AERON_ERROR_CODE_UNKNOWN_SUBSCRIPTION = 2
const AERON_ERROR_CODE_UNKNOWN_PUBLICATION = 3
const AERON_ERROR_CODE_CHANNEL_ENDPOINT_ERROR = 4
const AERON_ERROR_CODE_UNKNOWN_COUNTER = 5
const AERON_ERROR_CODE_UNKNOWN_COMMAND_TYPE_ID = 6
const AERON_ERROR_CODE_MALFORMED_COMMAND = 7
const AERON_ERROR_CODE_NOT_SUPPORTED = 8
const AERON_ERROR_CODE_UNKNOWN_HOST = 9
const AERON_ERROR_CODE_RESOURCE_TEMPORARILY_UNAVAILABLE = 10
const AERON_ERROR_CODE_GENERIC_ERROR = 11

# Skipping MacroDefinition: AERON_COUNTERS_MANAGER_VALUE_LENGTH ( sizeof ( aeron_counter_value_descriptor_t ) )

# Skipping MacroDefinition: AERON_COUNTERS_MANAGER_METADATA_LENGTH ( sizeof ( aeron_counter_metadata_descriptor_t ) )
const AERON_COUNTER_CHANNEL_ENDPOINT_STATUS_INITIALIZING = 0
const AERON_COUNTER_CHANNEL_ENDPOINT_STATUS_ERRORED = -1
const AERON_COUNTER_CHANNEL_ENDPOINT_STATUS_NO_ID_ALLOCATED = -1
const AERON_COUNTER_CHANNEL_ENDPOINT_STATUS_ACTIVE = INT64_C(1)
const AERON_COUNTER_CHANNEL_ENDPOINT_STATUS_CLOSING = INT64_C(2)
const AERON_CLIENT_COMMAND_QUEUE_FAIL_THRESHOLD = 10
const AERON_CLIENT_COMMAND_RB_FAIL_THRESHOLD = 10
const AERON_CLIENT_CONDUCTOR_IDLE_SLEEP_NS = 16 * 1000 * Clong(1000)
# const aeron_erand48 = erand48
# const aeron_srand48 = srand48
# const aeron_drand48 = drand48
# const aeron_strndup = strndup
const AERON_FORMAT_NUMBER_TO_LOCALE_STR_LEN = 32
# const AERON_EXPORT = __declspec(dllimport)
const AERON_COUNTER_SYSTEM_COUNTER_TYPE_ID = 0
const AERON_COUNTER_PUBLISHER_LIMIT_NAME = "pub-lmt"
const AERON_COUNTER_PUBLISHER_LIMIT_TYPE_ID = 1
const AERON_COUNTER_SENDER_POSITION_NAME = "snd-pos"
const AERON_COUNTER_SENDER_POSITION_TYPE_ID = 2
const AERON_COUNTER_RECEIVER_HWM_NAME = "rcv-hwm"
const AERON_COUNTER_RECEIVER_HWM_TYPE_ID = 3
const AERON_COUNTER_SUBSCRIPTION_POSITION_NAME = "sub-pos"
const AERON_COUNTER_SUBSCRIPTION_POSITION_TYPE_ID = 4
const AERON_COUNTER_RECEIVER_POSITION_NAME = "rcv-pos"
const AERON_COUNTER_RECEIVER_POSITION_TYPE_ID = 5
const AERON_COUNTER_SEND_CHANNEL_STATUS_NAME = "snd-channel"
const AERON_COUNTER_SEND_CHANNEL_STATUS_TYPE_ID = 6
const AERON_COUNTER_RECEIVE_CHANNEL_STATUS_NAME = "rcv-channel"
const AERON_COUNTER_RECEIVE_CHANNEL_STATUS_TYPE_ID = 7
const AERON_COUNTER_SENDER_LIMIT_NAME = "snd-lmt"
const AERON_COUNTER_SENDER_LIMIT_TYPE_ID = 9
const AERON_COUNTER_PER_IMAGE_TYPE_ID = 10
const AERON_COUNTER_CLIENT_HEARTBEAT_TIMESTAMP_NAME = "client-heartbeat"
const AERON_COUNTER_CLIENT_HEARTBEAT_TIMESTAMP_TYPE_ID = 11
const AERON_COUNTER_PUBLISHER_POSITION_NAME = "pub-pos (sampled)"
const AERON_COUNTER_PUBLISHER_POSITION_TYPE_ID = 12
const AERON_COUNTER_SENDER_BPE_NAME = "snd-bpe"
const AERON_COUNTER_SENDER_BPE_TYPE_ID = 13
const AERON_COUNTER_RCV_LOCAL_SOCKADDR_NAME = "rcv-local-sockaddr"
const AERON_COUNTER_SND_LOCAL_SOCKADDR_NAME = "snd-local-sockaddr"
const AERON_COUNTER_LOCAL_SOCKADDR_TYPE_ID = 14
const AERON_COUNTER_FC_NUM_RECEIVERS_TYPE_ID = 17
const AERON_COUNTER_CHANNEL_MDC_NUM_DESTINATIONS_NAME = "mdc-num-dest"
const AERON_COUNTER_CHANNEL_NUM_DESTINATIONS_TYPE_ID = 18
# const AERON_COUNTER_ARCHIVE_RECORDING_POSITION_TYPE_ID = $(Expr(:toplevel, 100))
# const AERON_COUNTER_ARCHIVE_ERROR_COUNT_TYPE_ID = $(Expr(:toplevel, 101))
# const AERON_COUNTER_ARCHIVE_CONTROL_SESSIONS_TYPE_ID = $(Expr(:toplevel, 102))
const AERON_COUNTER_CLUSTER_CONSENSUS_MODULE_STATE_TYPE_ID = 200
const AERON_COUNTER_CLUSTER_NODE_ROLE_TYPE_ID = 201
const AERON_COUNTER_CLUSTER_CONTROL_TOGGLE_TYPE_ID = 202
const AERON_COUNTER_CLUSTER_COMMIT_POSITION_TYPE_ID = 203
const AERON_COUNTER_CLUSTER_RECOVERY_STATE_TYPE_ID = 204
const AERON_COUNTER_CLUSTER_SNAPSHOT_COUNTER_TYPE_ID = 205
const AERON_COUNTER_CLUSTER_ELECTION_STATE_TYPE_ID = 207
const AERON_COUNTER_CLUSTER_BACKUP_STATE_TYPE_ID = 208
const AERON_COUNTER_CLUSTER_BACKUP_LIVE_LOG_POSITION_TYPE_ID = 209
const AERON_COUNTER_CLUSTER_BACKUP_QUERY_DEADLINE_TYPE_ID = 210
const AERON_COUNTER_CLUSTER_BACKUP_ERROR_COUNT_TYPE_ID = 211
const AERON_COUNTER_CLUSTER_CONSENSUS_MODULE_ERROR_COUNT_TYPE_ID = 212
const AERON_COUNTER_CLUSTER_CLIENT_TIMEOUT_COUNT_TYPE_ID = 213
const AERON_COUNTER_CLUSTER_INVALID_REQUEST_COUNT_TYPE_ID = 214
const AERON_COUNTER_CLUSTER_CLUSTERED_SERVICE_ERROR_COUNT_TYPE_ID = 215
const AERON_MAX_HOST_LENGTH = 384
const AERON_MAX_PORT_LENGTH = 8
const AERON_MAX_PREFIX_LENGTH = 8
const AERON_MAX_HTTP_USERINFO_LENGTH = 384
const AERON_MAX_HTTP_PATH_AND_QUERY_LENGTH = 512
const AERON_MAX_HTTP_URL_LENGTH = AERON_MAX_HTTP_USERINFO_LENGTH + AERON_MAX_HOST_LENGTH + AERON_MAX_PORT_LENGTH + AERON_MAX_HTTP_PATH_AND_QUERY_LENGTH + 9
const AERON_HTTP_RESPONSE_RECV_LENGTH = 4 * 1024
const AERON_HTTP_MAX_HEADER_LENGTH = 1024
# const AERON_SPSC_RB_MIN_CAPACITY = 2AERON_RB_RECORD_HEADER_LENGTH
const AERON_INT64_TO_TAGGED_PTR_VALUE_PRESENT = UINT32_C(1)
const AERON_INT64_TO_TAGGED_PTR_VALUE_ABSENT = UINT32_C(0)
const AERON_SYMBOL_TABLE_NAME_MAX_LENGTH = 1023
# const AERON_ALIGNED_HEADER_LENGTH = AERON_ALIGN(AERON_DATA_HEADER_LENGTH, AERON_LOGBUFFER_FRAME_ALIGNMENT)

# Skipping MacroDefinition: AERON_CNC_VERSION_AND_META_DATA_LENGTH ( AERON_ALIGN ( sizeof ( aeron_cnc_metadata_t ) , AERON_CACHE_LINE_LENGTH * 2u ) )
# const AERON_CNC_VERSION = aeron_semantic_version_compose(0, 2, 0)
const AERON_UDP_CHANNEL_RELIABLE_KEY = "reliable"
const AERON_UDP_CHANNEL_TTL_KEY = "ttl"
const AERON_UDP_CHANNEL_ENDPOINT_KEY = "endpoint"
const AERON_UDP_CHANNEL_INTERFACE_KEY = "interface"
const AERON_UDP_CHANNEL_CONTROL_KEY = "control"
const AERON_UDP_CHANNEL_CONTROL_MODE_KEY = "control-mode"
const AERON_UDP_CHANNEL_CONTROL_MODE_MANUAL_VALUE = "manual"
const AERON_UDP_CHANNEL_CONTROL_MODE_DYNAMIC_VALUE = "dynamic"
const AERON_URI_INITIAL_TERM_ID_KEY = "init-term-id"
const AERON_URI_TERM_ID_KEY = "term-id"
const AERON_URI_TERM_OFFSET_KEY = "term-offset"
const AERON_URI_TERM_LENGTH_KEY = "term-length"
const AERON_URI_LINGER_TIMEOUT_KEY = "linger"
const AERON_URI_MTU_LENGTH_KEY = "mtu"
const AERON_URI_SPARSE_TERM_KEY = "sparse"
const AERON_URI_EOS_KEY = "eos"
const AERON_URI_TETHER_KEY = "tether"
const AERON_URI_TAGS_KEY = "tags"
const AERON_URI_SESSION_ID_KEY = "session-id"
const AERON_URI_GROUP_KEY = "group"
const AERON_URI_REJOIN_KEY = "rejoin"
const AERON_URI_FC_KEY = "fc"
const AERON_URI_GTAG_KEY = "gtag"
const AERON_URI_CC_KEY = "cc"
const AERON_URI_SPIES_SIMULATE_CONNECTION_KEY = "ssc"
const AERON_URI_ATS_KEY = "ats"
const AERON_URI_SOCKET_SNDBUF_KEY = "so-sndbuf"
const AERON_URI_SOCKET_RCVBUF_KEY = "so-rcvbuf"
const AERON_URI_RECEIVER_WINDOW_KEY = "rcv-wnd"
const AERON_URI_MEDIA_RCV_TIMESTAMP_OFFSET_KEY = "media-rcv-ts-offset"
const AERON_URI_CHANNEL_RCV_TIMESTAMP_OFFSET_KEY = "channel-rcv-ts-offset"
const AERON_URI_CHANNEL_SND_TIMESTAMP_OFFSET_KEY = "channel-snd-ts-offset"
const AERON_URI_TIMESTAMP_OFFSET_RESERVED = "reserved"
const AERON_URI_INVALID_TAG = -1
# const AERON_NETUTIL_FORMATTED_MAX_LENGTH = INET6_ADDRSTRLEN + 8











############# Custom
const AERON_DATA_HEADER_LENGTH = ( sizeof( aeron_data_header_t ) )
const AERON_ALIGNED_HEADER_LENGTH = AERON_ALIGN(AERON_DATA_HEADER_LENGTH, AERON_LOGBUFFER_FRAME_ALIGNMENT)

# exports
const PREFIXES = ["aeron_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
