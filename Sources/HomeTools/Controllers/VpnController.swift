
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
        apiVpn.put("updateDeviceState", use: apiUpdateDeviceState)
    }

    func index(req: Request) async throws -> View {

        let current = try await apiCurrentDevice(req: req)
        return try await req.view.render(
            VpnLeaf(
                current: current.device, 
                availableStates: VpnDevice.State.allCases,
                allDevices: .init(allDevices: [])
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

    func apiUpdateDeviceState(req: Request) async throws -> VpnDevice {
        throw InternalError("Not implemented")
    }
}
