include_directories(${LLVM_PROJECT_SOURCE_DIR}/llvm/include/llvm/IR/)

set(LLVM_TARGET_DEFINITIONS IntrinsicsRaccoonExt.td)
tablegen(LLVM IntrinsicImpl.inc -gen-intrinsic-impl)
tablegen(LLVM IntrinsicEnums.inc -gen-intrinsic-enums)
tablegen(LLVM IntrinsicsRISCV.h -gen-intrinsic-enums -intrinsic-prefix=riscv)
add_public_tablegen_target(raccoon_intrinsics_gen)
