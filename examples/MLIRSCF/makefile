#!/bin/bash
MLIR_OPT := /home/shenghao/llvm-project/build/bin/mlir-opt
MLIR_TRANSLATE := /home/shenghao/llvm-project/build/bin/mlir-translate
MLIR_CPU_RUNNER := /home/shenghao/llvm-project/build/bin/mlir-cpu-runner
LLC := /home/shenghao/llvm-project/build/bin/llc
OPT_FLAG := -O0

ifeq ($(shell uname),Linux)
MLIR_RUNNER_UTILS := /home/shenghao/llvm-project/build/lib/libmlir_runner_utils.so
MLIR_C_RUNNER_UTILS := /home/shenghao/llvm-project/build/lib/libmlir_c_runner_utils.so
MLIR_ASYNC_RUNTIME := /home/shenghao/llvm-project/build/lib/libmlir_async_runtime.so
MTRIPLE := x86_64-unknown-linux-gnu
else ifeq ($(shell uname),Darwin)
MLIR_RUNNER_UTILS := /home/shenghao/llvm-project/build/lib/libmlir_runner_utils.dylib
MLIR_C_RUNNER_UTILS := /home/shenghao/llvm-project/build/lib/libmlir_c_runner_utils.dylib
MLIR_ASYNC_RUNTIME :=/home/shenghao/llvm-project/build/lib/libmlir_async_runtime.dylib
MTRIPLE := x86_64-apple-darwin
endif

scf-while-lower:
	@${MLIR_OPT} ./scf-while.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts -o ./log.mlir

scf-while-translate:
	@${MLIR_OPT} ./scf-while.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts | \
	${MLIR_TRANSLATE} --mlir-to-llvmir -o log.ll

scf-while-run:
	@${MLIR_OPT} ./scf-while.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts | \
	${MLIR_CPU_RUNNER} ${OPT_FLAG} -e main -entry-point-result=void \
		-shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_C_RUNNER_UTILS}

scf-parallel-lower:
	@${MLIR_OPT} ./scf-parallel.mlir \
	    -async-parallel-for \
		-o ./log.mlir

scf-parallel-run:
	@${MLIR_OPT} ./scf-parallel.mlir \
	    -async-parallel-for \
        -async-to-async-runtime \
		-async-runtime-ref-counting \
        -async-runtime-ref-counting-opt \
		-arith-expand \
        -convert-async-to-llvm \
        -convert-scf-to-cf \
        -convert-cf-to-llvm \
		-finalize-memref-to-llvm \
        -convert-func-to-llvm \
        -reconcile-unrealized-casts |\
    ${MLIR_CPU_RUNNER} ${OPT_FLAG} -e main -entry-point-result=void \
	    -shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_ASYNC_RUNTIME}

scf-for-lower:
	@${MLIR_OPT} ./scf-for.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts -o ./log.mlir

scf-for-translate:
	@${MLIR_OPT} ./scf-for.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts | \
	${MLIR_TRANSLATE} --mlir-to-llvmir -o log.ll

scf-for-run:
	@${MLIR_OPT} ./scf-for.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts | \
	${MLIR_CPU_RUNNER} ${OPT_FLAG} -e main -entry-point-result=void \
		-shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_C_RUNNER_UTILS}

scf-if-lower:
	@${MLIR_OPT} ./scf-if.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts -o ./log.mlir

scf-if-translate:
	@${MLIR_OPT} ./scf-if.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts | \
	${MLIR_TRANSLATE} --mlir-to-llvmir -o log.ll

scf-if-run:
	@${MLIR_OPT} ./scf-if.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts | \
	${MLIR_CPU_RUNNER} ${OPT_FLAG} -e main -entry-point-result=void \
		-shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_C_RUNNER_UTILS}	

scf-do-while-lower:
	@${MLIR_OPT} ./scf-do-while.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts -o ./log.mlir

scf-do-while-translate:
	@${MLIR_OPT} ./scf-do-while.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts | \
	${MLIR_TRANSLATE} --mlir-to-llvmir -o log.ll

scf-do-while-run:
	@${MLIR_OPT} ./scf-do-while.mlir \
		--convert-scf-to-cf --convert-vector-to-llvm --convert-func-to-llvm \
		--reconcile-unrealized-casts | \
	${MLIR_CPU_RUNNER} ${OPT_FLAG} -e main -entry-point-result=void \
		-shared-libs=${MLIR_RUNNER_UTILS} -shared-libs=${MLIR_C_RUNNER_UTILS}
