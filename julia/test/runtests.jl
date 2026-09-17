using Test, CasADiReader
using JSON
fixtures = joinpath(@__DIR__, "fixtures")
manifest = JSON.parsefile(joinpath(fixtures, "manifest.json"))
@testset "Shipped CasADi corpus" begin
    for case in manifest["cases"]
        @testset "$(case["file"])" begin
            path = joinpath(fixtures, case["file"])
            if haskey(case, "error")
                error = try
                    read_casadi(path; type=case["type"])
                    nothing
                catch exception
                    exception
                end
                @test error isa ArgumentError
                @test occursin(case["error"], sprint(showerror, error))
            else
                expected = JSON.parsefile(joinpath(fixtures, case["expected"]))
                decoded = read_casadi(path; type=case["type"])
                @test decoded == expected
                @test JSON.parse(CasADiReader.encode_json(decoded)) == expected
                @test parse_casadi(read(path, String); type=case["type"]) == expected
            end
        end
    end
end
if haskey(ENV, "CASADI_READER_FIXTURES")
    @testset "External cross-language fixtures" begin
        directory = ENV["CASADI_READER_FIXTURES"]
        for name in filter(n -> endswith(n, ".casadi"), readdir(directory))
            expected = joinpath(directory, replace(name, r"\.casadi$" => ".reader.json"))
            @test read_casadi(joinpath(directory, name); type=name == "resource.casadi" ? "Resource" : "") == JSON.parsefile(expected)
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
end

@testset "Specific exports alongside JSON" begin
    @test !(:json in names(CasADiReader))
    if Base.isexported(JSON, :json)
        @test json === JSON.json
    end
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

include("runtime.jl")
