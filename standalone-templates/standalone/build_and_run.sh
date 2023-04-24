#!/bin/bash 
if [ ! -d "./build/" ]; then
	mkdir ./build 
	cd ./build
	pwd
else
	rm -r build
	mkdir ./build
	cd ./build
	pwd
fi

echo "cmake Ninja ..."
cmake -G Ninja .. -DMLIR_DIR=$MLIR_PREFIX/lib/cmake/mlir -DLLVM_EXTERNAL_LIT=$LLVM_PREFIX/bin/llvm-lit

echo "build test..."
cmake --build . --target check-standalone-opt

# To build the documentation from the TableGen description of the dialect operations, run:
cmake --build . --target mlir-doc

# Run the dummy.mlir
./bin/standalone-opt ../test/Standalone/dummy.mlir
