using Test, CasadiReader
import JSON
fixtures = get(ENV, "CASADI_READER_FIXTURES", joinpath(@__DIR__, "..", "..", "test", "fixtures"))
@testset "Structural plain/debug fixtures" begin
    for name in filter(n->endswith(n,".casadi"), readdir(fixtures))
        document = read_casadi(joinpath(fixtures, name); type=name=="resource.casadi" ? "Resource" : "")
        @test document["format"] == "casadi_serialization"
        expected = joinpath(fixtures, replace(name,r"\.casadi$"=>".reader.json"))
        @test isfile(expected)
        @test document == JSON.parsefile(expected)
    end
end
@testset "Lazy resource lifetime and bounds" begin
    document = read_resource(joinpath(fixtures, "resource.casadi"); lazy=true)
    GC.gc()
    decoded = data(document)
    fields = decoded["objects"][decoded["root"]+1]["fields"]
    payload = only(filter(f->f["name"]=="ZipMemResource::blob",fields))["value"]
    @test payload["kind"] == "deferred_bytes"
    @test blob_size(document) == 1144
    @test read_blob(document, 1, 0, 4) == UInt8[80,75,3,4]
    @test_throws ArgumentError read_blob(document, 1, 1143, 4)
    @test_throws BoundsError blob_size(document, 2)
    close(document)
    @test_throws ArgumentError json(document)
    close(document)
end
