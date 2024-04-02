
@inlinable
func with<T>(_ value: T, changes: (inout T) -> Void) -> T {
  var newValue = value
  changes(&newValue)
  return newValue
}