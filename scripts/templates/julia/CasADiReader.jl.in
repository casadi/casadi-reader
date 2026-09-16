module CasADiReader
using Mmap
export Document, read_casadi, read_resource, parse_casadi, casadi_json, casadi_data, blob_size, read_blob
include("generated.jl")

mutable struct Source
    bytes::Vector{UInt8}
    start::Int
    length::Int
    closed::Bool
end
function Source(bytes::Vector{UInt8}; max_bytes = 1024^3)
    first, last = 1, length(bytes)
    whitespace = (0x20, 0x09, 0x0d, 0x0a)
    while first <= last && bytes[first] in whitespace
        first += 1
    end
    while last >= first && bytes[last] in whitespace
        last -= 1
    end
    n = last - first + 1
    (iseven(n) && n ÷ 2 <= max_bytes) ||
        throw(ArgumentError("Invalid .casadi encoding or file too large"))
    Source(bytes, first, n ÷ 2, false)
end
function sourcebytes(source::Source, offset::Int, size::Int)
    source.closed && throw(ArgumentError("Source is closed"))
    (0 <= offset <= source.length && 0 <= size <= source.length - offset) ||
        throw(ArgumentError("Source range out of bounds"))
    out = Vector{UInt8}(undef, size)
    for i = 1:size
        j = source.start + 2 * (offset + i - 1)
        a, b = source.bytes[j], source.bytes[j+1]
        (0x61 <= a <= 0x70 && 0x61 <= b <= 0x70) || throw(ArgumentError("Invalid .casadi encoding"))
        out[i] = (a - 0x61) | ((b - 0x61) << 4)
    end
    out
end
function Base.close(source::Source)
    source.closed = true
    source.bytes = UInt8[]
end
mutable struct Reader
    source::Source
    scheme::Any
    lazy::Bool
    max_items::Int
    lazy_threshold::Int
    pos::Int
    depth::Int
    debug::Bool
    shared::Vector{Int}
    objects::Vector{Any}
    blobs::Vector{Tuple{Int,Int}}
end
Reader(s; lazy = false, max_items = 1000000, lazy_threshold = 65536) = Reader(
    s,
    METADATA,
    lazy,
    max_items,
    lazy_threshold,
    0,
    0,
    false,
    Int[],
    Any[],
    Tuple{Int,Int}[],
)
fail(r, message) = throw(ArgumentError(".casadi byte $(r.pos): $message"))
function take(r, size)
    size isa Integer && 0 <= size <= r.source.length - r.pos ||
        fail(r, "Truncated or excessive payload")
    start = r.pos
    r.pos += Int(size)
    start
end
function count(r, n)
    n isa Integer && 0 <= n <= r.max_items || fail(r, "Invalid or excessive collection size")
    Int(n)
end
byte(r) = Int(only(sourcebytes(r.source, take(r, 1), 1)))
function decoration(r, tag)
    r.debug && byte(r) != Int(only(tag)) && fail(r, "Expected wire decoration $tag")
end
function fieldname(r, name)
    r.debug && stringvalue(r) != name && fail(r, "Expected serialized field $name")
end
function number(r, kind)
    tag, T = Dict(
        "int" => ("i", Int32),
        "unsignedint" => ("u", UInt32),
        "casadi_int" => ("J", Int64),
        "size_t" => ("K", UInt64),
        "double" => ("d", Float64),
    )[kind]
    decoration(r, tag)
    bytes = sourcebytes(r.source, take(r, sizeof(T)), sizeof(T))
    bits = UInt64(0)
    for (i, b) in enumerate(bytes)
        bits |= UInt64(b) << (8 * (i - 1))
    end
    v =
        T == Float64 ? reinterpret(Float64, bits) :
        T == Int64 ? reinterpret(Int64, bits) :
        T == Int32 ? reinterpret(Int32, UInt32(bits)) : T(bits)
    if T == Float64
        !isfinite(v) &&
            return Dict("\$float" => isnan(v) ? "NaN" : v > 0 ? "Infinity" : "-Infinity")
    elseif v > 9007199254740991 || (v isa Signed && v < -9007199254740991)
        return Dict("\$integer" => string(v))
    end
    v
