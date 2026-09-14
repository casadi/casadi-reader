module CasadiReader
using Libdl
import JSON
export Document, read_casadi, read_resource, json, data, blob_size, read_blob

const library = Ref{Ptr{Cvoid}}(C_NULL)
const symbols = Dict{Symbol,Ptr{Cvoid}}()
function __init__()
    prefix = normpath(joinpath(@__DIR__, "..", "deps", "usr"))
    directory = Sys.iswindows() ? "bin" : "lib"
    filename = (Sys.iswindows() ? "" : "lib") * "casadi_reader." * Libdl.dlext
    bundled = joinpath(prefix, directory, filename)
    path = get(ENV, "CASADI_READER_LIBRARY", isfile(bundled) ? bundled : "libcasadi_reader")
    library[] = Libdl.dlopen(path)
    for name in (:cr_open, :cr_close, :cr_json, :cr_blob_count, :cr_blob_size, :cr_blob_read)
        symbols[name] = Libdl.dlsym(library[], name)
    end
end

mutable struct Document
    handle::Ptr{Cvoid}
end
function Document(path::AbstractString; resource=false, lazy=false)
    error = zeros(UInt8, 1024)
    handle = ccall(symbols[:cr_open], Ptr{Cvoid},
                   (Cstring, Cint, Cint, Ptr{UInt8}, Csize_t), path, resource, lazy, error, length(error))
    handle == C_NULL && throw(ArgumentError(unsafe_string(pointer(error))))
    document = Document(handle)
    finalizer(close, document)
    document
end
function Base.close(document::Document)
    if document.handle != C_NULL
        ccall(symbols[:cr_close], Cvoid, (Ptr{Cvoid},), document.handle)
        document.handle = C_NULL
    end
end
function checked(document::Document)
    document.handle == C_NULL && throw(ArgumentError("Document is closed"))
    document.handle
end
function json(document::Document)
    GC.@preserve document begin
        unsafe_string(ccall(symbols[:cr_json], Cstring, (Ptr{Cvoid},), checked(document)))
    end
end
data(document::Document) = JSON.parse(json(document))
function read_casadi(path::AbstractString)
    document = Document(path)
    try data(document) finally close(document) end
end
# Keep the document alive for lazy payload access. Close it when finished.
read_resource(path::AbstractString; lazy=false) = Document(path; resource=true, lazy=lazy)
function blob_size(document::Document, index::Integer=1)
    GC.@preserve document begin
        n = ccall(symbols[:cr_blob_count], Csize_t, (Ptr{Cvoid},), checked(document))
        1 <= index <= n || throw(BoundsError(document, index))
        ccall(symbols[:cr_blob_size], UInt64, (Ptr{Cvoid}, Csize_t), checked(document), index-1)
    end
end
"""Read bytes using a one-based blob index and zero-based byte offset."""
function read_blob(document::Document, index::Integer, offset::Integer, count::Integer)
    size = blob_size(document, index)
    0 <= offset <= size && 0 <= count <= size-offset || throw(ArgumentError("Blob range out of bounds"))
    bytes = Vector{UInt8}(undef, count)
    error = zeros(UInt8, 1024)
    GC.@preserve document begin
        status = ccall(symbols[:cr_blob_read], Cint,
                       (Ptr{Cvoid}, Csize_t, UInt64, Ptr{UInt8}, Csize_t, Ptr{UInt8}, Csize_t),
                       checked(document), index-1, offset, bytes, count, error, length(error))
        status == 0 || throw(ArgumentError(unsafe_string(pointer(error))))
    end
    bytes
end
end
