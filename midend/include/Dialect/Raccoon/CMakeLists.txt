set(LLVM_TARGET_DEFINITIONS RaccoonOps.td)
mlir_tablegen(RaccoonOpsEnums.h.inc -gen-enum-decls)
mlir_tablegen(RaccoonEnums.cpp.inc -gen-enum-defs)

set(LLVM_TARGET_DEFINITIONS RaccoonOps.td)
mlir_tablegen(RaccoonOpsAttributes.h.inc -gen-attrdef-decls)
mlir_tablegen(RaccoonOpsAttributes.cpp.inc -gen-attrdef-defs)

add_mlir_dialect(RaccoonOps raccoon)
add_mlir_doc(RaccoonDialect -gen-dialect-doc RaccoonDialect Raccoon/)
add_mlir_doc(RaccoonOps -gen-op-doc RaccoonOps Raccoon/)
