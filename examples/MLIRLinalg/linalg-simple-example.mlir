// Simplily run with mlir-opt


// Run: mlir-opt example1.mlir -allow-unregistered-dialect -convert-linalg-to-loops
// This converted representation is in the `scf` dialect.
// It's syntax can be found here: https://mlir.llvm.org/docs/Dialects/SCFDialect/

module {
	func.func private @printMemrefF32(memref<*xf32>)

	func.func @example(%arg0: memref<?xf32>,
					   %arg1: memref<?xvector<4xf32>, strided<[2], offset: 1>>) {
		%c0 = arith.constant 0 : index
		%c1 = arith.constant 1 : index
		%0 = memref.dim %arg0, %c0 : memref<?xf32>
		scf.for %arg2 = %c0 to %0 step %c1 {
			%1 = memref.load %arg0[%arg2] : memref<?xf32>
			%2 = memref.load %arg1[%arg2]
				: memref<?xvector<4xf32>, strided<[2], offset: 1>>
			%3 = "some_compute"(%1, %2) : (f32, vector<4xf32>) -> vector<4xf32>
			memref.store %3, %arg1[%arg2]
				: memref<?xvector<4xf32>, strided<[2], offset: 1>>
		}

		return
	}
}
