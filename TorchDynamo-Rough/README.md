# TorchDynamo
[TorchDynamo](https://pytorch.org/docs/stable/dynamo/index.html) is a Python-level JIT compiler designed to make unmodified PyTorch programs faster. TorchDynamo hooks into the frame evaluation API in CPython ([PEP 523](https://peps.python.org/pep-0523/)) to dynamically modify Python bytecode right before it is executed. 

- Rewrites the python bytecode
- Torch OP -> FX Graph (through bytecode analysis)
	- JIT compiled into a customizable backend

~
~ TorchInductor is one of the backends supported by [TorchDynamo Graph](https://pytorch.org/docs/stable/fx.html) (FX Graph) into Triton for GPUs or [C++/OpenMP](https://www.openmp.org/) for CPUs. 
~

- TorchDynamo supports many different backends but inductor specifically works by generating [Triton](https://github.com/openai/triton) kernels.


# FX Graph
```python
import torch
# Simple module for demonstration
class MyModule(torch.nn.Module):
	def __init__(self):
			super().__init__()
			self.param = torch.nn.Parameter(torch.rand(3, 4))
			self.linear = torch.nn.Linear(4, 5)

	def forward(self, x):
		return self.linear(x + self.param).clamp(min=0.0, max=1.0)

module = MyModule()

from torch.fx import symbolic_trace
# Symbolic tracing frontend - captures the semantics of the module
symbolic_traced : torch.fx.GraphModule = symbolic_trace(module)

# High-level intermediate representation (IR) - Graph representation
print(symbolic_traced.graph)

# Code generation - valid Python code
print(symbolic_traced.code)
```

FX is a toolkit for developers to use to transform `nn.Module` instances. FX consists of three main components: a symbolic tracer, an intermediate representation, and Python code generation.
Pipeline: symbolic tracing -> intermediate representation -> transforms -> Python code generation
- Symbolic tracer
- IR: container recorded during symbolic tracing. Consists of a list of Nodes that represents function inputs, callsites and return values. `torch.fx.Graph`
- CodeGen: transformation toolkit. 
	- Graph IR -> Python Code
	- `torch.fx.GraphModule`: a `torch.nn.Module` instance that holds torch.fx.Graphand `forward` method generated from Graph


