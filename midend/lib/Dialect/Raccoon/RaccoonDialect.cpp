// ===- RaccoonDialect.cpp - Raccoon Dialect Definition-------------------*- C++ -*-===//
////===----------------------------------------------------------------------===//
////
//// This file defines Raccoon dialect.
////
////===----------------------------------------------------------------------===//


#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/OperationSupport.h"
#include "llvm/ADT/TypeSwitch.h"
#include "llvm/AsmParser/Parser.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/SourceMgr.h"
#include "mlir/Transforms/InliningUtils.h"

#include "Raccoon/RaccoonDialect.h"
#include "Raccoon/RaccoonOps.h"

using namespace mlir;
using namespace rocketraccoon::Raccoon;

#include "Raccoon/RaccoonOpsDialect.cpp.inc"

//===----------------------------------------------------------------------===//
// RaccoonDialect Interfaces
//===----------------------------------------------------------------------===//


namespace {
	struct RaccoonInlinerInterface : public DialectInlinearInterface {
		using DialectInlinerInterface::DialectInlinerInterface;
		// We don't have any special restrictions on what can be inlined into
		// destination regions (e.g. while/conditional bodies). Always allow it.
		bool isLegalToInline(Region *dest, Region *src, bool wouldBeCloned,
				BlockAndValueMapping &valueMapping) const final {
					return true;
				}
		// Always legal to inline in Raccoon dialect?
		bool isLegalToInline(Operation *, Region *, bool, 
				BlockAndValueMapping &) const final {
			return true;
		}
	};
} // namespace


//===----------------------------------------------------------------------===//
// Raccoon dialect.
//===----------------------------------------------------------------------===//
void RaccoonDialect::initialize() {
	addOperations<
	#define GET_OP_LIST
	#include "Raccoon/RaccoonOps.cpp.inc"
	>();
	
	addAttributes<
	#define GET_ATTRDEF_LIST
	#include "Raccoon/RaccoonAttributes.cpp.inc"
	>();
	addInterfaces<RaccoonInlinerInterface>();
}

#include "Raccoon/RaccoonOpsEnums.cpp.inc"

#define GET_ATTRDEF_CLASSES
#include "Raccoon/RaccoonOpsAttributes.cpp.inc"

