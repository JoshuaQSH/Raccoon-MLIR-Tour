# An easy tour towards MLIR
Shout out to Chris Lattner.
[Brief Introduction of MLIR in Chinese](https://zhuanlan.zhihu.com/p/442140282)

Hopefully this tour will help you find the way to quickly jump into MLIR.

We assume you have already built your MLIR under the home directory `./llvm-project`. If not then you can follow the Building guide as well:

## Build and Get Started
```shell
git clone https://github.com/llvm/llvm-project.git
mkdir llvm-project/build
cd llvm-project/build
# Also, remember to turn MLIR_ENABLE_BINDINGS_PYTHON to ON
cmake -G Ninja ../llvm \
	-DLLVM_ENABLE_PROJECTS=mlir \
	-DLLVM_BUILD_EXAMPLES=ON \
	-DLLVM_TARGETS_TO_BUILD="X86;NVPTX;AMDGPU" \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DCMAKE_C_COMPILER=clang \
	-DCMAKE_CXX_COMPILER=clang++ \
	-DLLVM_ENABLE_LLD=ON \

cmake --build . --target check-mlir

# For the python Binding
python -m pip install --upgrade pip
python -m pip install -r mlir/python/requirements.txt
export PYTHONPATH=$(cd build && pwd)/tools/mlir/python_packages/mlir_core
```
