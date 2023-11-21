#include "mlir/IR/AsmState.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/Parser/Parser.h"
#include "mlir/Support/FileUtilities.h"

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "llvm/Support/raw_ostream.h"

using namespace mlir;

int main(int argc, char ** argv) {
	// This context is a shared object that holds global information for MLIR
	MLIRContext ctx;

	// func, arith
	ctx.loadDialect<func::FuncDialect, arith::ArithDialect>();

	// Create Op Builder
	// A utility to construct MLIR operations conveniently
	OpBuilder builder(&ctx);
	// Top level container for MLIR - ModuleOp
	// builder.create is protentially calling Op::build
	auto mod = builder.create<ModuleOp>(builder.getUnknownLoc());
	
	// Insert Point: ModuleOp
	builder.setInsertionPointToEnd(mod.getBody());

	// Function Creation
	auto i32 = builder.getI32Type();
	auto funcType = builder.getFunctionType({i32, i32}, {i32});
	// Sinature as: 2 i32 input and 1 i32 output, name "test" created using func::FuncOp
	auto func = builder.create<func::FuncOp>(builder.getUnknownLoc(), "test", funcType);

	// Basic blocks and operations
	auto entry = func.addEntryBlock();
	auto args = entry->getArguments();

	// Insert Point: func
	builder.setInsertionPointToEnd(entry);

	// Create arith.addi, integer addition on the two arguments
    auto addi = builder.create<arith::AddIOp>(builder.getUnknownLoc(), args[0], args[1]);

	// Create func.return, return result of the addition
	builder.create<func::ReturnOp>(builder.getUnknownLoc(), ValueRange({addi}));
	mod->print(llvm::outs());
	
	return 0;
}
