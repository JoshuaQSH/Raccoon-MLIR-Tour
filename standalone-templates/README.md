# Standalone Test for beginner

*## Test Suite*
`simplepass`: Reading file, [RUN PASS]
`standalone-opt`: conversion, [RUN PASS]

# Extension Tree for Standalone

build_and_run.sh
├── cmake
│   └── modules
│       └── sanitizers.cmake
├── CMakeLists.txt
├── include
│   ├── CMakeLists.txt
│   └── Standalone
│       ├── CMakeLists.txt
│       ├── StandaloneDialect.h
│       ├── StandaloneDialect.td
│       ├── StandaloneOps.h
│       └── StandaloneOps.td
├── lib
│   ├── CMakeLists.txt
│   └── Standalone
│       ├── CMakeLists.txt
│       ├── StandaloneDialect.cpp
│       └── StandaloneOps.cpp
├── LICENSE.txt
├── README.md
├── standalone-opt
│   ├── CMakeLists.txt
│   └── standalone-opt.cpp
└── test
    ├── CMakeLists.txt
	    ├── lit.cfg.py
		    ├── lit.site.cfg.py.in
			    └── Standalone
				        └── dummy.mlir

