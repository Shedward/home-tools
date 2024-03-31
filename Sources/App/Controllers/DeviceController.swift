
import Vapor

struct DeviceController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let device = routes.grouped("device")
        device.get(use: index)
    }
    
    func index(req: Request) async throws -> View {
        let ipAddress = req.remoteAddress?.ipAddress ?? "Unknown"
        return try await req.view.render("device", ["ip": ipAddress])
    }
}
