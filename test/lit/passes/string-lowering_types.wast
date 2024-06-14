;; NOTE: Assertions have been generated by update_lit_checks.py --all-items and should not be edited.

;; RUN: foreach %s %t wasm-opt --string-lowering  -all -S -o - | filecheck %s

;; A private type exists, and a public type is used by imports (one explicitly,
;; one implicitly). When we lower stringref into externref the import's types
;; should not be part of a rec group with the private type: public and private
;; types must remain separate.
(module
  (rec
    ;; CHECK:      (type $0 (func (param externref externref) (result i32)))

    ;; CHECK:      (type $1 (array (mut i16)))

    ;; CHECK:      (type $2 (func (param externref)))

    ;; CHECK:      (type $3 (func (param (ref extern))))

    ;; CHECK:      (type $4 (func))

    ;; CHECK:      (type $private (struct (field externref)))
    (type $private (struct (field stringref)))
  )
  (type $public (func (param stringref)))

  ;; CHECK:      (type $6 (func (param (ref null $1) i32 i32) (result (ref extern))))

  ;; CHECK:      (type $7 (func (param i32) (result (ref extern))))

  ;; CHECK:      (type $8 (func (param externref externref) (result (ref extern))))

  ;; CHECK:      (type $9 (func (param externref (ref null $1) i32) (result i32)))

  ;; CHECK:      (type $10 (func (param externref) (result i32)))

  ;; CHECK:      (type $11 (func (param externref i32) (result i32)))

  ;; CHECK:      (type $12 (func (param externref i32 i32) (result (ref extern))))

  ;; CHECK:      (import "a" "b" (func $import (type $2) (param externref)))
  (import "a" "b" (func $import (type $public) (param stringref)))

  ;; CHECK:      (import "a" "b" (func $import-implicit (type $3) (param (ref extern))))
  (import "a" "b" (func $import-implicit (param (ref string))))

  ;; CHECK:      (import "wasm:js-string" "fromCharCodeArray" (func $fromCharCodeArray (type $6) (param (ref null $1) i32 i32) (result (ref extern))))

  ;; CHECK:      (import "wasm:js-string" "fromCodePoint" (func $fromCodePoint (type $7) (param i32) (result (ref extern))))

  ;; CHECK:      (import "wasm:js-string" "concat" (func $concat (type $8) (param externref externref) (result (ref extern))))

  ;; CHECK:      (import "wasm:js-string" "intoCharCodeArray" (func $intoCharCodeArray (type $9) (param externref (ref null $1) i32) (result i32)))

  ;; CHECK:      (import "wasm:js-string" "equals" (func $equals (type $0) (param externref externref) (result i32)))

  ;; CHECK:      (import "wasm:js-string" "compare" (func $compare (type $0) (param externref externref) (result i32)))

  ;; CHECK:      (import "wasm:js-string" "length" (func $length (type $10) (param externref) (result i32)))

  ;; CHECK:      (import "wasm:js-string" "charCodeAt" (func $charCodeAt (type $11) (param externref i32) (result i32)))

  ;; CHECK:      (import "wasm:js-string" "substring" (func $substring (type $12) (param externref i32 i32) (result (ref extern))))

  ;; CHECK:      (export "export" (func $export))

  ;; CHECK:      (func $export (type $4)
  ;; CHECK-NEXT:  (local $0 (ref $private))
  ;; CHECK-NEXT:  (nop)
  ;; CHECK-NEXT: )
  (func $export (export "export")
    ;; Keep the private type alive.
    (local (ref $private))
  )
)