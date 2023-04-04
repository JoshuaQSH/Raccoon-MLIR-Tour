# A Raccon Dialect process
- Refers to [MLIR - Define Dialects](https://mlir.llvm.org/docs/DefiningDialects/)

## A Midend for a MLIR Dialect (Raccoon), refers to Buddy-MLIR
- `include`
	- `Dialect`: All the dialects defination are put into here.
		- `Raccoon`
			- RaccoonDialect.h: defination
			- RaccoonDialect.td: TableGen for Raccoon Dialect
			- RaccoonOps.h:
			- RaccoonOps.td:
			- CMakeLists.txt
	- CMakeLists.txt
- `lib`: The implementation of each optimization and lowerpass
	- `Conversion`
		- `LowerRaccoon`
			- LowerRaccoonPass.cpp
			- CMakeLists.txt
		- `EmbOptimization`
			- EmbOptimize.cpp [WiP]
			- CMakeLists.txt
		- CMakeLists.txt
	- `Dialect`
		- `Raccoon`
			- RaccoonDialect.cpp
			- RaccoonOps.cpp
			- CMakeLists.txt
		- CMakeLists.txt
	- `Target`: Raccoon -> LLVMIR
		- `LLVMIR`
			- ConvertRaccoonToLLVMIR.cpp
			- CMakeLists.txt
		- CMakeLists.txt
	- CMakeLists.txt

		
