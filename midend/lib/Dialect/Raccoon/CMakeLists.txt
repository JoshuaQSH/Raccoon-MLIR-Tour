add_mlir_dialect_library(Raccoon
	RaccoonDialect.cpp
	RaccoonOps.cpp

	LINK_LIBS PUBLIC
		MLIRIR
		MLIRInferTypeOpInterface
)
