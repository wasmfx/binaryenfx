(module
 (type $0 (func (param i32 i64) (result i64 i32)))
 (type $1 (cont $0))
 (type $2 (func (param (ref $1)) (result (ref $1))))
 (func $0 (param $0 (ref $1)) (result (ref $1))
  (local.get $0)
 )
)
