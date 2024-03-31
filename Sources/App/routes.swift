import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("device")
    }

    app.get("test") { req async throws in
        try await req.view.render("test")
    }

    try app.register(collection: DeviceController())
    try app.register(collection: VpnController())
}
