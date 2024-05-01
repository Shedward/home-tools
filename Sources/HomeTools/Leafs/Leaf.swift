import Vapor

protocol Leaf: Encodable {
  static var template: String { get }
}

extension ViewRenderer {
  func render<L: Leaf>(_ leaf: L) async throws -> View {
    try await render(L.template, leaf)
  }
}