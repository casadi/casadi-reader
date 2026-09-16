# Wire-level edge cases supplement real CasADi fixtures with invalid inputs that
# CasADi's serializer deliberately cannot produce.
const CR = CasADiReader
wire(bytes) = String(UInt8[c for b in bytes for c in (0x61 + (b & 0x0f), 0x61 + (b >> 4))])
le(value::T) where T = collect(reinterpret(UInt8, [htol(value)]))
wire_reader(bytes; options...) = CR.Reader(CR.Source(Vector{UInt8}(codeunits(wire(bytes)))); options...)
packet(bytes; debug=0x00) = wire(vcat(le(Int64(CR.METADATA["wire"]["magic"])), le(Int64(CR.METADATA["wire"]["protocol"])), [debug], bytes))

@testset "Wire bounds and malformed documents" begin
    text = read(joinpath(fixtures, "arithmetic.casadi"), String)
    @test parse_casadi(" \t\r\n" * text * "\n\t ") == parse_casadi(text)
    for invalid in ("", "a", "zz", text[1:end-2])
        @test_throws ArgumentError parse_casadi(invalid)
    end
    @test_throws ArgumentError CR.Source(UInt8[0x61, 0x61]; max_bytes=0)
    source = CR.Source(UInt8[0x61, 0x62])
    @test CR.sourcebytes(source, 0, 1) == UInt8[0x10]
    @test_throws ArgumentError CR.sourcebytes(source, -1, 1)
    @test_throws ArgumentError CR.sourcebytes(source, 0, 2)
    close(source)
    @test_throws ArgumentError CR.sourcebytes(source, 0, 0)
    @test_throws ArgumentError parse_casadi(wire(zeros(UInt8, 17)))
    bad_protocol = vcat(le(Int64(CR.METADATA["wire"]["magic"])), le(Int64(-1)), [0x00])
    @test_throws ArgumentError parse_casadi(wire(bad_protocol))
    @test_throws ArgumentError parse_casadi(packet(UInt8[]; debug=0x02))
    @test_throws ArgumentError parse_casadi(packet([0xff]))
    @test_throws ArgumentError parse_casadi(packet(vcat(le(Int32(1)), [0x00])); type="int")
    @test_throws ArgumentError parse_casadi(packet(UInt8[]); type="NoSuchType")
    @test_throws ArgumentError parse_casadi(text; max_items=0)
    mktemp() do path, io
        @test_throws ArgumentError Document(path)
        write(io, "zz")
        flush(io)
        @test_throws ArgumentError Document(path)
    end
    r = wire_reader(UInt8[])
    @test_throws ArgumentError CR.take(r, -1)
    @test_throws ArgumentError CR.count(r, -1)
    r.depth = 256
    @test_throws ArgumentError CR.enter_layout(r)
    @test !CR.truth(nothing)
    @test !CR.truth("")
    @test CR.truth("x")
    @test !CR.truth(0)
    @test CR.truth(1)
    @test CR.truth(true)
end

@testset "Primitive wire types and lossless JSON" begin
    for (kind, value) in [("int", Int32(-42)), ("unsignedint", UInt32(42)),
                           ("casadi_int", Int64(-42)), ("std::size_t", UInt64(42))]
        @test parse_casadi(packet(le(value)); type=kind)["roots"] == [value]
    end
    for (kind, value) in [("casadi_int", typemin(Int64)), ("size_t", typemax(UInt64))]
        @test parse_casadi(packet(le(value)); type=kind)["roots"] == [Dict("\$integer" => string(value))]
    end
    @test parse_casadi(packet(UInt8[0x2a]); type="char")["roots"] == [42]
    for flag in UInt8[0, 1]
        @test parse_casadi(packet([flag]); type="bool")["roots"] == [flag == 1]
    end
    @test_throws ArgumentError parse_casadi(packet(UInt8[2]); type="bool")
    for (value, expected) in [(NaN, "NaN"), (Inf, "Infinity"), (-Inf, "-Infinity")]
        @test parse_casadi(packet(collect(reinterpret(UInt8, [value]))); type="double")["roots"] == [Dict("\$float" => expected)]
        @test_throws ArgumentError CR.encode_json(value)
    end
    payload = UInt8[0xff, 0x00, 0x80]
    for kind in ("std::istream", "std::stringstream")
        @test parse_casadi(packet(vcat(le(UInt64(length(payload))), payload)); type=kind)["roots"] == [Dict("\$bytes" => Int.(payload))]
        r = wire_reader(vcat(le(UInt64(length(payload))), payload); lazy=true)
        @test CR.primitive(r, kind)["byteLength"] == length(payload)
    end
    @test parse_casadi(packet(vcat(le(Int32(3)), payload)); type="std::string")["roots"] == [Dict("\$bytes" => Int.(payload))]
    for (bytes, threshold) in [(payload, 65536), (UInt8[0x61, 0x62, 0x63], 1)]
        r = wire_reader(vcat(le(Int32(3)), bytes); lazy=true, lazy_threshold=threshold)
        @test CR.stringvalue(r)["kind"] == "deferred_bytes"
        @test r.blobs == [(4, 3)]
    end
    @test_throws ArgumentError parse_casadi(packet(le(Int32(-1))); type="std::string")
    @test JSON.parse(CR.encode_json(Any[nothing, true, false, Dict(), Any[], "\"\\\n\t\r\b\f\0τ"])) == Any[nothing, true, false, Dict(), Any[], "\"\\\n\t\r\b\f\0τ"]
