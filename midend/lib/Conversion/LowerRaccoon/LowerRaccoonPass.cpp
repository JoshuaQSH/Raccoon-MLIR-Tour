//===----------------------------------------------------------------------===//
////
//// This file defines Raccoon dialect lowering pass.
////
////===----------------------------------------------------------------------===//


#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Bufferization/Transforms/Bufferize.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/Pass/Pass.h"

#include "Raccoon/RaccoonDialect.h"
#include "Raccoon/RaccoonOps.h"

using namespace mlir;
using namespace rocketraccoon;

//===----------------------------------------------------------------------===//
//// Rewrite Pattern
////===----------------------------------------------------------------------===//

namespace {
	class RaccoonTestConstantLowering : OpRewritePattern<Raccoon::TestConstantOp> {
		public:
			using OpRewritePattern<Raccoon::TestConstantOp>::OpRewritePattern;
			LogicalResult matchAndRewrite(Raccoon::TestConstantOp op,
					PatternRewriter &rewriter) const override {
				auto loc = op.getLoc();
				// Get type from the origin operation.
				Type resultType = op.getResult().getType();
				// Create constant operation.
				Attribute zeroAttr = rewriter.getZeroAttr(resultType);
				Value c0 = rewriter.create<mlir::arith::ConstantOp>(loc, 
						resultType, 
						zeroAttr);
				rewriter.replaceOp(op, c0);
				return success();
			}
	};

	class RaccoonTestPrintLowering : public OpRewritePattern<Raccoon::TestPrintOp> {
		public:
			using OpRewritePattern<Raccoon::TestPrintOp>::OpRewritePattern;
			LogicalResult matchAndRewrite(Raccoon::TestPrintOp op, 
					PatternRewriter &rewriter) const override {
				auto loc = op.getLoc();
				// Get type from the origin operation.
				Type resultType = op.getResult().getType();
				// Create constant operation.
				Attribute zeroAttr = rewriter.getZeroAttr(resultType);
				Value c0 = rewriter.create<mlir::arith::ConstantOp>(loc, 
						resultType, 
						zeroAttr);
				// Create print operation for the scalar value.
				rewriter.create<vector::PrintOp>(loc, c0);
				// get {NUMBER OF ELEMENTS IN THE VECTOR}
				VectorType vectorTy4 = VectorType::get({4}, resultType);
				// Broadcast element of the kernel.
				Value broadcastVector = rewriter.create<vector::BroadcastOp>(loc, 
						vectorTy4, 
						c0);
				// Create print operation for the vector value.
				rewriter.create<vector::PrintOp>(loc, broadcastVector);
				rewriter.eraseOp(op);
				return success();
			}
	};

	class RaccoonTestEnumAttrLowering : public OpRewritePattern<Raccoon::TestEnumAttrOp> {
		public:
			using OpRewritePattern<Raccoon::TestEnumAttrOp>::OpRewritePattern;
			LogicalResult matchAndRewrite(Raccoon::TestEnumAttrOp op,
					PatternRewriter &rewriter) const override {
				auto loc = op.getLoc();
				// Get type from the origin operation.
				Type resultType = op.getResult().getType();
				// Get the attribute.
				auto arithAttr = op.getArith();
				// Get the lhs and rhs.
				Value lhs = op.getLhs();
				Value rhs = op.getRhs();
				Value result;
				// Lowering to different ops according to the attribute.
				if (arithAttr == rocketraccoon::Raccoon::TestEnumAttrOperation::ADD)
					// Create addi operation.
					result = rewriter.create<arith::AddIOp>(loc, resultType, lhs, rhs);
				if (arithAttr == rocketraccoon::Raccoon::TestEnumAttrOperation::SUB)
					// Create subi operation.
					result = rewriter.create<arith::SubIOp>(loc, resultType, lhs, rhs);
				rewriter.replaceOp(op, result);
				return success();
			}
	};

