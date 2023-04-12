# raccoon-mlir cmake root
# configure for raccoon-mlir build

cmake_minimum_required(VERSION 3.10)


# setups and global
project(raccoon-mlir LANGUAGES CXX C)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
	
# Options and settings
option(LLVM_INCLUDE_TOOLS "Generate build targets for the LLVM tools." ON)
option(LLVM_BUILD_TOOLS "Build the LLVM tools. If OFF, just generate build targets." ON)

# Configuration
find_package(MLIR REQUIRED CONFIG)
set(LLVM_MLIR_BINARY_DIR ${MLIR_DIR}/../../../bin)
set(LLVM_MLIR_SOURCE_DIR ${MLIR_DIR}/../../../../mlir)
set(LLVM_PROJECT_SOURCE_DIR ${MLIR_DIR}/../../../../)
# Add MLIR and LLVM cmake path to the default MODULE PATH
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")

find_program(LLVM_TABLEGEN_EXE "llvm-tblgen" ${LLVM_TOOLS_BINARY_DIR}
	NO_DEFAULT_PATH)

include(TableGen)
include(AddLLVM)
include(AddMLIR)
include(HandleLLVMOptions)

# Raccoon Configuration
set(RACCOON_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(RACCOON_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/bin)
set(RACCOON_EXAMPLES_DIR ${RACCOON_SOURCE_DIR}/examples)
set(RACCOON_MIDEND_INCLUDE_DIR ${RACCOON_SOURCE_DIR}/midend/include/)
# set(RACCOON_THIRDPARTY_INCLUDE_DIR ${RACCOON_SOURCE_DIR}/thirdparty/include/)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${RACCOON_BINARY_DIR})
set(RACCOON_EXAMPLES OFF CACHE BOOL "Build examples")

# Add Raccoon files to the inlcude dir
include_directories(${RACCOON_MAIN_INCLUDE_DIR})
include_directories(${RACCOON_MIDEND_INCLUDE_DIR})
include_directories(${RACCOON_MIDEND_INCLUDE_DIR}/Interface)
include_directories(${RACCOON_MAIN_INCLUDE_DIR}/Dialect)
include_directories(${CMAKE_CURRENT_BINARY_DIR}/midend/include/Dialect)
include_directories(${CMAKE_CURRENT_BINARY_DIR}/backend/include)
include_directories(${RACCOON_SOURCE_DIR}/lib)
# include_directories(${RACCOON_THIRDPARTY_INCLUDE_DIR})
include_directories(${RACCOON_SOURCE_DIR}/frontend/Interfaces)

# Add MLIR and LLVM headers to the include path
include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})

# Hardware Detection
# TODO: do not have cmake dir, should add check_simd.cmake to the dir
include(${RACCOON_SOURCE_DIR}/cmake/check_simd.cmake)
include(${RACCOON_SOURCE_DIR}/cmake/check_toolchain.cmake)
check_simd()
check_toolchain()

# TODO: Antlr Configuration

# Directory
# backend copied from Buddy-MLIR
add_subdirectory(cmake)
add_subdirectory(frontend)
add_subdirectory(midend)
add_subdirectory(backend)
add_subdirectory(tools)
add_subdirectory(examples)
add_subdirectory(tests)

