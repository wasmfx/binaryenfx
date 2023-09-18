#!/bin/bash

WASM=/home/frank/projects/wasmfx/spec/interpreter/wasm
WASMOPT=/home/frank/projects/wasmfx/binaryen/bin/wasm-opt

$WASM original.wat -o reference_interpreter.wasm
$WASM original.wat -o reference_interpreter.wat

$WASMOPT --enable-typed-continuations -S -o wasmopt.wat original.wat
$WASMOPT --enable-typed-continuations -o wasmopt.wasm original.wat
