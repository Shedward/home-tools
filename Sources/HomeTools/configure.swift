import NIOSSL
import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(DatabaseConfigurationFactory.sqlite(.memory), as: .sqlite)

    try await app.autoMigrate()

    app.views.use(.leaf)

    let services = try Services(app: app)
    app.setServices(services)

    // register routes
    for toolController in toolControllers(app) {
        await services.toolsList.register(toolController)
        try app.register(collection: toolController)
    }

    // static services
    for tool in tools() {
        await services.toolsList.register(tool)
    }
}
