using Test, CasadiReader
import JSON
fixtures = get(ENV, "CASADI_READER_FIXTURES", joinpath(@__DIR__, "..", "..", "test", "fixtures"))
@testset "Native saved functions" begin
    for name in ["arithmetic", "mapping", "slice", "assignment", "sparse"]
        document = read_casadi(joinpath(fixtures, name*".casadi"))
        oracle = JSON.parsefile(joinpath(fixtures, name*".json"))
        root = document["objects"][document["root"]+1]
        @test root["name"] == oracle["name"]
        @test length(root["instructions"]) == length(oracle["nodes"])
        expected = joinpath(fixtures, name*".reader.json")
        isfile(expected) && @test document == JSON.parsefile(expected)
    end
end
@testset "Lazy resource lifetime and bounds" begin
    document = read_resource(joinpath(fixtures, "resource.casadi"); lazy=true)
    GC.gc()
    @test data(document)["resource"]["blob"]["kind"] == "deferred_bytes"
    @test blob_size(document) == 1144
    @test read_blob(document, 1, 0, 4) == UInt8[80,75,3,4]
    @test_throws ArgumentError read_blob(document, 1, 1143, 4)
    @test_throws BoundsError blob_size(document, 2)
    close(document)
    @test_throws ArgumentError json(document)
    close(document)
end
