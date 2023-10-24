#!/bin/bash

# OPT location
OPT := /home/shenghao/llvm-project/build/bin/mlir-opt

test-print-lower:
	@${OPT} ./TestPrint.mlir \
		--lower-rac -o ./log.mlir 

