//===----------------------------------------------------------------------===//
//
// This is the top level file for operations in the Raccoon dialect.
//
//===----------------------------------------------------------------------===//

#ifndef RACCOON_RACCOONOPS_TD
#define RACCOON_RACCOONOPS_TD

include "RaccoonDialect.td"
include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/IR/EnumAttr.td"

//===----------------------------------------------------------------------===//
// Test constant operation.
//===----------------------------------------------------------------------===//

def Raccoon_TestConstantOp : Raccoon_Op<"test_constant", []> {
  let summary = "Test Constant Operation.";

  let results = (outs AnyInteger:$result);

  let assemblyFormat = [{
    attr-dict `:` type($result)
  }];
}

//===----------------------------------------------------------------------===//
// Test print operation.
//===----------------------------------------------------------------------===//

def Raccoon_TestPrintOp : Raccoon_Op<"test_print", []> {
  let summary = "Test Print Operation.";

  let results = (outs AnyInteger:$result);

  let assemblyFormat = [{
    attr-dict `:` type($result)
  }];
}

//===----------------------------------------------------------------------===//
// Test enum attribute in the operation.
//===----------------------------------------------------------------------===//

def Raccoon_TestEnumAttrOpAdd : I32EnumAttrCase<"ADD", 0, "add">;
def Raccoon_TestEnumAttrOpSub : I32EnumAttrCase<"SUB", 1, "sub">;

def Raccoon_TestEnumAttrOperation : I32EnumAttr<"TestEnumAttrOperation",
    "The arithmetic enum attribute.",
    [
      Raccoon_TestEnumAttrOpAdd,
      Raccoon_TestEnumAttrOpSub
    ]>{
  let genSpecializedAttr = 0;
  let cppNamespace = "::rocketraccoon::raccoon";
}

def Raccoon_TestEnumAttrOperationAttr : EnumAttr<Raccoon_Dialect, Raccoon_TestEnumAttrOperation, "test_enum_attr_op">;

def Raccoon_TestEnumAttrOp : Raccoon_Op<"test_enum_attr",
    [SameOperandsAndResultType]>,
    Arguments<(ins AnyInteger:$lhs, AnyInteger:$rhs,
               Raccoon_TestEnumAttrOperationAttr:$arith)>,
    Results<(outs AnyInteger:$result)> {
  let summary = "Test Enum Attribute.";

  let assemblyFormat = [{
    $arith $lhs `,` $rhs attr-dict `:` type($result)
  }];
}

//===----------------------------------------------------------------------===//
// Test array attribute in the operation.
//===----------------------------------------------------------------------===//

def CoordinateArrayAttr : ConfinedAttr<I64ArrayAttr, [ArrayCount<2>]>;

def Raccoon_TestArrayAttrOp : Raccoon_Op<"test_array_attr"> {
  let summary = "Test Array Attribute.";

  let arguments = (ins 
        Arg<AnyMemRef, "the reference to load from", [MemRead]>:$base,
        CoordinateArrayAttr:$coordinate);
  let results = (outs AnyType:$result);

  let assemblyFormat =
      "$base attr-dict `:` type($base) `,` type($result)";
}

//===----------------------------------------------------------------------===//
// Vector Config Operation Demo
//===----------------------------------------------------------------------===//

def Raccoon_VectorConfigOp : Raccoon_Op<"vector_config"> {
  let summary = "Vector Config Operation Demo.";
  let arguments = (ins AnyVector:$mask,
                       AnyInteger:$vl
                  );
  let results = (outs AnyType:$result);
  let regions = (region AnyRegion:$region);

  let assemblyFormat = "$mask `,` $vl attr-dict `:` type($mask) `,` type($vl) "
      "$region `:` type($result)";
}

#endif // RACCOON_RACCOONOPS_TD
