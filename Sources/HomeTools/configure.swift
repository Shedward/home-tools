import Fluent
import FluentSQLiteDriver
import Leaf
import NIOSSL
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    app.logger.info("🏠 Starting HomeTools 🏠")

    guard let configPath = Environment.get("HOME_TOOLS_CONFIG_PATH") else {
        throw InternalError("Config path not found in environment at HOME_TOOLS_CONFIG_PATH")
    }

    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .secondsSince1970
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    ContentConfiguration.global.use(encoder: encoder, for: .json)
    ContentConfiguration.global.use(decoder: decoder, for: .json)

    app.logger.info("Reading configuration from \(configPath)")

    let data = try Data(contentsOf: URL(fileURLWithPath: configPath))
    let configs = try JSONDecoder().decode(Configs.self, from: data)

    app.logger.info("Connecting db from \(configs.dbFile)")

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.sqlite(.file(configs.dbFile)), as: .sqlite)

    let services = try Services(app: app, configs: configs)
    app.setServices(services)

    app.views.use(.leaf)

    app.logger.info("Register migrations")

    // register migrations
    for migration in migrations() {
        app.migrations.add(migration)
    }

    app.logger.info("Register routes")

    // register routes
    for toolController in toolControllers(app) {
        await services.toolsList.register(toolController)
        try app.register(collection: toolController)
    }

    app.logger.info("Register tools")

    // static services
    for tool in tools() {
        await services.toolsList.register(tool)
    }
}
