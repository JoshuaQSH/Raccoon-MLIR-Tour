# Updates 
Last edited: [28/09/2023] by [S.Qiu]

- Might need a patch for `--convert-memref-to-llvm`, currently there is no pass for `-convert-memref-to-llvm`, instead, consider using `--convert-memref-to-spirv` - [WiP]

# Examples
Show how to use the passes and the interfaces in this tour. The following examples are provided:

- IR level conversion and transformation examples.
- Domain-specific application level examples.
- Testing and demonstrating examples.

# How to play around with IR-level examples
- `./MLIRTensor`: `make tensor-<option>-<exec>`
	- `make tensor-print-lower`
	- `make tensor-print-translate`
	- `make tensor-print-run`
	- `make tensor-collapse-shape-lower`
	- `make tensor-collapse-shape-translate`
	- `make tensor-collapse-shape-run`
	- `make tensor-extract-lower`
	- `make tensor-extract-translate`
	- `make tensor-extract-run`
	- `make tensor-extract-slice-lower`
	- ...
- `./MLIRAffine`
- `./MLIRLinalg`
- `./MLIRSCF`

# Domain Specific Application - Embedding TT-compression




