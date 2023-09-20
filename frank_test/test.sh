#!/bin/bash

WASM=/home/frank/projects/wasmfx/webassembly-spec/interpreter/wasm
WASMOPT="/home/frank/projects/wasmfx/binaryen/bin/wasm-opt --enable-gc --enable-typed-continuations --enable-reference-types --enable-exception-handling"

WASMDIS="/home/frank/projects/wasmfx/binaryen/bin/wasm-dis --enable-gc --enable-multivalue --enable-typed-continuations --enable-reference-types --enable-exception-handling"
WASMAS="/home/frank/projects/wasmfx/binaryen/bin/wasm-as --enable-gc --enable-multivalue --enable-typed-continuations --enable-reference-types --enable-exception-handling"

$WASM original.wat -o reference_interpreter.wasm
$WASM original.wat -o reference_interpreter.wat

$WASMAS  -o wasm-as.wasm original.wat
$WASMDIS -o wasm-dis.wat reference_interpreter.wasm

$WASMDIS -o roundtrip.wat wasm-as.wasm


#$WASMDIS reference_interpreter.wasm -o wasm-dis.wat

# $WASMOPT  -S -o wasmopt.wat original.wat
# $WASMOPT     -o wasmopt.wasm original.wat
