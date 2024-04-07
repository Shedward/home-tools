import NIOSSL
import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {

    guard let configPath = Environment.get("HOME_TOOLS_CONFIG_PATH") else {
        throw InternalError("Config path not found in environment at HOME_TOOLS_CONFIG_PATH")
    }

    let data = try Data(contentsOf: URL(filePath: configPath))
    let configs = try JSONDecoder().decode(Configs.self, from: data)

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.sqlite(.file(configs.dbFile)), as: .sqlite)

    let services = try Services(app: app, configs: configs)
    app.setServices(services)

    app.views.use(.leaf)

    // register migrations 
    for migration in migrations() {
        app.migrations.add(migration)
    }

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
