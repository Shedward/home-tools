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

    let services = Services(app: app)
    app.setServices(services)

    // register routes
    for tool in tools(app) {
        await services.toolsList.register(tool)
        try app.register(collection: tool)
    }
}
