
struct Tool: Codable {
    let id: String
    let name: String
    let url: String
    let description: String
    var isPrivate: Bool

    init(
        id: String? = nil,
        name: String,
        url: String,
        description: String,
        isPrivate: Bool = false
    ) {
        self.id = id ?? name
        self.name = name
        self.url = url
        self.description = description
        self.isPrivate = isPrivate
    }

    func `private`(_ isPrivate: Bool = true ) -> Self {
        with(self) { $0.isPrivate = isPrivate }
    }
}