	class RaccoonTestArrayAttrLowering : public OpRewritePattern<Raccoon::TestArrayAttrOp> {
		public:
			using OpRewritePattern<Raccoon::TestArrayAttrOp>::OpRewritePattern;
			LogicalResult matchAndRewrite(Raccoon::TestArrayAttrOp op,
					PatternRewriter &rewriter) const override {
				auto loc = op.getLoc();
				// Get the attribute and the value.
				ArrayAttr coordinateAttr = op.getCoordinate();
				int64_t valX = coordinateAttr[0].cast<IntegerAttr>().getInt();
				int64_t valY = coordinateAttr[1].cast<IntegerAttr>().getInt();
				// Get the index attribute and constant value.
				IntegerAttr attrX = rewriter.getIntegerAttr(rewriter.getIndexType(), valX);
				IntegerAttr attrY = rewriter.getIntegerAttr(rewriter.getIndexType(), valY);
				Value idxX = rewriter.create<arith::ConstantOp>(loc, attrX);
				Value idxY = rewriter.create<arith::ConstantOp>(loc, attrY);
				SmallVector<Value, 2> memrefIdx = {idxX, idxY};
				// Get base memref.
				Value memref = op.getBase();
				// Create memref load operation.
				Value result = rewriter.create<memref::LoadOp>(loc, memref, memrefIdx);
				rewriter.replaceOp(op, result);
				return success();
			}
	};

	class RaccoonVectorConfigLowering : public OpRewritePattern<Raccoon::VectorConfigOp> {
		public:
			using OpRewritePattern<Raccoon::VectorConfigOp>::OpRewritePattern;
			LogicalResult matchAndRewrite(Raccoon::VectorConfigOp op, 
					PatternRewriter &rewriter) const override {
				auto loc = op.getLoc();
				mlir::Region &configRegion = op.getRegion();
				mlir::Block &configBlock = configRegion.front();
				for (mlir::Operation &innerOp : configBlock.getOperations()) {
					if (isa<arith::AddFOp>(innerOp)) {
						Type resultType = cast<arith::AddFOp>(innerOp).getResult().getType();
						Value result = rewriter.create<LLVM::VPFAddOp>(
								loc, 
								resultType, 
								cast<arith::AddFOp>(innerOp).getLhs(),
								cast<arith::AddFOp>(innerOp).getRhs(), 
								op.getMask(), 
								op.getVl());
						rewriter.replaceOp(op, result);
					}
				}
				return success();
			}
	};
} // end anonymous namespace


void populateLowerRaccoonConversionPatterns(RewritePatternSet &patterns) {
	patterns.add<
		RaccoonTestConstantLowering,
		RaccoonTestPrintLowering,
		RaccoonTestEnumAttrLowering,
		RaccoonTestArrayAttrLowering,
		RaccoonVectorConfigLowering>(patterns.getContext());
}


//===----------------------------------------------------------------------===//
//// LowerRaccoonPass
////===----------------------------------------------------------------------===//

namespace {
	class LowerRaccoonPass : public PassWrapper<LowerRaccoonPass, OperationPass<ModuleOp>> {
		public:
			MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(LowerRaccoonPass)
			LowerRaccoonPass() = default;
			LowerRaccoonPass(const LowerRaccoonPass &) {}
			StringRef getArgument() const final { return "lower-raccoon"; }
			StringRef getDescription() const final { return "Lower Raccoon Dialect."; }
			void runOnOperation() override;
			void getDependentDialects(DialectRegistry &registry) const override {
				registry.insert<
					rocketraccoon::Raccoon::RaccoonDialect,
					func::FuncDialect,
					vector::VectorDialect,
					memref::MemRefDialect,
					LLVM::LLVMDialect>();
			}

	};
} // end anonymous namespace.


void LowerRaccoonPass::runOnOperation() {
	MLIRContext *context = &getContext();
	ModuleOp module = getOperation();
	ConversionTarget target(*context);
	target.addLegalDialect<
		arith::ArithDialect,
		func::FuncDialect,
		vector::VectorDialect,
		memref::MemRefDialect,
		LLVM::LLVMDialect>();
	target.addLegalOp<ModuleOp, func::FuncOp, func::ReturnOp>();
	RwritePatternSet patterns(context);
	populateLowerRaccoonConversionPatterns(patterns);
	if (failed(applyPartialConversion(module, target, std::move(patterns))))
		signalPassFailure();
}

namespace mlir{
	namespace rocketraccoon {
		void registerLowerRaccoonPass() { PassRegistration<LowerRaccoonPass>(); }
	} // namespace rocketraccoon
} // namespace mlir



