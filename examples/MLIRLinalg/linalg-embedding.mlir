module {
  func.func private @printMemrefF32(memref<*xf32>)
  
  func.func @embedding_lookup(%a : memref<1x?xi64>, %b : memref<?x?xf32>,  %c : memref<1x?xf32>) {
    linalg.matmul
      ins(%a, %b: memref<1x?xi64>, memref<?x?xf32>)
      outs(%c : memref<1x?xf32>)
      return
  }

  func.func @main(){
    // Set up dims.
	// %cC = arith.constant 1 : index 
    %cM = arith.constant 4 : index
    %cN = arith.constant 4 : index

    // Set up init value
    %cf1 = arith.constant 3.0 : f32
    %cf2 = arith.constant 1 : i64
    
	%A = memref.alloc(%cM) : memref<1x?xi64>
    %B = memref.alloc(%cM, %cN) : memref<?x?xf32>
    %C = memref.alloc(%cN) : memref<1x?xf32>

    linalg.fill
      ins(%cf2 : i64)
      outs(%A:memref<1x?xi64>)

    linalg.fill
      ins(%cf1 : f32)
      outs(%B:memref<?x?xf32>)

    linalg.fill
      ins(%cf1 : f32)
      outs(%C:memref<1x?xf32>)
    
    call @embedding_lookup(%A, %B, %C) : (memref<1x?xi64>, memref<?x?xf32>, memref<1x?xf32>) -> ()
    %print_C = memref.cast %C : memref<1x?xf32> to memref<*xf32>
    call @printMemrefF32(%print_C) : (memref<*xf32>) -> ()
    
    memref.dealloc %C : memref<1x?xf32>
    memref.dealloc %B : memref<?x?xf32>
    memref.dealloc %A : memref<1x?xi64>

    return
  }
}
