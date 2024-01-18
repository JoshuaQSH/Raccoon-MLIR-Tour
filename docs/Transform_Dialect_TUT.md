# A Transform Dialect Tutorial

Refs: [MLIR Doc](https://mlir.llvm.org/docs/Tutorials/transform/)

## Chapter 0
MLIR’s arithmetic operations on vectors preserve the structure of uniform elementwise application. The structure allows the compiler to produce saller-rank operations available on the target or to fuse multiplication and addition.

```c++
// Reduction
%0 = vector.reduction <add>, %0 : vector <8xf32> into f32

// Transformed into a loop:
%c0 = arith.constant 0 : index
%c1 = arith.constant 1 : index
%c8 = arith.constant 8 : index
%init = arith.constant 0.0 : f32
%result = scf.for %i = %c0 to %c8 step %c1 iter_args(%partial = %init) -> (f32) {
  %element = vector.extractelement %0[%i : index] : vector<8xf32>
  %updated = arith.addf %partial, %element : f32
  scf.yield %updated : f32
}

```

MLIR can also do the 2D+ case contraction (i.e. Contraction is a generalization of reduction that multiplies elements from two vectors before adding them up.) 

```c++
// 3D contraction that encodes a matrix-matrix multiplication
%result = vector.contract {
  indexing_maps = [affine_map<(i, j, k) -> (i, k)>,
                   affine_map<(i, j, k) -> (k, j)>,
                   affine_map<(i, j, k) -> (i, j)>],
  iterator_types = ["parallel", "parallel", "reduction"]
} %lhs, %rhs, %init: vector<8x10xf32>, vector<10x16xf32> into vector<8x16xf32>

// loop form:
for i in 0 to 8:
	for j in 0 to 16:
		for k in 0 to 10:
			init[i, j] += lhs[i, k] * rhs[k, j]
```


