set(LLVM_IRReader_DIR ${LLVM_PROJECT_SOURCE_DIR}/llvm/lib/IRReader)

add_llvm_component_library(LLVMRaccoonIRReader
  ${LLVM_IRReader_DIR}/IRReader.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/IRReader

  DEPENDS
  raccoon_intrinsics_gen

  LINK_COMPONENTS
  RaccoonAsmParser
  BitReader
  RaccoonCore
  Support
  )
