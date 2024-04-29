
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

    struct IndexContent: Encodable {
        let sources: [RouterService.AddressListItem]
        let destinations: [RouterService.AddressListItem]
    }

    func index(req: Request) async throws -> View {
        let sources = try await req.services.router
            .addressList("to_vpn_source")
            .items()

        let destinations = try await req.services.router
            .addressList("to_vpn_destination")
            .items()

        return try await req.view.render(
            "vpn",
            IndexContent(sources: sources, destinations: destinations)
        )
    }
}