end
function blob(r, offset, size)
    push!(r.blobs, (offset, size))
    Dict(
        "kind" => "deferred_bytes",
        "offset" => offset,
        "byteLength" => size,
        "encoding" => "casadi-nibbles",
    )
end
function stringvalue(r)
    decoration(r, "s")
    size = number(r, "int")
    offset = take(r, size)
    r.lazy && size >= r.lazy_threshold && return blob(r, offset, Int(size))
    bytes = sourcebytes(r.source, offset, Int(size))
    text = String(copy(bytes))
    isvalid(text) && return text
    r.lazy ? blob(r, offset, Int(size)) : Dict("\$bytes" => Int.(bytes))
end
truth(v) = v isa Bool ? v : v isa Number ? v != 0 : v !== nothing && !isempty(v)
function enter_layout(r)
    r.depth += 1
    r.depth <= 256 || fail(r, "Layout nesting limit exceeded")
end
function field(r, record, name, kind, read)
    fieldname(r, name)
    v = read()
    push!(record["fields"], Dict("name" => name, "type" => kind, "value" => v))
    count(r, length(record["fields"]))
    v
end
function version(r, record, base, expected)
    v = field(r, record, base * "::serialization::version", "int", () -> number(r, "int"))
    v == expected || fail(r, "Unsupported $base version $v")
end
function value(r, kind)
    haskey(READERS, kind) ? READERS[kind](r) : primitive(r, kind)
end
function primitive(r, cpp_type)
    kind = cpp_type
    kind == "std::size_t" && (kind = "size_t")
    kind in ("int", "unsignedint", "casadi_int", "size_t", "double") && return number(r, kind)
    kind == "char" && return byte(r)
    kind == "bool" && return boolvalue(r)
    kind == "std::string" && return stringvalue(r)
    kind in ("std::istream", "std::stringstream") && return streamvalue(r)
    fail(r, "Unknown serialization type: " * kind)
end
function boolvalue(r)
    decoration(r, "b")
    v = byte(r)
    v <= 1 || fail(r, "Invalid boolean")
    v == 1
end
function streamvalue(r)
    decoration(r, "B")
    size = number(r, "size_t")
    offset = take(r, size)
    r.lazy ? blob(r, offset, Int(size)) :
    Dict("\$bytes" => Int.(sourcebytes(r.source, offset, Int(size))))
end
function object(r, kind, tag, shared, read)
    tag !== nothing && decoration(r, tag)
    if shared
        fieldname(r, "Shared::flag")
        flag = byte(r)
        if flag == Int('r')
            fieldname(r, "Shared::reference")
            i = number(r, "casadi_int")
            i isa Integer && 0 <= i < length(r.shared) || fail(r, "Invalid shared reference")
            return Dict("\$ref" => r.shared[i+1])
        end
        flag == Int('d') || fail(r, "Invalid shared definition")
    end
    record = Dict{String,Any}("type" => kind, "fields" => Any[], "layouts" => Any[])
    read(r, record, Dict{String,Any}())
    !shared && return record
    count(r, length(r.objects) + 1)
    i = length(r.objects)
    push!(r.objects, record)
    push!(r.shared, i)
    Dict("\$ref" => i)
