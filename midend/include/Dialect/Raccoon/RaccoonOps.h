//===----------------------------------------------------------------------===//
//
// This is the header file for operations in Raccoon dialect. 
//
//===----------------------------------------------------------------------===//

#ifndef RACCOON_RACCOONOPS_H
#define RACCOON_RACCOONOPS_H

#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/InferTypeOpInterface.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

#include "Raccoon/RaccoonOpsEnums.h.inc"

#define GET_ATTRDEF_CLASSES
#include "Raccoon/RaccoonOpsAttributes.h.inc"

#define GET_OP_CLASSES
#include "Raccoon/RaccoonOps.h.inc"

#endif // RACCOON_RACCOONOPS_H
