module {
  func.func private @print_memref_2d_f64(memref<2048x2048xf64>)
  func.func @matmul(%arg0: memref<2048x2048xf64>, %arg1: memref<2048x2048xf64>, %arg2: memref<2048x2048xf64>) {
    affine.for %arg3 = 0 to 2048 {
      affine.for %arg4 = 0 to 2048 {
        affine.for %arg5 = 0 to 2048 {
          %0 = affine.load %arg0[%arg3, %arg5] : memref<2048x2048xf64>
          %1 = affine.load %arg1[%arg5, %arg4] : memref<2048x2048xf64>
          %2 = affine.load %arg2[%arg3, %arg4] : memref<2048x2048xf64>
          %3 = arith.mulf %0, %1 : f64
          %4 = arith.addf %2, %3 : f64
          affine.store %4, %arg2[%arg3, %arg4] : memref<2048x2048xf64>
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
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb5
    %1 = arith.cmpi slt, %0, %c2048 : index
    llvm.cond_br %1, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%c0 : index)
  ^bb3(%2: index):  // 2 preds: ^bb2, ^bb4
    %3 = arith.cmpi slt, %2, %c2048 : index
    llvm.cond_br %3, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    memref.store %cst, %alloc[%0, %2] : memref<2048x2048xf64>
    %4 = arith.addi %2, %c1 : index
    cf.br ^bb3(%4 : index)
  ^bb5:  // pred: ^bb3
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb6:  // pred: ^bb1
    cf.br ^bb7(%c0 : index)
  ^bb7(%6: index):  // 2 preds: ^bb6, ^bb11
    %7 = arith.cmpi slt, %6, %c2048 : index
    llvm.cond_br %7, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    cf.br ^bb9(%c0 : index)
  ^bb9(%8: index):  // 2 preds: ^bb8, ^bb10
    %9 = arith.cmpi slt, %8, %c2048 : index
    llvm.cond_br %9, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    memref.store %cst, %alloc_0[%6, %8] : memref<2048x2048xf64>
    %10 = arith.addi %8, %c1 : index
    cf.br ^bb9(%10 : index)
  ^bb11:  // pred: ^bb9
    %11 = arith.addi %6, %c1 : index
    cf.br ^bb7(%11 : index)
  ^bb12:  // pred: ^bb7
    cf.br ^bb13(%c0 : index)
  ^bb13(%12: index):  // 2 preds: ^bb12, ^bb17
    %13 = arith.cmpi slt, %12, %c2048 : index
    llvm.cond_br %13, ^bb14, ^bb18
  ^bb14:  // pred: ^bb13
    cf.br ^bb15(%c0 : index)
  ^bb15(%14: index):  // 2 preds: ^bb14, ^bb16
    %15 = arith.cmpi slt, %14, %c2048 : index
    llvm.cond_br %15, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    memref.store %cst, %alloc_1[%12, %14] : memref<2048x2048xf64>
    %16 = arith.addi %14, %c1 : index
    cf.br ^bb15(%16 : index)
  ^bb17:  // pred: ^bb15
    %17 = arith.addi %12, %c1 : index
    cf.br ^bb13(%17 : index)
  ^bb18:  // pred: ^bb13
    call @matmul(%alloc, %alloc_0, %alloc_1) : (memref<2048x2048xf64>, memref<2048x2048xf64>, memref<2048x2048xf64>) -> ()
    call @print_memref_2d_f64(%alloc_1) : (memref<2048x2048xf64>) -> ()
    return
  }
}

