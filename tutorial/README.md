# Insights

Real-time optimization

# Basic Dialects

- `func`
- `arith`
- `affine`
- `scf`
- `llvm`

# Basic IR
**
- Operation: A single action/op/operation, which the Region can be nested inside the **Operation**
- Block: Contains one or more **Operation**
	- Attribute, take over the phi function of llvm
- Region: Similar to a for-loop or function body, it contains one or more **Block**

```mlir
module {
	func.func @foo(%a: i32, %b: i32, %c: i32) -> i32 {
		%cmp = arith.cmpi "sge", %a, %b : i32
		cf.cond_br %cmp, ^add(%a: i32), ^add(%b: i32)
	^add(%1: i32):
		%ret = llvm.add %1, %c : i32
		cf.br ^ret
	^ret:
		func.return %ret : i32
	}
}
```

Outer: `builtin.module`, which is the root of MLIR IR

# Tutorial

We recommand writting a CMakeLists.txt and use the following command to run each cpp file.
```shell
cd build
# Should be: ~/llvm-project/build
cmake .. -GNinja -DCMAKE_INSTAL_PREFIX=/path/to/mlir-build

# Each of the tutarial case can be run by enter each of the dir and do:
mkdir build && cd build
cmake ..
make
```


