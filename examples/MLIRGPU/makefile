#!/bin/bash
MLIR_OPT := /home/shenghao/llvm-project/build/bin/mlir-opt
MLIR_TRANSLATE := /home/shenghao/llvm-project/build/bin/mlir-translate
MLIR_CPU_RUNNER := /home/shenghao/llvm-project/build/bin/mlir-cpu-runner
LLC := /home/shenghao/llvm-project/build/bin/llc
OPT_FLAG := -O0

gpu-mma-lower:
	@${MLIR_OPT} gpu-mma.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin{chip=sm_70}))' | \
	${MLIR_OPT}	-convert-scf-to-cf -gpu-to-llvm -o log.mlir
		
gpu-mma-run:
	@${MLIR_OPT} gpu-mma.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} -pass-pipeline='builtin.module(gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin{chip=sm_70}))' | \
	${MLIR_OPT}	-convert-scf-to-cf -gpu-to-llvm | \
	${MLIR_CPU_RUNNER} -entry-point-result=void -shared-libs=${MLIR_CUDA_RUNTIME} -shared-libs=${MLIR_RUNNER_UTILS}

vector-to-gpu-lower:
	@${MLIR_OPT} vector-to-gpu.mlir -gpu-kernel-outlining | \
	${MLIR_OPT} -pass-pipeline="builtin.module(func.func(convert-vector-to-gpu,canonicalize))" -o log.mlir 
