
import Vapor

struct DeviceController: ToolController {

    let tool = Tool(
        name: "Device", 
        url: "/device", 
        description: "Информация о подключенном устройстве"
    )

    func boot(routes: any RoutesBuilder) throws {
        let device = routes.grouped("device")
        device.get(use: index)

        let deviceApi = routes.grouped("api", "device")
        deviceApi.post(use: apiAdd)
        deviceApi.delete(use: apiDelete)
    }

    struct IndexContent: Encodable {
        let ip: String
        let currentDevice: Device?
        let allDevices: [Device]
    }
    
    func index(req: Request) async throws -> View {
        let ipAddress = req.headers["X-Real-IP"].first ?? req.remoteAddress?.ipAddress ?? "Unknown"
        let currentDevice = try await req.services.devices.device(address: ipAddress)
        let allDevices = try await req.services.devices.devices()
        let content = IndexContent(ip: ipAddress, currentDevice: currentDevice, allDevices: allDevices)
        return try await req.view.render("device", content)
    }
}

// API

extension DeviceController {

    struct CreateRequest: Content {
        let name: String
        let address: String
    }

    func apiAdd(req: Request) async throws -> Device {
        let createDevice = try req.content.decode(CreateRequest.self)
        let newDevice = Device(name: createDevice.name, address: createDevice.address, mac: nil)
        return try await req.services.devices.add(newDevice)
    }

    struct DeleteResponse: Content {
    }

    func apiDelete(req: Request) async throws -> DeleteResponse {
        guard 
            let idString: String = req.query["id"],
            let id = UUID(uuidString: idString)
        else {
            throw Abort(.badRequest, reason: "id is not provided")
        }

        try await req.services.devices.delete(id)
        return DeleteResponse()
    }
}
