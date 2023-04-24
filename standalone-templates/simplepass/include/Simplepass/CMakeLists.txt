set(LLVM_TARGET_DEFINITIONS Simplepass.td)
mlir_tablegen(Simplepass.h.inc -gen-pass-decls -name SimplePass)
add_public_tablegen_target(MLIRSimplePassIncGen)

add_mlir_doc(Simplepass MLIRSimplePass ./ -gen-pass-doc)
