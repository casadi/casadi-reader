cmake_minimum_required(VERSION 3.16)
project(casadi_reader VERSION 0.0.0 LANGUAGES C CXX)
include(GNUInstallDirs)
add_library(casadi_reader SHARED native/src/reader.cpp)
target_compile_features(casadi_reader PUBLIC cxx_std_11)
target_compile_definitions(casadi_reader PRIVATE CASADI_READER_BUILD)
target_include_directories(casadi_reader PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/native/include>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
set_target_properties(casadi_reader PROPERTIES VERSION ${PROJECT_VERSION} SOVERSION 0)
add_executable(casadi-reader-native native/src/main.cpp)
target_link_libraries(casadi-reader-native PRIVATE casadi_reader)
install(TARGETS casadi_reader casadi-reader-native EXPORT casadi_readerTargets
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(DIRECTORY native/include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(EXPORT casadi_readerTargets NAMESPACE casadi_reader::
  FILE casadi_readerConfig.cmake DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/casadi_reader)
include(CTest)
if(BUILD_TESTING)
  add_executable(casadi_reader_c_test native/tests/api.c)
  target_link_libraries(casadi_reader_c_test PRIVATE casadi_reader)
  add_test(NAME c_api COMMAND casadi_reader_c_test ${CMAKE_CURRENT_SOURCE_DIR}/test/fixtures)
endif()
option(CASADI_READER_MATLAB "Build the MATLAB MEX binding" OFF)
if(CASADI_READER_MATLAB)
  find_package(Matlab REQUIRED COMPONENTS MEX_COMPILER)
  matlab_add_mex(NAME casadi_reader_mex SRC matlab/casadi_reader_mex.cpp native/src/reader.cpp)
  target_compile_features(casadi_reader_mex PRIVATE cxx_std_11)
  target_compile_definitions(casadi_reader_mex PRIVATE CASADI_READER_BUILD)
  target_include_directories(casadi_reader_mex PRIVATE native/include)
  set_target_properties(casadi_reader_mex PROPERTIES LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/matlab")
endif()
