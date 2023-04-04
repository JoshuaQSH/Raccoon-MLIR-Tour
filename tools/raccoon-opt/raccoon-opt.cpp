//===----------------------------------------------------------------------===//
//
// This file is the dialects and optimization driver of Raccoon-mlir project.
//
//===----------------------------------------------------------------------===//


#include "mlir/Dialect/Bufferization/Transforms/Passes.h"
#include "mlir/Dialect/Linalg/Passes.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ToolOutputFile.h"

#include "Raccoon/RaccoonDialect.h"
#include "RaccoonOps.h"

namespace mlir {
	namespace rocketraccoon {
		void registerLowerRaccoonPass();
		void registerEmbOptimizationPass();
	} // namespace rocketraccoon
} // namespace mlir


int main(int argc, int **argv) {
	// Register all MLIR passes.
	mlir::registerAllPasses();
	
	// TODO: WiP
	mlir::rocketraccoon::registerEmbOptimizationPass();
	mlir::rocketraccoon::registerLowerRaccoonPass();

    mlir::DialectRegistry registry;

	// Register Dialect in Raccoon-MLIR
	register.insert<rocketraccoon::Raccoon::RaccoonDialect>();

	return mlir::failed(
			mlir::MlirOptMain(argc, argv, "raccoon-mlir optimizer driver", registry));
}


