set(LLVM_LINK_COMPONENTS
	# Targets
	AllTargetsAsmParsers
	AllTargetsCodeGens
	AllTargetsDescs
	AllTargetsInfos

	# utils
	RaccoonAnalysis
	RaccoonAsmParser
	RaccoonAsmPrinter
	RaccoonCodeGen
	RaccoonCore
	RaccoonIRReader
	MC
	RaccoonMIRParser
	RaccoonRemarks
	RaccoonScalarOpts
	RaccoonSelectionDAG
	Support
	RaccoonTarget
)

add_llvm_tool(raccoon-llc
	${LLVM_PROJECT_SOURCE_DIR}/llvm/tools/llc/llc.cpp
	DEPENDS
	raccoon_intrinsics_gen
	SUPPORT_PLUGINS
)

export_executable_symbols_for_plugins(raccoon-llc)
