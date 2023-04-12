set(LLVM_AsmPrinter_DIR ${LLVM_PROJECT_SOURCE_DIR}/llvm/lib/CodeGen/AsmPrinter)

add_llvm_component_library(LLVMRaccoonAsmPrinter
  ${LLVM_AsmPrinter_DIR}/AccelTable.cpp
  ${LLVM_AsmPrinter_DIR}/AddressPool.cpp
  ${LLVM_AsmPrinter_DIR}/AIXException.cpp
  ${LLVM_AsmPrinter_DIR}/ARMException.cpp
  ${LLVM_AsmPrinter_DIR}/AsmPrinter.cpp
  ${LLVM_AsmPrinter_DIR}/AsmPrinterDwarf.cpp
  ${LLVM_AsmPrinter_DIR}/AsmPrinterInlineAsm.cpp
  ${LLVM_AsmPrinter_DIR}/DbgEntityHistoryCalculator.cpp
  ${LLVM_AsmPrinter_DIR}/DebugHandlerBase.cpp
  ${LLVM_AsmPrinter_DIR}/DebugLocStream.cpp
  ${LLVM_AsmPrinter_DIR}/DIE.cpp
  ${LLVM_AsmPrinter_DIR}/DIEHash.cpp
  ${LLVM_AsmPrinter_DIR}/DwarfCFIException.cpp
  ${LLVM_AsmPrinter_DIR}/DwarfCompileUnit.cpp
  ${LLVM_AsmPrinter_DIR}/DwarfDebug.cpp
  ${LLVM_AsmPrinter_DIR}/DwarfExpression.cpp
  ${LLVM_AsmPrinter_DIR}/DwarfFile.cpp
  ${LLVM_AsmPrinter_DIR}/DwarfStringPool.cpp
  ${LLVM_AsmPrinter_DIR}/DwarfUnit.cpp
  ${LLVM_AsmPrinter_DIR}/EHStreamer.cpp
  ${LLVM_AsmPrinter_DIR}/ErlangGCPrinter.cpp
  ${LLVM_AsmPrinter_DIR}/OcamlGCPrinter.cpp
  ${LLVM_AsmPrinter_DIR}/PseudoProbePrinter.cpp
  ${LLVM_AsmPrinter_DIR}/WinCFGuard.cpp
  ${LLVM_AsmPrinter_DIR}/WinException.cpp
  ${LLVM_AsmPrinter_DIR}/CodeViewDebug.cpp
  ${LLVM_AsmPrinter_DIR}/WasmException.cpp

  DEPENDS
  raccoon_intrinsics_gen

  LINK_COMPONENTS
  RaccoonAnalysis
  BinaryFormat
  RaccoonCodeGen
  RaccoonCore
  DebugInfoCodeView
  DebugInfoDWARF
  DebugInfoMSF
  MC
  MCParser
  RaccoonRemarks
  Support
  RaccoonTarget
  )

