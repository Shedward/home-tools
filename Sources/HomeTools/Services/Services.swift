
import Vapor

class Services {
    private let app: Application

    let configs: Configs
    let toolsList: ToolsListService
    let router: RouterService
    let devices: DeviceService

    init(app: Application, configs: Configs) throws {
        self.app = app
        self.configs = configs
        self.toolsList = ToolsListService()
        self.router = RouterService(
            host: configs.routerHost,
            credentials: configs.routerCredentials,
            client: app.client
        )

        self.devices = DeviceService(db: app.db)
    }
}

struct ServicesStorageKey: StorageKey {
    typealias Value = Services
}

extension Application {
    var services: HomeTools.Services {
        get throws {
            guard let services = storage[ServicesStorageKey.self] else {
                throw InternalError("Services is not instantiated in Application")
            }
            return services
        }
    }

    @discardableResult
    func setServices(_ services: HomeTools.Services) -> Self {
        storage[ServicesStorageKey.self] = services
        return self
    }
}

extension Request {
    var services: HomeTools.Services {
        get throws {
            try application.services
        }
    }
}

