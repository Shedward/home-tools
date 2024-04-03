
import Vapor

struct DeviceController: ToolController {

    let tool = Tool(
        name: "Device.home", 
        url: "/device", 
        description: "Information and services for your current device"
    )

    func boot(routes: any RoutesBuilder) throws {
        let device = routes.grouped("device")
        device.get(use: index)
    }
    
    func index(req: Request) async throws -> View {
        let ipAddress = req.headers["X-Real-IP"].first ?? req.remoteAddress?.ipAddress ?? "Unknown"
        return try await req.view.render("device", ["ip": ipAddress])
    }
}
