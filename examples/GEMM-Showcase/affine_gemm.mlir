module {

	func.func private @print_memref_2d_f64(memref<2048x2048xf64>)

	// C += A * B.
	func.func @matmul(%A: memref<2048x2048xf64>, %B: memref<2048x2048xf64>, %C: memref<2048x2048xf64>) {
		affine.for %arg3 = 0 to 2048 {
			affine.for %arg4 = 0 to 2048 {
				affine.for %arg5 = 0 to 2048 {
					%a = affine.load %A[%arg3, %arg5] : memref<2048x2048xf64>
					%b = affine.load %B[%arg5, %arg4] : memref<2048x2048xf64>
					%ci = affine.load %C[%arg3, %arg4] : memref<2048x2048xf64>
					%p = arith.mulf %a, %b : f64
					%co = arith.addf %ci, %p : f64
					affine.store %co, %C[%arg3, %arg4] : memref<2048x2048xf64>
				}
			}
		}
		func.return
	}

	func.func @main() {
		%A = memref.alloc() : memref<2048x2048xf64>
		%B = memref.alloc() : memref<2048x2048xf64>
		%C = memref.alloc() : memref<2048x2048xf64>

		%cf1 = arith.constant 1.00000e+00 : f64

		linalg.fill ins(%cf1 : f64) outs(%A : memref<2048x2048xf64>)
		linalg.fill ins(%cf1 : f64) outs(%B : memref<2048x2048xf64>)
		linalg.fill ins(%cf1 : f64) outs(%C : memref<2048x2048xf64>)

		func.call @matmul(%A, %B, %C) : (memref<2048x2048xf64>, memref<2048x2048xf64>, memref<2048x2048xf64>) -> ()
		func.call @print_memref_2d_f64(%C): (memref<2048x2048xf64>) -> ()
		func.return
	}
}

