# Refers to: Using MLIR for High-Performance Code Gen (by Uday Bondhugula)

## Motivation

The computationally demanding routines driving the state-of-the-art in domains such as dense linear algebra and deep learning are all based on carefully hand-optimized and tuned libraries developed with significant engineering effort and insights over time. The techniques and the level of attention necessary to optimize for near-peak performance on a target architecture makes the process often inaccessible to those without a deep knowledge of code optimization and low-level interactions with hardware. 

This is to show that, a more modular, automatable and systematic is possible with the help of MLIR. This completely avoids the need to write any code by hand --- be it C or inline assembly. The IR infrastructure that will be used here is MLIR, and we will try to recreate the OpenBLAS/BLIS' optimization approach in a compiler-oriented way using MLIR.

## Running case - DGEMM
Matrix-matrix multiplication is often an excellent routine for a tutorial or exercise in code optimization because a number of standard practices could be demonstrated using it. It is also one of the most important ones for many domains and thus often the first thing one builds an optimized implementation for when rolling out a new architecture.

Calculate case: 
C = beta \* C + alpha \* A \* B
where A, B, and C are matrices of double-precision floating-point numbers). 

## Covered Dialects: memrefs, affine
```shell
# Path
export MLIR_RUNNER_UTILS=/home/shenghao/llvm-project/build/lib/libmlir_runner_utils.so
export MLIR_C_RUNNER_UTILS=/home/shenghao/llvm-project/build/lib/libmlir_c_runner_utils.so
export MLIR_ASYNC_RUNTIME=/home/shenghao/llvm-project/build/lib/libmlir_async_runtime.so
```


## Start with the GEMM cases with `clang -O3`

### Case-1: [Baseline] `-O3 -ffast-math`
```shell
# ffast-math: allow aggressive, lossy floating-point optimizations
$ clang -O3 -ffast-math -DTIME matmul.c -o matmul_clang -lm

$ gcc -O3 -ffast-math -DTIME matmul.c -o matmul_gcc -lm
```


### Case-2: [MLIR NOOP]
```
# /home/shenghao/llvm-project/build/lib/libmlir_runner_utils.so 
$ mlir-opt -hopt -convert-linalg-to-loops -lower-affine -convert-std-to-llvm hopt.mlir | mlir-cpu-runner -O3 -e main -entry-point-result=void -shared-libs=lib/libmlir_runner_utils.so > /dev/null
```

## How to run the benchmark?
```shell
$ mlir-opt -hopt -hopt-vect -hopt-copy -hopt-unroll -hopt-scalrep dgemm-tiled-benchmark.mlir

# Standalone
$ mlir-opt -affine-vectorize -affine-scalrep dgemm-tiled-benchmark.mlir
```

Command-line flags:
- `hopt`: Customized matmul optimization sequence (based on the BLIS schedule) where the following opts can be enabled incrementally.
- `hopt-vect`: Enable auto-vectorization.
- `hopt-copy`: Enable packing of memrefs.
- `hopt-unroll`: Enable unroll-and-jam and unroll.
- `hopt-scalrep`: Perform scalar replacement.

Any combination of these could be used. The only optimization step not included here is of loop tiling: as such, we start from an already tiled loop nest in dgemm-tiled-benchmark.mlir (albeit with no other optimizations on it). Performing the tiling via the existing utilities (mlir::tile and mlir::interchange) is left as an exercise to the reader. :)

To try some of these optimizations standalone:
- `affine-vectorize`: Auto-vectorization (entirely different from the -affine-vectorize/"super vectorizer" in MLIR tree).
- `affine-scalrep`: Perform scalar replacement on subscripted memref accesses
