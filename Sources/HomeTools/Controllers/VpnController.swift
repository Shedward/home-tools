
import Vapor

struct VpnController: ToolController {

    let tool = Tool(
        name: "Vpn",
        url: "/vpn",
        description: "Общий VPN"
    )

    func boot(routes: any RoutesBuilder) throws {
        let vpn = routes.grouped("vpn")
        vpn.get(use: index)

        let apiVpn = routes.grouped("api", "vpn")
        apiVpn.get("current", use: apiCurrentDevice)
        apiVpn.put("deviceState", use: apiUpdateDeviceState)
    }

    func index(req: Request) async throws -> View {

        let current = try await apiCurrentDevice(req: req)
        let allDevices = try await req.services.vpn.fullDevices()

        return try await req.view.render(
            VpnLeaf(
                current: current.device, 
                availableStates: VpnDevice.State.allCases,
                allDevices: allDevices
            )
        )
    }
}

// API

extension VpnController {

    struct ApiCurrentDeviceResponse: Content {
        let device: VpnDeviceFull?
    }

    /// Current device vpn config
    ///
    /// GET /api/vpn/current
    /// - response: ApiCurrentDeviceResponse
    func apiCurrentDevice(req: Request) async throws -> ApiCurrentDeviceResponse {
        guard 
            let ipAddress = req.ipAddress(),
            let vpnDevice = try await req.services.vpn.device(address: ipAddress)
        else {
            return ApiCurrentDeviceResponse(device: nil)
        }

        let vpnDeviceFull = try await VpnDeviceFull(vpnDevice: vpnDevice, on: req.db)
        return ApiCurrentDeviceResponse(device: vpnDeviceFull)
    }

    struct ApiUpdateDeviceStateRequest: Content {
        let device: VpnDevice.IDValue
        let newState: VpnDevice.State
    }

    /// Set device status
    /// 
    /// PUT /api/vpn/deviceState
    func apiUpdateDeviceState(req: Request) async throws -> VpnDevice {
        let request = try req.content.decode(ApiUpdateDeviceStateRequest.self)
        let updatedDevice = try await req.services.vpn.setState(request.newState, for: request.device)
        return updatedDevice
    }
}
