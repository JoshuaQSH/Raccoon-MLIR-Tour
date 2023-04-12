set(LLVM_MIRParser_DIR ${LLVM_PROJECT_SOURCE_DIR}/llvm/lib/CodeGen/MIRParser)

add_llvm_component_library(LLVMRaccoonMIRParser
  ${LLVM_MIRParser_DIR}/MILexer.cpp
  ${LLVM_MIRParser_DIR}/MIParser.cpp
  ${LLVM_MIRParser_DIR}/MIRParser.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/CodeGen/MIRParser

  DEPENDS
  raccoon_intrinsics_gen

  LINK_COMPONENTS
  RaccoonAsmParser
  BinaryFormat
  RaccoonCodeGen
  RaccoonCore
  MC
  Support
  RaccoonTarget
  )
