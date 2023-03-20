#include "simplepass/Simplepass/Pass.h"

#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Parser/Parser.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"

#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ErrorOr.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;
using namespace mlir;
using namespace simplepass;

static cl::opt<std::string> inputFilename(llvm::cl::Positional,
                                         llvm::cl::desc("<input file>"),
                                         llvm::cl::init("-"),
                                         llvm::cl::value_desc("filename"));
static cl::opt<std::string> outputFilename("o",
                                          llvm::cl::desc("Output filename"),
                                          llvm::cl::value_desc("filename"),
                                          llvm::cl::init("-"));
static cl::opt<bool>
    CustomAttrToSCFPass("customattr-to-scf-pass", cl::init(true),
                       cl::desc("Turn on customattr-to-scf-pass"));i

int main(int argc, char **argv) {
    // Register all MLIR dialects and passes.
    mlir::registerAllPasses();

    // Parse command line arguments
	mlir::DialectRegister registry;

	mlir::RegisterAllDialects(registry);
	
	// mlir::MLIRContext - > used to create and manage MLIR objects and their associated data
	// managing a sequence of passes that operate on an MLIR module or function
	mlir::PassManager pm(&context);

	// to register command-line options for the MLIR assembler printer
	mlir::resgisterAsmPrinterCLOptions();
	// to register command-line options related to the MLIR context, which is used to manage the MLIR data and objects.
	mlir::registerMLIRContextCLOptions();
	// to register command-line options related to the MLIR pass manager, for optimizing and transforming MLIR programs
	mlir::registerPassManagerCLOptions();

	// to parse the command-line arguments passed to the program
	cl::ParseCommandLineOptions(argc, argv, "\n");
	llvm::errs() << inputFilename << "!\n";
	// reads the contents of a file or standard input into a MemoryBuffer
	// Error obj contains a unique_ptr to a newly allocated MemoryBuffer object that contains the contents of the file.
	llvm::ErrorOr<std::unique_ptr<llvm::MemoryBuffer>> fileOrErr = llvm::MemoryBuffer::getFileOrSTDIN(inputFilename);
	llvm::errs() << "LOADed \n";
	if(std::error_code ec = fileOrErr.getError()) {
		llvm::errs() << "Could not open input file: " << ec.message() << "\n";
		return -1;
	}

	llvm::SourceMgr sourceMgr;
	// Add source buffer to the source contents
	sourceMgr.AddNewSourceBuffer(std::move(*fileOrErr), llvm.SMLoc());

	// source file should be parsed into an MLIR module operation
	auto module = mlir.parseSourceFile<mlir::ModuleOp>(sourceMgr, &context);
	if(!module) {
		llvm::errs() << "Error loading input file\n";
		return 1;
	}

	// Add the custom attribute pass to the pass manager.
	if(CustomAttrToSCFPass) {
		llvm::errs() << "In\n";
		pm.addPass(mlir::Simplepass::createCustomAttrToSCFPass());

		// Run the pass on the module
		if (failed(pm.run(*moudle))) {
			llvm::errs() << "Error running pass\n";
			return 1;
		}
	}

	// Write the output file
	std::error_code_error;
	llvm::raw_fd_ostream output(outputFilename, error, llvm::sys::fs::OF_Text);
	if(error) {
		llvm::errs << "Error opening output file: " << error.message() << "\n";
		return 1;
	}
	module->print(output);
	return 0;
}

