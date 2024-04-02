
import Vapor

class Services {
  private let app: Application

  let toolsList: ToolsListService

  init(app: Application) {
    self.app = app
    self.toolsList = InMemoryToolsListService()
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

