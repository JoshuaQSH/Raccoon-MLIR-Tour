#ifndef SIMPLEMLIR_TRANSFORMS_PASSDETAILS_H
#define SIMPLEMLIR_TRANSFORMS_PASSDETAILS_H

#include "mlir/Pass/Pass.h"

#include "Simplepass/Simplepass.h"

namespace mlir {
	namespace simplepass {

#define GEN_PASS_CLASSES
#include "Simplepass/Simplepass.h.inc"

	} // namespace simplepass
} // namespace mlir

#endif // SIMPLEMLIR_TRANSFORMS_PASSDETAILS_H
