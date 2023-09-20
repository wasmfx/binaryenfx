cd /home/frank/projects/wasmfx/binaryen
file bin/wasm-opt
#set args --enable-typed-continuations  --print frank_test/original.wat
set args --new-wat-parser -all test/lit/wat-kitchen-sink.wast


# file bin/wasm-dis
# set args --enable-typed-continuations  frank_test/reference_interpreter.wasm
#

# file bin/wasm-as
# set args --debug -all  frank_test/original.wat
