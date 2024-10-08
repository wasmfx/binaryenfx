;; NOTE: Assertions have been generated by update_lit_checks.py --all-items and should not be edited.

;; RUN: wasm-opt %s -all -o %t.text.wast -g -S
;; RUN: wasm-as %s -all -g -o %t.wasm
;; RUN: wasm-dis %t.wasm -all -o %t.bin.wast
;; RUN: wasm-as %s -all -o %t.nodebug.wasm
;; RUN: wasm-dis %t.nodebug.wasm -all -o %t.bin.nodebug.wast
;; RUN: cat %t.text.wast | filecheck %s --check-prefix=CHECK-TEXT
;; RUN: cat %t.bin.wast | filecheck %s --check-prefix=CHECK-BIN
;; RUN: cat %t.bin.nodebug.wast | filecheck %s --check-prefix=CHECK-BIN-NODEBUG

(module
 (memory 1 1)


 ;; CHECK-TEXT:      (type $0 (func (param v128 v128) (result v128)))

 ;; CHECK-TEXT:      (type $1 (func (param v128) (result v128)))

 ;; CHECK-TEXT:      (type $2 (func (param v128 v128 v128) (result v128)))

 ;; CHECK-TEXT:      (type $3 (func (param i32) (result f32)))

 ;; CHECK-TEXT:      (type $4 (func (param i32 f32)))

 ;; CHECK-TEXT:      (type $5 (func (param f32) (result v128)))

 ;; CHECK-TEXT:      (type $6 (func (param v128) (result f32)))

 ;; CHECK-TEXT:      (type $7 (func (param v128 f32) (result v128)))

 ;; CHECK-TEXT:      (memory $0 1 1)

 ;; CHECK-TEXT:      (func $f32.load_f16 (type $3) (param $0 i32) (result f32)
 ;; CHECK-TEXT-NEXT:  (f32.load_f16
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (type $0 (func (param v128 v128) (result v128)))

 ;; CHECK-BIN:      (type $1 (func (param v128) (result v128)))

 ;; CHECK-BIN:      (type $2 (func (param v128 v128 v128) (result v128)))

 ;; CHECK-BIN:      (type $3 (func (param i32) (result f32)))

 ;; CHECK-BIN:      (type $4 (func (param i32 f32)))

 ;; CHECK-BIN:      (type $5 (func (param f32) (result v128)))

 ;; CHECK-BIN:      (type $6 (func (param v128) (result f32)))

 ;; CHECK-BIN:      (type $7 (func (param v128 f32) (result v128)))

 ;; CHECK-BIN:      (memory $0 1 1)

 ;; CHECK-BIN:      (func $f32.load_f16 (type $3) (param $0 i32) (result f32)
 ;; CHECK-BIN-NEXT:  (f32.load_f16
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f32.load_f16 (param $0 i32) (result f32)
  (f32.load_f16
   (local.get $0)
  )
 )
 ;; CHECK-TEXT:      (func $f32.store_f16 (type $4) (param $0 i32) (param $1 f32)
 ;; CHECK-TEXT-NEXT:  (f32.store_f16
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:   (local.get $1)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $f32.store_f16 (type $4) (param $0 i32) (param $1 f32)
 ;; CHECK-BIN-NEXT:  (f32.store_f16
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:   (local.get $1)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f32.store_f16 (param $0 i32) (param $1 f32)
  (f32.store_f16
   (local.get $0)
   (local.get $1)
  )
 )

 ;; CHECK-TEXT:      (func $f16x8.splat (type $5) (param $0 f32) (result v128)
 ;; CHECK-TEXT-NEXT:  (f16x8.splat
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $f16x8.splat (type $5) (param $0 f32) (result v128)
 ;; CHECK-BIN-NEXT:  (f16x8.splat
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f16x8.splat (param $0 f32) (result v128)
  (f16x8.splat
   (local.get $0)
  )
 )

  ;; CHECK-TEXT:      (func $f16x8.extract_lane (type $6) (param $0 v128) (result f32)
  ;; CHECK-TEXT-NEXT:  (f16x8.extract_lane 0
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.extract_lane (type $6) (param $0 v128) (result f32)
  ;; CHECK-BIN-NEXT:  (f16x8.extract_lane 0
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.extract_lane (param $0 v128) (result f32)
  (f16x8.extract_lane 0
   (local.get $0)
  )
 )

  ;; CHECK-TEXT:      (func $f16x8.replace_lane (type $7) (param $0 v128) (param $1 f32) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.replace_lane 0
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.replace_lane (type $7) (param $0 v128) (param $1 f32) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.replace_lane 0
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.replace_lane (param $0 v128) (param $1 f32) (result v128)
  (f16x8.replace_lane 0
   (local.get $0)
   (local.get $1)
  )
 )
 ;; CHECK-TEXT:      (func $f16x8.eq (type $0) (param $0 v128) (param $1 v128) (result v128)
 ;; CHECK-TEXT-NEXT:  (f16x8.eq
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:   (local.get $1)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $f16x8.eq (type $0) (param $0 v128) (param $1 v128) (result v128)
 ;; CHECK-BIN-NEXT:  (f16x8.eq
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:   (local.get $1)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f16x8.eq (param $0 v128) (param $1 v128) (result v128)
  (f16x8.eq
   (local.get $0)
   (local.get $1)
  )
 )
 ;; CHECK-TEXT:      (func $f16x8.ne (type $0) (param $0 v128) (param $1 v128) (result v128)
 ;; CHECK-TEXT-NEXT:  (f16x8.ne
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:   (local.get $1)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $f16x8.ne (type $0) (param $0 v128) (param $1 v128) (result v128)
 ;; CHECK-BIN-NEXT:  (f16x8.ne
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:   (local.get $1)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f16x8.ne (param $0 v128) (param $1 v128) (result v128)
  (f16x8.ne
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.lt (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.lt
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.lt (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.lt
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.lt (param $0 v128) (param $1 v128) (result v128)
  (f16x8.lt
   (local.get $0)
   (local.get $1)
  )
  )
   ;; CHECK-TEXT:      (func $f16x8.gt (type $0) (param $0 v128) (param $1 v128) (result v128)
   ;; CHECK-TEXT-NEXT:  (f16x8.gt
   ;; CHECK-TEXT-NEXT:   (local.get $0)
   ;; CHECK-TEXT-NEXT:   (local.get $1)
   ;; CHECK-TEXT-NEXT:  )
   ;; CHECK-TEXT-NEXT: )
   ;; CHECK-BIN:      (func $f16x8.gt (type $0) (param $0 v128) (param $1 v128) (result v128)
   ;; CHECK-BIN-NEXT:  (f16x8.gt
   ;; CHECK-BIN-NEXT:   (local.get $0)
   ;; CHECK-BIN-NEXT:   (local.get $1)
   ;; CHECK-BIN-NEXT:  )
   ;; CHECK-BIN-NEXT: )
   (func $f16x8.gt (param $0 v128) (param $1 v128) (result v128)
  (f16x8.gt
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.le (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.le
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.le (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.le
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.le (param $0 v128) (param $1 v128) (result v128)
  (f16x8.le
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.ge (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.ge
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.ge (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.ge
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.ge (param $0 v128) (param $1 v128) (result v128)
  (f16x8.ge
   (local.get $0)
   (local.get $1)
  )
 )
 ;; CHECK-TEXT:      (func $f16x8.add (type $0) (param $0 v128) (param $1 v128) (result v128)
 ;; CHECK-TEXT-NEXT:  (f16x8.add
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:   (local.get $1)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $f16x8.add (type $0) (param $0 v128) (param $1 v128) (result v128)
 ;; CHECK-BIN-NEXT:  (f16x8.add
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:   (local.get $1)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f16x8.add (param $0 v128) (param $1 v128) (result v128)
  (f16x8.add
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.sub (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.sub
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.sub (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.sub
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.sub (param $0 v128) (param $1 v128) (result v128)
  (f16x8.sub
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.mul (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.mul
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.mul (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.mul
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.mul (param $0 v128) (param $1 v128) (result v128)
  (f16x8.mul
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.div (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.div
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.div (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.div
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.div (param $0 v128) (param $1 v128) (result v128)
  (f16x8.div
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.min (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.min
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.min (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.min
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.min (param $0 v128) (param $1 v128) (result v128)
  (f16x8.min
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.max (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.max
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.max (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.max
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.max (param $0 v128) (param $1 v128) (result v128)
  (f16x8.max
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.pmin (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.pmin
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.pmin (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.pmin
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.pmin (param $0 v128) (param $1 v128) (result v128)
  (f16x8.pmin
   (local.get $0)
   (local.get $1)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.pmax (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.pmax
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.pmax (type $0) (param $0 v128) (param $1 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.pmax
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.pmax (param $0 v128) (param $1 v128) (result v128)
  (f16x8.pmax
   (local.get $0)
   (local.get $1)
  )
 )
 ;; CHECK-TEXT:      (func $f16x8.abs (type $1) (param $0 v128) (result v128)
 ;; CHECK-TEXT-NEXT:  (f16x8.abs
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $f16x8.abs (type $1) (param $0 v128) (result v128)
 ;; CHECK-BIN-NEXT:  (f16x8.abs
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f16x8.abs (param $0 v128) (result v128)
  (f16x8.abs
   (local.get $0)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.neg (type $1) (param $0 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.neg
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.neg (type $1) (param $0 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.neg
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.neg (param $0 v128) (result v128)
  (f16x8.neg
   (local.get $0)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.sqrt (type $1) (param $0 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.sqrt
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.sqrt (type $1) (param $0 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.sqrt
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.sqrt (param $0 v128) (result v128)
  (f16x8.sqrt
   (local.get $0)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.ceil (type $1) (param $0 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.ceil
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.ceil (type $1) (param $0 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.ceil
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.ceil (param $0 v128) (result v128)
  (f16x8.ceil
   (local.get $0)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.floor (type $1) (param $0 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.floor
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.floor (type $1) (param $0 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.floor
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.floor (param $0 v128) (result v128)
  (f16x8.floor
   (local.get $0)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.trunc (type $1) (param $0 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.trunc
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.trunc (type $1) (param $0 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.trunc
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.trunc (param $0 v128) (result v128)
  (f16x8.trunc
   (local.get $0)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.nearest (type $1) (param $0 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.nearest
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.nearest (type $1) (param $0 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.nearest
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.nearest (param $0 v128) (result v128)
  (f16x8.nearest
   (local.get $0)
  )
 )
  ;; CHECK-TEXT:      (func $f16x8.relaxed_madd (type $2) (param $0 v128) (param $1 v128) (param $2 v128) (result v128)
  ;; CHECK-TEXT-NEXT:  (f16x8.relaxed_madd
  ;; CHECK-TEXT-NEXT:   (local.get $0)
  ;; CHECK-TEXT-NEXT:   (local.get $1)
  ;; CHECK-TEXT-NEXT:   (local.get $2)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  ;; CHECK-BIN:      (func $f16x8.relaxed_madd (type $2) (param $0 v128) (param $1 v128) (param $2 v128) (result v128)
  ;; CHECK-BIN-NEXT:  (f16x8.relaxed_madd
  ;; CHECK-BIN-NEXT:   (local.get $0)
  ;; CHECK-BIN-NEXT:   (local.get $1)
  ;; CHECK-BIN-NEXT:   (local.get $2)
  ;; CHECK-BIN-NEXT:  )
  ;; CHECK-BIN-NEXT: )
  (func $f16x8.relaxed_madd (param $0 v128) (param $1 v128) (param $2 v128) (result v128)
  (f16x8.relaxed_madd
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )


 ;; CHECK-TEXT:      (func $f16x8.relaxed_nmadd (type $2) (param $0 v128) (param $1 v128) (param $2 v128) (result v128)
 ;; CHECK-TEXT-NEXT:  (f16x8.relaxed_nmadd
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:   (local.get $1)
 ;; CHECK-TEXT-NEXT:   (local.get $2)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $f16x8.relaxed_nmadd (type $2) (param $0 v128) (param $1 v128) (param $2 v128) (result v128)
 ;; CHECK-BIN-NEXT:  (f16x8.relaxed_nmadd
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:   (local.get $1)
 ;; CHECK-BIN-NEXT:   (local.get $2)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f16x8.relaxed_nmadd (param $0 v128) (param $1 v128) (param $2 v128) (result v128)
  (f16x8.relaxed_nmadd
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )
 ;; CHECK-TEXT:      (func $i16x8.trunc_sat_f16x8_s (type $1) (param $0 v128) (result v128)
 ;; CHECK-TEXT-NEXT:  (i16x8.trunc_sat_f16x8_s
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $i16x8.trunc_sat_f16x8_s (type $1) (param $0 v128) (result v128)
 ;; CHECK-BIN-NEXT:  (i16x8.trunc_sat_f16x8_s
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $i16x8.trunc_sat_f16x8_s (param $0 v128) (result v128)
  (i16x8.trunc_sat_f16x8_s
   (local.get $0)
  )
 )

 ;; CHECK-TEXT:      (func $i16x8.trunc_sat_f16x8_u (type $1) (param $0 v128) (result v128)
 ;; CHECK-TEXT-NEXT:  (i16x8.trunc_sat_f16x8_u
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $i16x8.trunc_sat_f16x8_u (type $1) (param $0 v128) (result v128)
 ;; CHECK-BIN-NEXT:  (i16x8.trunc_sat_f16x8_u
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $i16x8.trunc_sat_f16x8_u (param $0 v128) (result v128)
  (i16x8.trunc_sat_f16x8_u
   (local.get $0)
  )
 )

 ;; CHECK-TEXT:      (func $f16x8.convert_i16x8_s (type $1) (param $0 v128) (result v128)
 ;; CHECK-TEXT-NEXT:  (f16x8.convert_i16x8_s
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $f16x8.convert_i16x8_s (type $1) (param $0 v128) (result v128)
 ;; CHECK-BIN-NEXT:  (f16x8.convert_i16x8_s
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f16x8.convert_i16x8_s (param $0 v128) (result v128)
  (f16x8.convert_i16x8_s
   (local.get $0)
  )
 )

 ;; CHECK-TEXT:      (func $f16x8.convert_i16x8_u (type $1) (param $0 v128) (result v128)
 ;; CHECK-TEXT-NEXT:  (f16x8.convert_i16x8_u
 ;; CHECK-TEXT-NEXT:   (local.get $0)
 ;; CHECK-TEXT-NEXT:  )
 ;; CHECK-TEXT-NEXT: )
 ;; CHECK-BIN:      (func $f16x8.convert_i16x8_u (type $1) (param $0 v128) (result v128)
 ;; CHECK-BIN-NEXT:  (f16x8.convert_i16x8_u
 ;; CHECK-BIN-NEXT:   (local.get $0)
 ;; CHECK-BIN-NEXT:  )
 ;; CHECK-BIN-NEXT: )
 (func $f16x8.convert_i16x8_u (param $0 v128) (result v128)
  (f16x8.convert_i16x8_u
   (local.get $0)
  )
 )
)
;; CHECK-BIN-NODEBUG:      (type $0 (func (param v128 v128) (result v128)))

;; CHECK-BIN-NODEBUG:      (type $1 (func (param v128) (result v128)))

;; CHECK-BIN-NODEBUG:      (type $2 (func (param v128 v128 v128) (result v128)))

;; CHECK-BIN-NODEBUG:      (type $3 (func (param i32) (result f32)))

;; CHECK-BIN-NODEBUG:      (type $4 (func (param i32 f32)))

;; CHECK-BIN-NODEBUG:      (type $5 (func (param f32) (result v128)))

;; CHECK-BIN-NODEBUG:      (type $6 (func (param v128) (result f32)))

;; CHECK-BIN-NODEBUG:      (type $7 (func (param v128 f32) (result v128)))

;; CHECK-BIN-NODEBUG:      (memory $0 1 1)

;; CHECK-BIN-NODEBUG:      (func $0 (type $3) (param $0 i32) (result f32)
;; CHECK-BIN-NODEBUG-NEXT:  (f32.load_f16
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $1 (type $4) (param $0 i32) (param $1 f32)
;; CHECK-BIN-NODEBUG-NEXT:  (f32.store_f16
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $2 (type $5) (param $0 f32) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.splat
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $3 (type $6) (param $0 v128) (result f32)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.extract_lane 0
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $4 (type $7) (param $0 v128) (param $1 f32) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.replace_lane 0
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $5 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.eq
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $6 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.ne
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $7 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.lt
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $8 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.gt
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $9 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.le
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $10 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.ge
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $11 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.add
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $12 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.sub
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $13 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.mul
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $14 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.div
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $15 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.min
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $16 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.max
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $17 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.pmin
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $18 (type $0) (param $0 v128) (param $1 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.pmax
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $19 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.abs
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $20 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.neg
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $21 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.sqrt
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $22 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.ceil
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $23 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.floor
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $24 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.trunc
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $25 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.nearest
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $26 (type $2) (param $0 v128) (param $1 v128) (param $2 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.relaxed_madd
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $2)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $27 (type $2) (param $0 v128) (param $1 v128) (param $2 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.relaxed_nmadd
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $1)
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $2)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $28 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (i16x8.trunc_sat_f16x8_s
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $29 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (i16x8.trunc_sat_f16x8_u
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $30 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.convert_i16x8_s
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )

;; CHECK-BIN-NODEBUG:      (func $31 (type $1) (param $0 v128) (result v128)
;; CHECK-BIN-NODEBUG-NEXT:  (f16x8.convert_i16x8_u
;; CHECK-BIN-NODEBUG-NEXT:   (local.get $0)
;; CHECK-BIN-NODEBUG-NEXT:  )
;; CHECK-BIN-NODEBUG-NEXT: )
