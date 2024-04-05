
import Vapor

struct VpnController: ToolController {

    let tool = Tool(
        name: "Vpn",
        url: "/vpn",
        description: "Общий VPN"
    )

    func boot(routes: any RoutesBuilder) throws {
        let device = routes.grouped("vpn")
        device.get(use: index)
    }
    
    func index(req: Request) async throws -> View {
        let addressListItems = try await req.services.router.addressListItems()
        return try await req.view.render("vpn", ["items": addressListItems])
    }
}
