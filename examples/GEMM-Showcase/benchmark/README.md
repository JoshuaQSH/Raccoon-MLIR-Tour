# Running commands

```shell
$ export MLIR_RUNNER_UTILS=/path/to/the/libmlir_runner_utils.so
$ export MLIR_C_RUNNER_UTILS=/path/to/the/libmlir_c_runner_utils.so

$ mlir-opt benchmark/dgemm-tiled-benchmark.mlir \
    -hopt='vect=true copy=true unroll=true scalrep=true' \
    -convert-linalg-to-loops -lower-affine -convert-scf-to-std \
    -convert-memref-to-llvm='use-aligned-alloc=1' -convert-std-to-llvm \
    -canonicalize \
    | mlir-cpu-runner  -O3  -e main -time -reps=5 -entry-point-result=void \
    -shared-libs=$MLIR_RUNNER_UTILS \
    -shared-libs=$MLIR_C_RUNNER_UTILS > /dev/null
```

The generated MLIR can be inspected by running the following while adding/removing individual flags:
`$ mlir-opt -hopt='vect=true,copy=true,unroll=true,scalrep=true' dgemm-tiled-benchmark.mlir`

MLIR has a accordance flags (affine pass) to run the benchmark, try `-affine-super-vectorize` and `-affine-scarlrep`

