using Test, CasADiReader
using JSON
fixtures = get(ENV, "CASADI_READER_FIXTURES", joinpath(@__DIR__, "fixtures"))
@testset "Structural plain/debug fixtures" begin
    for name in filter(n->endswith(n,".casadi"), readdir(fixtures))
        document = read_casadi(joinpath(fixtures, name); type=name=="resource.casadi" ? "Resource" : "")
        @test document["format"] == "casadi_serialization"
        expected = joinpath(fixtures, replace(name,r"\.casadi$"=>".reader.json"))
        if haskey(ENV, "CASADI_READER_FIXTURES")
            @test isfile(expected)
            @test document == JSON.parsefile(expected)
        end
    end
end
@testset "Lazy resource lifetime and bounds" begin
    document = read_resource(joinpath(fixtures, "resource.casadi"); lazy=true)
    GC.gc()
    decoded = casadi_data(document)
    fields = decoded["objects"][decoded["root"]+1]["fields"]
    payload = only(filter(f->f["name"]=="ZipMemResource::blob",fields))["value"]
    @test payload["kind"] == "deferred_bytes"
    @test blob_size(document) == 1144
    @test read_blob(document, 1, 0, 4) == UInt8[80,75,3,4]
    @test_throws ArgumentError read_blob(document, 1, 1143, 4)
    @test_throws BoundsError blob_size(document, 2)
    close(document)
    @test_throws ArgumentError casadi_json(document)
    close(document)
end
@testset "Native JSON output" begin
    value = Dict("quoted\"\\\n\t\0" => Any[true, false, nothing, "τ", 1.25, -3])
    @test JSON.parse(CasADiReader.encode_json(value)) == value
    for name in filter(n -> endswith(n, ".casadi"), readdir(fixtures))
        value = read_casadi(joinpath(fixtures, name); type=name=="resource.casadi" ? "Resource" : "")
        @test JSON.parse(CasADiReader.encode_json(value)) == value
    end
end

@testset "Specific exports alongside JSON" begin
    @test json === JSON.json
    @test !(:data in names(CasADiReader))
    @test !(:loads in names(CasADiReader))
    path = joinpath(fixtures, "arithmetic.casadi")
    @test parse_casadi(read(path, String)) == read_casadi(path)
    document = Document(path)
    try
        @test casadi_data(document) == read_casadi(path)
        @test JSON.parse(casadi_json(document)) == casadi_data(document)
    finally
        close(document)
    end
end
