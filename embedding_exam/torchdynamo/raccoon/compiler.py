'''
Should have MLIR-Python binding
- `Graph` is the main data structure used in the FX Intermediate Representation.
- It consists of a series of Node s, each representing callsites (or other
syntactic constructs). 
- `torch.nn.Module` can be traced by `torch.fx.symbolic_trace()` and then print
  out by torch.fx.symbolic_trace(MyModule()).graph

@DynamoCompiler: Takes a PyTorch GraphModule and its inputs, and calls the
Importer function to generate the MLIR module.

@Importer: Takes the GraphModule and inputs, and generates the MLIR module with
the corresponding operations.

@CodeGen: Generates the MLIR code for each node in the GraphModule based on the
node's operation type (e.g., add, matmul, etc.)
'''

from mlir.ir import *
from mlir.dialects import arith, linalg
import mlir.dialects.func as func
from mlir.passmanager import *
import torch
from typing import List

# FX is for developers to use to transform `nn.Module` instances
# FX has 3 components: symbolic tracer, intermediate representation, and Python code generation
def DynamoCompiler(gm: torch.fx.GraphModule, inputs: List[torch.Tensor]):
    print("Custom Compiler from FX Graph to MLIR:")
    print("-------------------------------------------------------------------")
    # print out a table showing the nodes of this Graph
    gm.graph.print_tabular()

    # Initialize the MLIR context
    ctx = Context()
    with Location.unknown(ctx):
        module = Importer(gm, inputs)
        module = Lowering(module)
    return gm.forward

def Importer(gm: torch.fx.GraphModule, inputs: List[torch.Tensor]):
    # Initialize the symbol table
    symbolTable = {}
    # Create a module and build the operations into the Module
    module = Module.create()
    with InsertionPoint(module.body):
        # Parse the arguments
        arguments = []
        for arg in inputs:
            shapeList = list(arg.shape)
            f32 = F32Type.get()
            tensorArg = RankedTensorType.get(shapeList, f32)
            arguments.append(tensorArg)
        # Generate the function
        @func.FuncOp.from_py_func(*arguments)
        def generated_func(*args):
            # Convert arguments tuple into a list
            argsList = list(args)
            # Traverse the graph and generate IR
            for node in gm.graph.nodes:
                CodeGen(node, symbolTable, argsList)
            return symbolTable.get("output")
        print("-------------------------------------------------------------------")
        print("Printing the symbol table ...")
        for symbol, op in symbolTable.items():
            print(symbol, ": ", op)
        print("-------------------------------------------------------------------")
        print("Printing the generated MLIR ...")
        print(module)
        return(module)

def CodeGen(node, symbolTable, argsList):
    if node.op == "placeholder" :
        # Bind the placeholder with args
        symbolTable[str(node.name)] = argsList[0]
        argsList.pop(0)
    if node.op == "call_function" :
        # Parse a call_function
        if node.target.__name__ == "add":
            # Generate add operation
            # Get two input values
            input1 = symbolTable.get(str(node._args[0]))
            input2 = symbolTable.get(str(node._args[1]))
            op = arith.AddFOp(input1, input2)
            symbolTable[str(node.name)] = op

        if node.target.__name__ == "matmul":
            # For 2D matmul
            # Get two input values
            input1 = symbolTable.get(str(node._args[0]))
            input2 = symbolTable.get(str(node._args[1]))
            # Infer the output sizes
            size1 = RankedTensorType(input1.type).shape[0]
            size2 = RankedTensorType(input2.type).shape[1]
            sizes = [size1, size2]

            # Generate an output tensor for matmul operation
            f32 = F32Type.get()
            element = FloatAttr.get(f32, 0.0)
            tensor_type = RankedTensorType.get(sizes, f32)
            attr = DenseElementsAttr.get_splat(tensor_type, element)
            init_result = arith.ConstantOp(tensor_type, attr)
            # Generate matmul operation
            op = linalg.matmul(input1, input2, outs=[init_result.result])
            symbolTable[str(node.name)] = op

    if node.op == "output":
        # Generating return operation
        ret = symbolTable.get(str(node._args[0][0]))
        symbolTable["output"] = ret

def Lowering(module):
    print("-------------------------------------------------------------------")
    print("Bufferizing the module ...")
    pm = PassManager('builtin.module')
    pm.add("convert-elementwise-to-linalg")
    pm.add("arith-bufferize")
    pm.add("func.func(linalg-bufferize)")
    pm.add("func.func(tensor-bufferize)")
    pm.add("func-bufferize")
    pm.run(module)
    print(module)
    print("-------------------------------------------------------------------")
    print("Lowering the module to LLVM dialect ...")
    pm.add("func.func(buffer-deallocation)")
    pm.add("func.func(convert-linalg-to-loops)")
    pm.add("convert-scf-to-cf")
    pm.add("convert-linalg-to-llvm")
    pm.add("convert-memref-to-llvm")
    pm.add("convert-func-to-llvm")
    pm.add("reconcile-unrealized-casts")
    pm.run(module)
    print(module)
    return module
