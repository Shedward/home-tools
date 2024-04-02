
struct Tool: Codable {
  let id: String
  let name: String
  let url: String
  let description: String
  var isPrivate: Bool

  init(
    id: String = #fileID, 
    name: String, 
    url: String, 
    description: String,
    isPrivate: Bool = false
  ) {
    self.id = id
    self.name = name
    self.url = url
    self.description = description
    self.isPrivate = isPrivate
  }

  func `private`(_ isPrivate: Bool = true ) -> Self {
    with(self) { $0.isPrivate = isPrivate }
  }
}