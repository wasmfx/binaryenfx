(module
  (type  (func (param i32) (result i32)))
  ;;(type  (func (param i32) (result i32)))
  (type  (cont 0))
  ;;(type  (func (param (ref 0)) (result)))
  (type  (func (param (ref 1)) (result (ref 1))))
  (func $0 (type 2) (local.get 0))
)


;; module with cont-types that already causes parsing error:
;; (module
;;   (type  (func (param i32) (result i32)))
;;   (type  (func (param i32) (result i32)))
;;   ;;(type  (cont 0))
;;   ;;(type  (func (param (ref 0)) (result)))
;;   (type  (func (param (ref 0)) (result (ref 0))))
;;   (func $0 (type 2) (local.get 0))
;; )
