
import Vapor

struct EchoController: ToolController {

    let tool = Tool(
        name: "Echo.home", 
        url: "/echo", 
        description: "Information and services for your current device",
        isPrivate: true
    )

    func boot(routes: any RoutesBuilder) throws {
        let device = routes.grouped("echo")
        device.get(use: index)
    }
    
    func index(req: Request) async throws -> View {
        let headers = String(describing: req.headers)
        return try await req.view.render("echo", ["headers": headers])
    }
}