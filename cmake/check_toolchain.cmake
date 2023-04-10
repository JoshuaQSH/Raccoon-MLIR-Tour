macro(CHECK_TOOLCHAIN)
#-------------------------------------------------------------------------------
# Check Triple
#-------------------------------------------------------------------------------
  set(RACCOON_TARGET_TRIPLE "${LLVM_HOST_TRIPLE}" CACHE STRING "Target triple of the host machine")
  message(STATUS "Target Triple: ${RACCOON_TARGET_TRIPLE}")

#-------------------------------------------------------------------------------
# Check Attribute
#-------------------------------------------------------------------------------
  set(RACCOON_OPT_ATTR "" CACHE STRING "Target attribute of the host machine")  
  if ("${RACCOON_OPT_ATTR}" STREQUAL "")
    if (HAVE_AVX512)
      # TODO: Figure out the difference of sse/sse2/sse4.1
      set(RACCOON_OPT_ATTR avx512f)
    elseif(HAVE_AVX2)
      set(RACCPPM_OPT_ATTR avx2)
    elseif(HAVE_SSE)
      set(RACCOON_OPT_ATTR sse)
    elseif(HAVE_NEON)
      set(RACCOON_OPT_ATTR neon)
    endif()
  endif(message(STATUS "Target Attr: ${RACCOON_OPT_ATTR}")
 message(STATUS "Target Attr: ${RACCOON_OPT_ATTR}")
endmacro(CHECK_TOOLCHAIN)
