cmake_minimum_required(VERSION 3.13.4)
project(crispypass-opt LANGUAGES CXX C)

set(CMAKE_BUILD_WITH_INSTALL_NAME_DIR ON)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")
find_package(MLIR REQUIRED CONFIG)


