import ast
import dis
import sys

print("=== Source code below === ")

src_code = """
# normal python operation
x = 1
x = x * 2

# tensor operation
y = dl_framework.ones((1, 2))
z = x + y
print(z)

# print python frame
f = sys._getframe()
# print the code object
print(f.f_code)
"""

print(src_code)

print("=== Source code to ast === ")
# Source code to  AST
ast_obj = ast.parse(src_code)
# Print AST
print(ast.dump(ast_obj))

"""
Module(body=[
  # x = 1
  Assign(targets=[Name(id='x', ctx=Store())],
         value=Constant(value=1, kind=None),
         type_comment=None),

  # x = x * 2
  Assign(targets=[Name(id='x', ctx=Store())],
         value=BinOp(left=Name(id='x', ctx=Load()), op=Mult(), right=Constant(value=2, kind=None)), type_comment=None),
  
  # y = dl_framework.ones((1, 2))
  Assign(targets=[Name(id='y', ctx=Store())],
         # dl_framework.ones((1, 2))
         value=Call(func=Attribute(value=Name(id='dl_framework', ctx=Load()),
                    attr='ones', ctx=Load()),
                    args=[Tuple(elts=[Constant(value=1, kind=None),
                    Constant(value=2, kind=None)], ctx=Load())], keywords=[]), type_comment=None),
  
  # z = x + y
  Assign(targets=[Name(id='z', ctx=Store())],
         # x + y
         value=BinOp(left=Name(id='x', ctx=Load()),
                    op=Add(),
                    right=Name(id='y', ctx=Load())), type_comment=None),

  # print(z)
  Expr(value=Call(func=Name(id='print', ctx=Load()), args=[Name(id='z', ctx=Load())], keywords=[])),

],
type_ignores=[]
)
"""

print("=== AST to Bytecode ===")

# compile to ByteCode
code_obj = compile(ast_obj, filename="", mode="exec")
print(code_obj)

# Show ByteCode
byte_obj = dis.Bytecode(code_obj)
print(byte_obj.dis())

print("=== Execute Bytecode ===")
# ByteCode to python VM for Execution
# print instruction
for instr in byte_obj:
    print(instr.opname, instr.opcode)

# DL framework here
import torch as dl_framework
exec(code_obj)

