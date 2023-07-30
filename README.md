# An easy tour towards MLIR
[![Maintenance](https://img.shields.io/badge/Raccoon-V0.1-brightgreen)](https://github.com/JoshuaQSH/Raccoon-MLIR-Tour)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-YES-green.svg)](https://github.com/JoshuaQSH/Raccoon-MLIR-Tour)

Shout out to Chris Lattner.
[Brief Introduction of MLIR in Chinese](https://zhuanlan.zhihu.com/p/442140282)

Hopefully this tour will help you find the way to quickly jump into MLIR. This repository aims to contain 
- A simple MLIR pass called `simplepass`, which refers to the modified example of an out-of-tree MLIR pass tour from [crispyberry](https://github.com/crispyberry/MLIR-Pass-Tour). It is an opt-like tool to operate on the SCF dialect (Modified mlir/example/standalone).
- A Dialect called `Raccoon` used for ML embedding lowering down. You may wonder why `Raccoon`, this black-eyed little cutie was once my nickname XD.


Before getting started, we assume you have already built your MLIR under the home directory `./llvm-project`. If not then you can follow the Building guide as well:

## Prerequest
```shell
git clone https://github.com/llvm/llvm-project.git
mkdir llvm-project/build
cd llvm-project/build
# Also, remember to turn MLIR_ENABLE_BINDINGS_PYTHON to ON
cmake -G Ninja ../llvm \
	-DLLVM_ENABLE_PROJECTS=mlir \
	-DLLVM_BUILD_EXAMPLES=ON \
	-DLLVM_TARGETS_TO_BUILD="X86;NVPTX;AMDGPU" \
    -DMLIR_ENABLE_CUDA_RUNNER=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DCMAKE_C_COMPILER=clang \
	-DCMAKE_CXX_COMPILER=clang++ \
	-DLLVM_ENABLE_LLD=ON \
	-DLLVM_ENABLE_RTTI=ON \
	-DLLVM_INSTALL_UTILS=ON \
	-DMLIR_INCLUDE_INTEGRATION_TESTS=ON \

# ninja -j8
# sudo ninja install
cmake --build . --target check-mlir

# For the python Binding
python -m pip install --upgrade pip
python -m pip install -r mlir/python/requirements.txt
# Add MLIR Python bindings to your Python path.
export PYTHONPATH=$(cd build && pwd)/tools/mlir/python_packages/mlir_core

# Should be `~/llvm-project/build`
export MLIR_PREFIX=/path/to/mlir/ 
# Shoudl be `~/llvm-project/build`
export LLVM_PREFIX=/path/to/llvm-build-dir
```

Test the MLIR python bindings environment.
```shell
$ python
>>> from mlir.ir import Context, Module
>>> ...
```

## Build
### Build and run the simplepass example
```shell
cd ./standalone-templates/simplepass
mkdir build && cd build
cmake -G Ninja .. -DMLIR_DIR=$MLIR_PREFIX/lib/cmake/mlir -DLLVM_EXTERNAL_LIT=$LLVM_PREFIX/bin/llvm-lit

# To build the documentation from the TableGen description of the dialect operations
cmake --build . --target mlir-doc
```
### Build and run the standalone-opt example
```shell
cd ./standalone-templates/standalone-opt
./build_and_run.sh
```

### Build and run the raccoon-mlir [WiP]
```shell
cd raccoon-mlir
mkdir build && cd build
cmake -G Ninja .. \
		  -DMLIR_DIR=$PWD/../llvm-project/build/lib/cmake/mlir \
		  -DLLVM_DIR=$PWD/../llvm-project/build/lib/cmake/llvm \
		  -DLLVM_ENABLE_ASSERTIONS=ON \
		  -DCMAKE_BUILD_TYPE=RELEASE

ninja
ninja check-raccoon
```

## With PyTorch and Tensorflow installed
```shell
conda create -n torchdynamo python=3.8
conda activate torchdynamo
pip3 install torch torchvision torchaudio
```

```shell
conda create -n tf2 python=3.8
conda activate tf2
# TensorFlow 2 packages require a pip version >19.0
pip install tensorflow
```

## MLIR as TorchDynamo and TF Custom Backend
Assume you have already installed pytorch (version >= stable 2.0.0)
```shell
pip install tabulate
cd Raccoon-MLIR-Tour/embedding_exam/torchdynamo

# Run the example
python arith_add.py
```


## How to add new Dialect
MLIR offers a powerful declaratively specification mechanism via [TableGen](https://llvm.org/docs/TableGen/ProgRef.html), a generic language with tooling to maintain records of domain-specific information. We follow the talk given by [Marius Brehler](https://github.com/marbre), please refer [here](https://fosdem.org/2023/schedule/event/mlirdialect/):
A few notes in out-of-tree MLIR CMake file:
- `LLVM_EXTERNAL_PROJECTS`: defines the external projects to be built
- `LLVM_EXTERNAL_STANDALONE_DIALECT_SOURCE_DIR`: defines the source code location

Since MLIR evolves fast, it is possible that it may fail to build the project with a newer LLVM.

Other files:
- `frontend`: Takes a DL model from existing DL frameworks as input, and then transforms
the model into the computation graph representation (e.g., graph IR). The frontend needs to
implement various format transformations to support the diverse formats in different frameworks.
- `midend`: Transforms the high-level IR into low-level IR and performs hardware-specific
optimizations. Transform the high-level IR to third-party toolchains such as LLVM IR to utilize the existing infrastructures for general-purpose optimizations and code generation. (auto-scheduling and auto-tuning can happen here).
- `backend`: Low level IR, LLVM IR for example. The optimized low-level IR is compiled using JIT or AOT to generate codes for different hardware targets. 
- `tools`: Toolchain
- `build_tools`: llvm version file and build tools for this project. Since MLIR evolves fast, it is possible that EmitC fails to build with a newer LLVM.
- `cmake`: CMaketest file

Using your Dialect in other Projects
- Build all dialects via the external projects mechanism, for example see torch-mlir: `LLVM_EXTERNAL_PROJECTS="torch-mlir;torch-mlir-dialects`
- You can also use CMake’s `External_Project_Add()`
- You can add projects via `add_sudirectory()`, for example like [mlir-emitc](https://github.com/marbre/mlir-emitc): `add_subdirectory(third_party/mlir-hlo EXCLUDE_FROM_ALL)`
- For `add_subdirectory()` a new CMake option can be introduced: `option(EMITC_BUILD_EMBEDDED "Build EmitC as part of another project"OFF)`


