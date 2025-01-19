import Vapor

struct EchoController: ToolController {

    let tool = Tool(
        name: "Echo",
        url: "/echo",
        description: "Тестовый запрос",
        isPrivate: true
    )

    func boot(routes: any RoutesBuilder) throws {
        let device = routes.grouped("echo")
        device.get(use: index)
    }

    func index(req: Request) async throws -> View {
        let echoLeaf = EchoLeaf(headers: String(describing: req.headers))
        return try await req.view.render(echoLeaf)
    }
}
