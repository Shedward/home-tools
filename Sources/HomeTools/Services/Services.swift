
import Vapor

class Services {
    private let app: Application
    
    let configs: Configs
    let toolsList: ToolsListService
    let router: RouterService
    
    init(app: Application) throws {

        guard let configPath = Environment.get("HOME_TOOLS_CONFIG_PATH") else {
            throw InternalError("Config path not found in environment at HOME_TOOLS_CONFIG_PATH")
        }

        let data = try Data(contentsOf: URL(filePath: configPath))
        self.configs = try JSONDecoder().decode(Configs.self, from: data)

        self.app = app
        self.toolsList = InMemoryToolsListService()
        self.router = RouterService(
            host: configs.routerHost,
            credentials: configs.routerCredentials,
            client: app.client
        )
    }
}

struct ServicesStorageKey: StorageKey {
    typealias Value = Services
}

extension Application {
    var services: Services {
        get throws {
            guard let services = storage[ServicesStorageKey.self] else {
                throw InternalError("Services is not instantiated in Application")
            }
            return services
        }
    }
    
    @discardableResult
    func setServices(_ services: Services) -> Self {
        storage[ServicesStorageKey.self] = services
        return self
    }
}

extension Request {
    var services: Services {
        get throws {
            try application.services
        }
    }
}

