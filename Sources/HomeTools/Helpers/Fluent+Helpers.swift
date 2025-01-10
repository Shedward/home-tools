import Fluent

extension QueryBuilder where Model: Fluent.Model {
    @discardableResult
    func `if`(_ enableFilterIf: Bool, _ condition: (QueryBuilder<Model>) throws -> ()) rethrows -> Self {
        if enableFilterIf {
            try condition(self)
        }
        return self
    }

    @discardableResult
    func ifLet<Value>(_ optional: Value?, _ condition: (Value, QueryBuilder<Model>) throws -> ()) rethrows -> Self {
        if let optional {
            try condition(optional, self)
        }
        return self
    }
}

