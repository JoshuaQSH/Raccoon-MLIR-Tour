module {
  func.func private @print_memref_2d_f64(memref<2048x2048xf64>)
  func.func @matmul(%arg0: memref<2048x2048xf64>, %arg1: memref<2048x2048xf64>, %arg2: memref<2048x2048xf64>) {
    %c0 = arith.constant 0 : index
    %c2048 = arith.constant 2048 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c2048 step %c1 {
      %c0_0 = arith.constant 0 : index
      %c2048_1 = arith.constant 2048 : index
      %c1_2 = arith.constant 1 : index
      scf.for %arg4 = %c0_0 to %c2048_1 step %c1_2 {
        %c0_3 = arith.constant 0 : index
        %c2048_4 = arith.constant 2048 : index
        %c1_5 = arith.constant 1 : index
        scf.for %arg5 = %c0_3 to %c2048_4 step %c1_5 {
          %0 = memref.load %arg0[%arg3, %arg5] : memref<2048x2048xf64>
          %1 = memref.load %arg1[%arg5, %arg4] : memref<2048x2048xf64>
          %2 = memref.load %arg2[%arg3, %arg4] : memref<2048x2048xf64>
          %3 = arith.mulf %0, %1 : f64
          %4 = arith.addf %2, %3 : f64
          memref.store %4, %arg2[%arg3, %arg4] : memref<2048x2048xf64>
        }
      }
    }
    return
  }
  func.func @main() {
    %c0 = arith.constant 0 : index
    %c2048 = arith.constant 2048 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 1.000000e+00 : f64
    %alloc = memref.alloc() : memref<2048x2048xf64>
    %alloc_0 = memref.alloc() : memref<2048x2048xf64>
    %alloc_1 = memref.alloc() : memref<2048x2048xf64>
    scf.for %arg0 = %c0 to %c2048 step %c1 {
      scf.for %arg1 = %c0 to %c2048 step %c1 {
        memref.store %cst, %alloc[%arg0, %arg1] : memref<2048x2048xf64>
      }
    }
    scf.for %arg0 = %c0 to %c2048 step %c1 {
      scf.for %arg1 = %c0 to %c2048 step %c1 {
        memref.store %cst, %alloc_0[%arg0, %arg1] : memref<2048x2048xf64>
      }
    }
    scf.for %arg0 = %c0 to %c2048 step %c1 {
      scf.for %arg1 = %c0 to %c2048 step %c1 {
        memref.store %cst, %alloc_1[%arg0, %arg1] : memref<2048x2048xf64>
      }
    }
    call @matmul(%alloc, %alloc_0, %alloc_1) : (memref<2048x2048xf64>, memref<2048x2048xf64>, memref<2048x2048xf64>) -> ()
    call @print_memref_2d_f64(%alloc_1) : (memref<2048x2048xf64>) -> ()
    return
  }
}

