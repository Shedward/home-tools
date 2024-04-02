import Fluent
import Vapor

func tools(_ app: Application) -> [any RouteCollection & ToolController] {
    [
        HomeController(),
        DeviceController()
    ]
}
