;; NOTE: Assertions have been generated by update_lit_checks.py and should not be edited.
;; RUN: wasm-opt %s -all --optimize-instructions -S -o - | filecheck %s

(module
  ;; CHECK:      (memory $0 16 17)
  (memory $0 16 17)

  ;; CHECK:      (func $i32-direct (type $1) (param $x i32)
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (i32.extend8_s
  ;; CHECK-NEXT:    (local.get $x)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i32-direct (param $x i32)
    ;; We do not need to sign-extend twice, and can emit just one extend8.
    (drop
      (i32.extend8_s
        (i32.shr_s
          (i32.shl
            (local.get $x)
            (i32.const 24)
          )
          (i32.const 24)
        )
      )
    )
  )

  ;; CHECK:      (func $i32-local (type $0)
  ;; CHECK-NEXT:  (local $temp i32)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i32.load8_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (local.get $temp)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i32-local
    ;; The local is sign-extended, so the i32.extend can be removed.
    (local $temp i32)
    (local.set $temp
      (i32.load8_s
        (i32.const 22)
      )
    )
    (drop
      (i32.extend8_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i32-local-i16 (type $0)
  ;; CHECK-NEXT:  (local $temp i32)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i32.load16_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (local.get $temp)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i32-local-i16
    ;; As above with i16.
    (local $temp i32)
    (local.set $temp
      (i32.load16_s
        (i32.const 22)
      )
    )
    (drop
      (i32.extend16_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i32-local-i16-mismatch-bad (type $0)
  ;; CHECK-NEXT:  (local $temp i32)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i32.load16_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (i32.extend8_s
  ;; CHECK-NEXT:    (local.get $temp)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i32-local-i16-mismatch-bad
    ;; As above with in i8/i16 mismatch. We do not optimize.
    (local $temp i32)
    (local.set $temp
      (i32.load16_s
        (i32.const 22)
      )
    )
    (drop
      (i32.extend8_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i32-local-i16-mismatch-good (type $0)
  ;; CHECK-NEXT:  (local $temp i32)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i32.load8_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (local.get $temp)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i32-local-i16-mismatch-good
    ;; As above with in i8/i16 mismatch, but in the direction we can handle.
    (local $temp i32)
    (local.set $temp
      (i32.load8_s
        (i32.const 22)
      )
    )
    (drop
      (i32.extend16_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i64 (type $0)
  ;; CHECK-NEXT:  (local $temp i64)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i64.load8_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (local.get $temp)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i64
    ;; As above, but with i64.
    (local $temp i64)
    (local.set $temp
      (i64.load8_s
        (i32.const 22)
      )
    )
    (drop
      (i64.extend8_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i64-i16 (type $0)
  ;; CHECK-NEXT:  (local $temp i64)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i64.load16_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (local.get $temp)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i64-i16
    (local $temp i64)
    (local.set $temp
      (i64.load16_s
        (i32.const 22)
      )
    )
    (drop
      (i64.extend16_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i64-i32 (type $0)
  ;; CHECK-NEXT:  (local $temp i64)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i64.load32_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (local.get $temp)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i64-i32
    (local $temp i64)
    (local.set $temp
      (i64.load32_s
        (i32.const 22)
      )
    )
    (drop
      (i64.extend32_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i64-mismatch-good (type $0)
  ;; CHECK-NEXT:  (local $temp i64)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i64.load8_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (local.get $temp)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i64-mismatch-good
    (local $temp i64)
    (local.set $temp
      (i64.load8_s
        (i32.const 22)
      )
    )
    (drop
      (i64.extend16_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i64-mismatch-good2 (type $0)
  ;; CHECK-NEXT:  (local $temp i64)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i64.load8_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (local.get $temp)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i64-mismatch-good2
    (local $temp i64)
    (local.set $temp
      (i64.load8_s
        (i32.const 22)
      )
    )
    (drop
      (i64.extend32_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i64-mismatch-good3 (type $0)
  ;; CHECK-NEXT:  (local $temp i64)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i64.load16_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (local.get $temp)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i64-mismatch-good3
    (local $temp i64)
    (local.set $temp
      (i64.load16_s
        (i32.const 22)
      )
    )
    (drop
      (i64.extend32_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i64-mismatch-bad (type $0)
  ;; CHECK-NEXT:  (local $temp i64)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i64.load16_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (i64.extend8_s
  ;; CHECK-NEXT:    (local.get $temp)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i64-mismatch-bad
    (local $temp i64)
    (local.set $temp
      (i64.load16_s
        (i32.const 22)
      )
    )
    (drop
      (i64.extend8_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i64-mismatch-bad2 (type $0)
  ;; CHECK-NEXT:  (local $temp i64)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i64.load32_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (i64.extend8_s
  ;; CHECK-NEXT:    (local.get $temp)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i64-mismatch-bad2
    (local $temp i64)
    (local.set $temp
      (i64.load32_s
        (i32.const 22)
      )
    )
    (drop
      (i64.extend8_s
        (local.get $temp)
      )
    )
  )

  ;; CHECK:      (func $i64-mismatch-bad3 (type $0)
  ;; CHECK-NEXT:  (local $temp i64)
  ;; CHECK-NEXT:  (local.set $temp
  ;; CHECK-NEXT:   (i64.load32_s
  ;; CHECK-NEXT:    (i32.const 22)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (drop
  ;; CHECK-NEXT:   (i64.extend16_s
  ;; CHECK-NEXT:    (local.get $temp)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $i64-mismatch-bad3
    (local $temp i64)
    (local.set $temp
      (i64.load32_s
        (i32.const 22)
      )
    )
    (drop
      (i64.extend16_s
        (local.get $temp)
      )
    )
  )
)