import Fluent
import Vapor

func toolControllers(_ app: Application) -> [any RouteCollection & ToolController] {
    [
        HomeController(),
        DeviceController(),
        EchoController(),
    ]
}

func tools() -> [Tool] {
    [
        Tool(
            name: "Torrents", 
            url: "/torrents", 
            description: "Общий торрент клиент"
        ),
        Tool(
            name: "Router1", 
            url: "http://router1.home", 
            description: "Роутер в комнате"
        ),
        Tool(
            name: "Router2", 
            url: "http://router2.home", 
            description: "Роутер в коридоре"
        ),
    ]
}
