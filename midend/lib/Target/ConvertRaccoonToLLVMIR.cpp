//===----------------------------------------------------------------------===//
////
//// This file implements a translation between the MLIR LLVM dialect and LLVM IR.
////
////===----------------------------------------------------------------------===//


#include "mlir/IR/BuiltinOps.h"
#include "mlir/Target/LLVMIR/Dialect/All.h"
#include "mlir/Target/LLVMIR/Export.h"
#include "mlir/Tools/mlir-translate/Translation.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"

using namespace rocketraccoon;
using namespace mlir;

namespace rocketraccoon {
	void registerRaccoonToLLVMIRTranslation() {
		// translation from an MLIR in the Raccoon toolchain to LLVM IR
		TranslateFromMLIRRegistration registration(
				"raccoon-to-llvmir", "translate MLIR from buddy toolchain to LLVM IR",
				[](ModuleOp module, raw_ostream &output) {
					// returns either a success or failure status of the translation
					// prints the LLVM module to the output stream.
					llvm::LLVMContext llvmContext;
					auto llvmModule = translateModuleToLLVMIR(module, llvmContext);
					if (!llvmModule)
						return failure();
					llvmModule->print(output, nullptr);
					return success();
				},
				// registers the translation for the relevant dialects.
				[](DialectRegistry &registry) {
					// Register translation in upstream MLIR.
					registerArmNeonDialectTranslation(registry);
					registerAMXDialectTranslation(registry);
					registerArmSVEDialectTranslation(registry);
					registerLLVMDialectTranslation(registry);
					registerNVVMDialectTranslation(registry);
					registerOpenACCDialectTranslation(registry);
					registerOpenMPDialectTranslation(registry);
					registerROCDLDialectTranslation(registry);
					registerX86VectorDialectTranslation(registry);
					// Register translation in buddy project. [WiP]
				});
	}
} // namespace rocketraccoon

