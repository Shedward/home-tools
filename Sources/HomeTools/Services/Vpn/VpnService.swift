
import Vapor
import Fluent

final class VpnService {
    private let db: any Database

    weak var services: Services?

    init(db: any Database) {
        self.db = db
    }

    func devices() async throws -> [VpnDevice] {
        try await VpnDevice.query(on: db).all()
    }

    func device(address: String) async throws -> VpnDevice? {
        guard let device = try await services?.devices.device(address: address) else {
            return nil
        }

        if let existingsVpnDevice = try await VpnDevice.find(device.id, on: db) {
            return existingsVpnDevice
        }

        let vpnDevice = try await addDevice(device)

        return vpnDevice
    }

    func addDevice(_ device: Device) async throws -> VpnDevice {
        guard let deviceId = device.id else {
            throw InternalError("Only created device should be used to create vpn device")
        }
        let vpnDevice = VpnDevice(deviceId: deviceId)
        try await vpnDevice.create(on: db)
        return vpnDevice
    }

    func addDevice(_ device: VpnDevice) async throws -> VpnDevice {
        try await device.create(on: db)
        return device
    }
}