end

@testset "Debug validation and shared object corruption" begin
    @test_throws ArgumentError parse_casadi(packet(UInt8[0x78]; debug=0x01); type="bool")
    # Sparsity is a shared object: invalid flags/references must not access memory.
    for payload in [UInt8[0x78], vcat(UInt8[UInt8('r')], le(Int64(-1))), vcat(UInt8[UInt8('r')], le(Int64(0)))]
        @test_throws ArgumentError parse_casadi(packet(payload); type="Sparsity")
    end
    debug = read(joinpath(fixtures, "arithmetic.debug.casadi"), String)
    field = wire(Vector{UInt8}(codeunits("ProtoFunction::name")))
    @test occursin(field, debug)
    @test_throws ArgumentError parse_casadi(replace(debug, field => wire(Vector{UInt8}(codeunits("ProtoFunction::xxxx")))))
    r = wire_reader(le(Int32(-1)))
    record = Dict{String,Any}("fields" => Any[])
    @test_throws ArgumentError CR.version(r, record, "test", 1)
    # Every truncated prefix of a serialized integer must be rejected.
    good = packet(le(Int64(42)))
    for n in 0:2:length(good)-2
        @test_throws ArgumentError parse_casadi(good[1:n]; type="casadi_int")
    end
    @test parse_casadi(good; type="casadi_int")["roots"] == [42]
end

function debug_value(kind, value)
    kind == "char" && return UInt8[value]
    kind == "int" && return vcat(UInt8['i'], le(Int32(value)))
    kind == "casadi_int" && return vcat(UInt8['J'], le(Int64(value)))
    kind == "std::string" && return vcat(UInt8['s', 'i'], le(Int32(ncodeunits(value))), collect(codeunits(value)))
    error("Unhandled discriminator type: " * kind)
end

@testset "Reject corrupted serialization discriminators" begin
    discriminators = Set([
        "MXNode::op", "SXNode::op", "FunctionInternal::base_function",
        "PluginInterface::plugin_name", "ImporterInternal::type", "FmuInternal::type",
        "ConstantMX::type", "ConstantSX::type", "GenericType::type", "ResourceInternal::type",
        "Multiplication::kind", "Kron::kind", "KronContract::kind", "Project::type",
        "GetNonzeros::type", "SetNonzeros::type", "GetNonzerosParam::type", "SetNonzerosParam::type",
        "Map::class_name", "MapSum::class_name", "BSpline::type", "LinearInterpolant::type",
        "GenericExternal::type",
    ])
    seen = Set{Tuple{String,String}}()
    for case in manifest["cases"]
        occursin("debug", case["file"]) && haskey(case, "expected") || continue
        text = read(joinpath(fixtures, case["file"]), String)
        expected = JSON.parsefile(joinpath(fixtures, case["expected"]))
        for object in expected["objects"], field in object["fields"]
            name, kind, value = field["name"], field["type"], field["value"]
            name in discriminators || continue
            key = (name, string(value))
            key in seen && continue
            push!(seen, key)
            encoded = debug_value(kind, value)
            marker = wire(collect(codeunits(name)))
            needle = marker * wire(encoded)
            @test occursin(needle, text)
            invalid = kind == "std::string" ? repeat("?", ncodeunits(value)) : kind == "char" ? 255 : -9999
            corrupted = replace(text, needle => marker * wire(debug_value(kind, invalid)); count=1)
            exception = try
                parse_casadi(corrupted; type=case["type"])
                nothing
            catch e
                e
            end
            @test exception isa ArgumentError
            @test occursin("Unknown serialization discriminator", sprint(showerror, exception))
        end
    end
    @test length(seen) > 100
end

@testset "Typed pairs and nonserializable pointers" begin
    word = vcat(le(Int32(3)), collect(codeunits("abc")))
    for (kind, first, expected) in [("casadi_int", le(Int64(42)), 42), ("bool", UInt8[1], true)]
        document = parse_casadi(packet(vcat(first, word)); type="std::pair<" * kind * ",std::string>")
        @test document["roots"] == [Any[expected, "abc"]]
    end
    @test_throws ArgumentError parse_casadi(packet(vcat(UInt8['d'], le(Int32(14)))); type="GenericType")
end
