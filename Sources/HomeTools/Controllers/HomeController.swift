
import Vapor

struct HomeController: ToolController {

    let tool = Tool(
        name: "Home.home",
        url: "/",
        description: "Начальная страница",
        isPrivate: true
    )

    func boot(routes: any RoutesBuilder) throws {
        routes.get(use: index)
    }

    func index(req: Request) async throws -> View {
        let tools = try await req.services.toolsList
            .tools()
            .filter { !$0.isPrivate }

        return try await req.view.render("home", ["tools": tools])
    }
}