end
function decode(r, type = "")
    number(r, "casadi_int") == r.scheme["wire"]["magic"] || fail(r, "Invalid serialization magic")
    number(r, "casadi_int") == r.scheme["wire"]["protocol"] ||
        fail(r, "Unsupported serialization protocol")
    debug = byte(r)
    debug <= 1 || fail(r, "Invalid debug flag")
    r.debug = debug == 1
    roots = Any[]
    if !isempty(type)
        push!(roots, value(r, type))
    else
        while r.pos < r.source.length
            tag = string(byte(r))
            kinds = r.scheme["reader"]["file_types"]
            haskey(kinds, tag) || fail(r, "Unsupported serialized file type $tag")
            prefix = get(get(r.scheme["reader"], "file_prefixes", Dict()), tag, nothing)
            prefix !== nothing && value(r, prefix)
            push!(roots, value(r, kinds[tag]))
        end
    end
    r.pos == r.source.length || fail(r, "Trailing serialization data")
    Dict(
        "format" => "casadi_serialization",
        "version" => 1,
        "serializationProtocol" => r.scheme["wire"]["protocol"],
        "root" =>
            length(roots) == 1 && roots[1] isa AbstractDict ? get(roots[1], "\$ref", nothing) :
            nothing,
        "roots" => roots,
        "objects" => r.objects,
    )
end
# Structural JSON output uses only the Julia standard library.
function write_json(io, value::AbstractString)
    print(io, '\"')
    for c in value
        if c == '\"'
            print(io, "\\\"")
        elseif c == '\\'
            print(io, "\\\\")
        elseif UInt32(c) < 0x20
            print(io, "\\u", string(UInt32(c); base=16, pad=4))
        else
            print(io, c)
        end
    end
    print(io, '\"')
end
write_json(io, ::Nothing) = print(io, "null")
write_json(io, value::Bool) = print(io, value ? "true" : "false")
function write_json(io, value::Number)
    isfinite(value) || throw(ArgumentError("Nonfinite JSON number"))
    print(io, value)
end
function write_json(io, values::AbstractVector)
    print(io, '[')
    for (i, value) in enumerate(values)
        i > 1 && print(io, ',')
        write_json(io, value)
    end
    print(io, ']')
end
function write_json(io, values::AbstractDict)
    print(io, '{')
    for (i, (key, value)) in enumerate(values)
        i > 1 && print(io, ',')
        write_json(io, key)
        print(io, ':')
        write_json(io, value)
    end
    print(io, '}')
end
encode_json(value) = sprint(write_json, value)

mutable struct Document
    reader::Reader
    result::Any
end
function Document(path::AbstractString; resource = false, type = "", lazy = false, options...)
    bytes = open(path, "r") do io
        filesize(io) == 0 ? UInt8[] : Mmap.mmap(io, Vector{UInt8})
    end
    r = Reader(Source(bytes); lazy = lazy, options...)
    try
        d = Document(r, decode(r, resource ? "Resource" : type))
        finalizer(close, d)
        d
    catch
        close(r.source)
        rethrow()
    end
end
Base.close(d::Document) = close(d.reader.source)
function casadi_data(d::Document)
    d.reader.source.closed && throw(ArgumentError("Document is closed"))
    d.result
end
casadi_json(d::Document) = encode_json(casadi_data(d))
function read_casadi(path::AbstractString; options...)
    d = Document(path; options...)
    try
        casadi_data(d)
    finally
        close(d)
    end
end
read_resource(path::AbstractString; lazy = false, options...) =
    Document(path; resource = true, lazy = lazy, options...)
function parse_casadi(text::AbstractString; type = "", options...)
    r = Reader(Source(Vector{UInt8}(codeunits(text))); options...)
    try
        decode(r, type)
    finally
        close(r.source)
    end
end
function blob_size(d::Document, index::Integer = 1)
    casadi_data(d)
    d.reader.blobs[index][2]
end
function read_blob(
    d::Document,
    index::Integer = 1,
    offset::Integer = 0,
    size::Integer = blob_size(d, index) - offset,
)
    total = blob_size(d, index)
    0 <= offset <= total && 0 <= size <= total - offset ||
        throw(ArgumentError("Blob slice out of bounds"))
    sourcebytes(d.reader.source, d.reader.blobs[index][1] + offset, Int(size))
end
end
