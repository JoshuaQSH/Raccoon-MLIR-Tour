get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)

# Add custom MLIRSimplePassTransform
set(LIBS
        ${dialect_libs}
        ${conversion_libs}
        MLIRArithDialect
        MLIROptLib
        MLIRSimplePassTransform
        )

# simplepass opt
add_llvm_executable(simplepass-opt simplepass-opt.cpp)

llvm_update_compile_flags(simplepass-opt)
target_link_libraries(simplepass-opt PRIVATE ${LIBS})

mlir_check_all_link_libraries(simplepass-opt)
