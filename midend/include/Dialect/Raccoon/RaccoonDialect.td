//===----------------------------------------------------------------------===//
//
// This is the top level file for the Raccoon dialect.
//
//===----------------------------------------------------------------------===//

#ifndef RACCOON_RACCOONDIALECT_TD
#define RACCOON_RACCOONDIALECT_TD

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// Raccoon Dialect Definition.
//===----------------------------------------------------------------------===//


def Raccoon_Dialect : Dialect {
	let name = "Raccoon";
	let summary = "The Raccoon Dialect.";
	let description = [{
		The `Raccoon` dialect is for testing and demonstrating.
	}];
	let cppNamespace = "::rocketraccoon::raccoon";
}

//===----------------------------------------------------------------------===//
// Base Raccoon Operation Definition.
//===----------------------------------------------------------------------===//

class Raccoon_Op<string mnemonic, list<Trait> traits = []> :
    Op<Raccoon_Dialect, mnemonic, traits>;

#endif // RACCOON_BUDDIALECT_TD

