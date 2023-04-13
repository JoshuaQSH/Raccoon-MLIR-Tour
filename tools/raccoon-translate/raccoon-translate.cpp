//===----------------------------------------------------------------------===//
//
// This is a command line utility that translates a file from/to MLIR using one
// of the registered translations.
//
//===----------------------------------------------------------------------===//


#include "mlir/InitAllTranslations.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Tools/mlir-translate/MlirTranslateMain.h"

using namespace rocketraccoon;
using namespace mlir;

namespace rocketraccoon {
	void registerRaccoonToLLVMIRTranslation();
}

int main(int argc, int** argv) {
	mlir::registerAllTranslations();
	rocketraccoon::registerRaccoonToLLVMIRTranslation();

	return failed(mlir::mlirTranslateMain(argc, argv, "Raccoon Translation Tool"));
}

