
import Vapor

struct VpnController: RouteCollection {
  func boot(routes: any RoutesBuilder) throws {
    let vpn = routes.grouped("vpn")
    vpn.get("status", use: status)
  }

  func status(req: Request) async throws -> View {
    try await req.view.render("test")
  }
}