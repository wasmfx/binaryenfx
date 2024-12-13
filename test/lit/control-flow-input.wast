;; NOTE: Assertions have been generated by update_lit_checks.py and should not be edited.

;; Check that control flow input is correctly parsed using scratch locals. The
;; binary input file is generated from this file using WABT's wat2wasm
;; --enable-all --debug-names and should be regenerated when new tests are added
;; here.

;; RUN: wasm-opt -all %s -S -o - | filecheck %s
;; RUN: wasm-opt -all %s.wasm -S -o - | filecheck %s

(module
  (type $id (func (param i32) (result i32)))

  ;; CHECK:      (tag $e (param i32))
  (tag $e (param i32))

  ;; CHECK:      (func $block (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (block (result i32)
  ;; CHECK-NEXT:   (local.get $scratch)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $block (result i32)
    i32.const 0
    block (param i32) (result i32)
    end
  )

  ;; CHECK:      (func $block-multivalue (type $1) (result i32 i64)
  ;; CHECK-NEXT:  (local $scratch (tuple i32 i64))
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (tuple.make 2
  ;; CHECK-NEXT:    (i32.const 0)
  ;; CHECK-NEXT:    (i64.const 1)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (block (type $1) (result i32 i64)
  ;; CHECK-NEXT:   (local.get $scratch)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $block-multivalue (result i32 i64)
    i32.const 0
    i64.const 1
    block (param i32 i64) (result i32 i64)
    end
  )

  ;; CHECK:      (func $block-drop (type $2)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (block
  ;; CHECK-NEXT:   (drop
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $block-drop
    i32.const 0
    block (param i32)
      drop
    end
  )

  ;; CHECK:      (func $block-multivalue-drop (type $2)
  ;; CHECK-NEXT:  (local $scratch (tuple i32 i64))
  ;; CHECK-NEXT:  (local $scratch_1 (tuple i32 i64))
  ;; CHECK-NEXT:  (local $scratch_2 i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (tuple.make 2
  ;; CHECK-NEXT:    (i32.const 0)
  ;; CHECK-NEXT:    (i64.const 1)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (block
  ;; CHECK-NEXT:   (drop
  ;; CHECK-NEXT:    (block (result i32)
  ;; CHECK-NEXT:     (local.set $scratch_2
  ;; CHECK-NEXT:      (tuple.extract 2 0
  ;; CHECK-NEXT:       (local.tee $scratch_1
  ;; CHECK-NEXT:        (local.get $scratch)
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:     (drop
  ;; CHECK-NEXT:      (tuple.extract 2 1
  ;; CHECK-NEXT:       (local.get $scratch_1)
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:     (local.get $scratch_2)
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $block-multivalue-drop
    i32.const 0
    i64.const 1
    block (param i32 i64)
      drop
      drop
    end
  )

  ;; CHECK:      (func $block-passthrough-nop (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local $scratch_1 i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (block (result i32)
  ;; CHECK-NEXT:   (local.set $scratch_1
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (nop)
  ;; CHECK-NEXT:   (local.get $scratch_1)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $block-passthrough-nop (result i32)
    i32.const 0
    block (param i32) (result i32)
      nop
    end
  )

  ;; CHECK:      (func $block-passthrough-type (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (block (result i32)
  ;; CHECK-NEXT:   (local.get $scratch)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $block-passthrough-type (result i32)
    i32.const 0
    block (type $id)
    end
  )

  ;; CHECK:      (func $loop (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (loop (result i32)
  ;; CHECK-NEXT:   (local.get $scratch)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $loop (result i32)
    i32.const 0
    loop (param i32) (result i32)
    end
  )

  ;; CHECK:      (func $loop-branch (type $2)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (loop $label0
  ;; CHECK-NEXT:   (block $label1
  ;; CHECK-NEXT:    (local.set $scratch
  ;; CHECK-NEXT:     (block $label (result i32)
  ;; CHECK-NEXT:      (br $label
  ;; CHECK-NEXT:       (local.get $scratch)
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:      (br $label1)
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:    (br $label0)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $loop-branch
    i32.const 0
    loop (param i32)
      br 0
    end
  )

  ;; CHECK:      (func $loop-branch-cond (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (loop $label0 (result i32)
  ;; CHECK-NEXT:   (block $label1 (result i32)
  ;; CHECK-NEXT:    (local.set $scratch
  ;; CHECK-NEXT:     (block $label (result i32)
  ;; CHECK-NEXT:      (br $label1
  ;; CHECK-NEXT:       (br_if $label
  ;; CHECK-NEXT:        (local.get $scratch)
  ;; CHECK-NEXT:        (i32.const 1)
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:    (br $label0)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $loop-branch-cond (result i32)
    i32.const 0
    loop (param i32) (result i32)
      i32.const 1
      br_if 0
    end
  )

  ;; CHECK:      (func $loop-branch-cond-drop (type $2)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (loop $label0
  ;; CHECK-NEXT:   (block $label1
  ;; CHECK-NEXT:    (local.set $scratch
  ;; CHECK-NEXT:     (block $label (result i32)
  ;; CHECK-NEXT:      (drop
  ;; CHECK-NEXT:       (br_if $label
  ;; CHECK-NEXT:        (local.get $scratch)
  ;; CHECK-NEXT:        (i32.const 1)
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:      (br $label1)
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:    (br $label0)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $loop-branch-cond-drop
    i32.const 0
    loop (param i32)
      i32.const 1
      br_if 0
      drop
    end
  )

  ;; CHECK:      (func $loop-branch-cond-new-val (type $4) (result i64)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (loop $label0 (result i64)
  ;; CHECK-NEXT:   (block $label1 (result i64)
  ;; CHECK-NEXT:    (local.set $scratch
  ;; CHECK-NEXT:     (block $label (result i32)
  ;; CHECK-NEXT:      (br $label1
  ;; CHECK-NEXT:       (block (result i64)
  ;; CHECK-NEXT:        (drop
  ;; CHECK-NEXT:         (br_if $label
  ;; CHECK-NEXT:          (local.get $scratch)
  ;; CHECK-NEXT:          (i32.const 1)
  ;; CHECK-NEXT:         )
  ;; CHECK-NEXT:        )
  ;; CHECK-NEXT:        (i64.const 2)
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:    (br $label0)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $loop-branch-cond-new-val (result i64)
    i32.const 0
    loop (param i32) (result i64)
      i32.const 1
      br_if 0
      drop
      i64.const 2
    end
  )

  ;; CHECK:      (func $nested-loops-multivalue (type $1) (result i32 i64)
  ;; CHECK-NEXT:  (local $scratch (tuple i32 i64))
  ;; CHECK-NEXT:  (local $scratch_1 (tuple i32 i64))
  ;; CHECK-NEXT:  (block $label2 (type $1) (result i32 i64)
  ;; CHECK-NEXT:   (local.set $scratch
  ;; CHECK-NEXT:    (tuple.make 2
  ;; CHECK-NEXT:     (i32.const 0)
  ;; CHECK-NEXT:     (i64.const 1)
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (loop $label10
  ;; CHECK-NEXT:    (block $label11
  ;; CHECK-NEXT:     (local.set $scratch
  ;; CHECK-NEXT:      (block $label1 (type $1) (result i32 i64)
  ;; CHECK-NEXT:       (local.set $scratch_1
  ;; CHECK-NEXT:        (local.get $scratch)
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:       (loop $label0
  ;; CHECK-NEXT:        (block $label3
  ;; CHECK-NEXT:         (local.set $scratch_1
  ;; CHECK-NEXT:          (block $label (type $1) (result i32 i64)
  ;; CHECK-NEXT:           (br_table $label $label1 $label2
  ;; CHECK-NEXT:            (local.get $scratch_1)
  ;; CHECK-NEXT:            (i32.const 2)
  ;; CHECK-NEXT:           )
  ;; CHECK-NEXT:           (br $label3)
  ;; CHECK-NEXT:          )
  ;; CHECK-NEXT:         )
  ;; CHECK-NEXT:         (br $label0)
  ;; CHECK-NEXT:        )
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:       (br $label11)
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:     (br $label10)
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (unreachable)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $nested-loops-multivalue (result i32 i64)
    i32.const 0
    i64.const 1
    loop (param i32 i64)
      loop (param i32 i64)
        i32.const 2
        br_table 0 1 2
      end
    end
    unreachable
  )

  ;; CHECK:      (func $if (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (if (result i32)
  ;; CHECK-NEXT:   (i32.const 1)
  ;; CHECK-NEXT:   (then
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (else
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $if (result i32)
    i32.const 0
    i32.const 1
    if (param i32) (result i32)
    end
  )

  ;; CHECK:      (func $if-new-val (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (if (result i32)
  ;; CHECK-NEXT:   (i32.const 1)
  ;; CHECK-NEXT:   (then
  ;; CHECK-NEXT:    (drop
  ;; CHECK-NEXT:     (local.get $scratch)
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:    (i32.const 2)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (else
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $if-new-val (result i32)
    i32.const 0
    i32.const 1
    if (param i32) (result i32)
      drop
      i32.const 2
    end
  )

  ;; CHECK:      (func $if-multivalue (type $1) (result i32 i64)
  ;; CHECK-NEXT:  (local $scratch (tuple i32 i64))
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (tuple.make 2
  ;; CHECK-NEXT:    (i32.const 0)
  ;; CHECK-NEXT:    (i64.const 1)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (if (type $1) (result i32 i64)
  ;; CHECK-NEXT:   (i32.const 2)
  ;; CHECK-NEXT:   (then
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (else
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $if-multivalue (result i32 i64)
    i32.const 0
    i64.const 1
    i32.const 2
    if (param i32 i64) (result i32 i64)
    end
  )

  ;; CHECK:      (func $if-else (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (if (result i32)
  ;; CHECK-NEXT:   (i32.const 1)
  ;; CHECK-NEXT:   (then
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (else
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $if-else (result i32)
    i32.const 0
    i32.const 1
    if (param i32) (result i32)
    else
    end
  )

  ;; CHECK:      (func $if-else-drop (type $2)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (if
  ;; CHECK-NEXT:   (i32.const 1)
  ;; CHECK-NEXT:   (then
  ;; CHECK-NEXT:    (drop
  ;; CHECK-NEXT:     (local.get $scratch)
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (else
  ;; CHECK-NEXT:    (drop
  ;; CHECK-NEXT:     (local.get $scratch)
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $if-else-drop
    i32.const 0
    i32.const 1
    if (param i32)
      drop
    else
      drop
    end
  )

  ;; CHECK:      (func $if-else-multivalue (type $5) (result f32)
  ;; CHECK-NEXT:  (local $scratch (tuple i32 i64))
  ;; CHECK-NEXT:  (local $scratch_1 (tuple i32 i64))
  ;; CHECK-NEXT:  (local $scratch_2 i32)
  ;; CHECK-NEXT:  (local $scratch_3 (tuple i32 i64))
  ;; CHECK-NEXT:  (local $scratch_4 i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (tuple.make 2
  ;; CHECK-NEXT:    (i32.const 0)
  ;; CHECK-NEXT:    (i64.const 1)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (if (result f32)
  ;; CHECK-NEXT:   (i32.const 2)
  ;; CHECK-NEXT:   (then
  ;; CHECK-NEXT:    (drop
  ;; CHECK-NEXT:     (block (result i32)
  ;; CHECK-NEXT:      (local.set $scratch_2
  ;; CHECK-NEXT:       (tuple.extract 2 0
  ;; CHECK-NEXT:        (local.tee $scratch_1
  ;; CHECK-NEXT:         (local.get $scratch)
  ;; CHECK-NEXT:        )
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:      (drop
  ;; CHECK-NEXT:       (tuple.extract 2 1
  ;; CHECK-NEXT:        (local.get $scratch_1)
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:      (local.get $scratch_2)
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:    (f32.const 3)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (else
  ;; CHECK-NEXT:    (drop
  ;; CHECK-NEXT:     (block (result i32)
  ;; CHECK-NEXT:      (local.set $scratch_4
  ;; CHECK-NEXT:       (tuple.extract 2 0
  ;; CHECK-NEXT:        (local.tee $scratch_3
  ;; CHECK-NEXT:         (local.get $scratch)
  ;; CHECK-NEXT:        )
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:      (drop
  ;; CHECK-NEXT:       (tuple.extract 2 1
  ;; CHECK-NEXT:        (local.get $scratch_3)
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:      (local.get $scratch_4)
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:    (f32.const 4)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $if-else-multivalue (result f32)
    i32.const 0
    i64.const 1
    i32.const 2
    if (param i32 i64) (result f32)
      drop
      drop
      f32.const 3
    else
      drop
      drop
      f32.const 4
    end
  )

  ;; CHECK:      (func $try (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (try (result i32)
  ;; CHECK-NEXT:   (do
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $try (result i32)
    i32.const 0
    try (param i32) (result i32)
    end
  )

  ;; CHECK:      (func $try-catch (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (try (result i32)
  ;; CHECK-NEXT:   (do
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (catch $e
  ;; CHECK-NEXT:    (pop i32)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $try-catch (result i32)
    i32.const 0
    try (param i32) (result i32)
    catch $e
    end
  )

  ;; CHECK:      (func $try-catch-all (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (try (result i32)
  ;; CHECK-NEXT:   (do
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (catch_all
  ;; CHECK-NEXT:    (i32.const 1)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $try-catch-all (result i32)
    i32.const 0
    try (param i32) (result i32)
    catch_all
      i32.const 1
    end
  )

  ;; CHECK:      (func $try-catch-delegate (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (try (result i32)
  ;; CHECK-NEXT:   (do
  ;; CHECK-NEXT:    (local.get $scratch)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (delegate 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $try-catch-delegate (result i32)
    i32.const 0
    try (param i32) (result i32)
    delegate 0
  )

  ;; CHECK:      (func $try-table (type $0) (result i32)
  ;; CHECK-NEXT:  (local $scratch i32)
  ;; CHECK-NEXT:  (local.set $scratch
  ;; CHECK-NEXT:   (i32.const 0)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (try_table (result i32)
  ;; CHECK-NEXT:   (local.get $scratch)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT: )
  (func $try-table (result i32)
    i32.const 0
    try_table (param i32) (result i32)
    end
  )
)
