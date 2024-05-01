
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
        deviceApi.delete(":id", use: apiDelete)
    }

    func index(req: Request) async throws -> View {
        let ipAddress = req.ipAddress()

        let currentDevice: Device? = if let ipAddress {
            try await req.services.devices.device(address: ipAddress)
        } else {
            nil
        }
        let allDevices = try await req.services.devices.devices()
        let deviceLeaf = DeviceLeaf(ip: ipAddress, currentDevice: currentDevice, allDevices: allDevices)
        return try await req.view.render(deviceLeaf)
    }
}

// API

extension DeviceController {

    struct ApiCreateRequest: Content {
        let name: String
        let address: String
    }

    /// Creates device
    /// 
    /// POST /api/device
    /// - body: ApiCreateRequest
    func apiAdd(req: Request) async throws -> Device {
        let createDevice = try req.content.decode(ApiCreateRequest.self)
        let newDevice = Device(name: createDevice.name, address: createDevice.address, mac: nil)
        return try await req.services.devices.add(newDevice)
    }

    struct ApiDeleteRequestQuery: Decodable {
        let id: UUID
    }

    /// Deletes device
    ///
    /// DELETE /api/device/:id
    func apiDelete(req: Request) async throws -> EmptyContent {
        let reqQuery = try req.query.decode(ApiDeleteRequestQuery.self)

        try await req.services.devices.delete(reqQuery.id)
        return EmptyContent()
    }
}
