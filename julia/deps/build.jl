# A compiler and CMake are build prerequisites; no CasADi installation is used.
source = isdir(joinpath(@__DIR__, "reader")) ? joinpath(@__DIR__, "reader") : normpath(joinpath(@__DIR__, "..", ".."))
build = joinpath(@__DIR__, "build")
prefix = joinpath(@__DIR__, "usr")
run(`cmake -S $source -B $build -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DCASADI_READER_MATLAB=OFF -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_INSTALL_PREFIX=$prefix`)
run(`cmake --build $build --config Release --target install`)
