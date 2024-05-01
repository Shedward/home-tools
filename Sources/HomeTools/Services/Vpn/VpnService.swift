
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
        return try await VpnDevice.find(device.id, on: db)
    }

    func addDevice(_ device: VpnDevice) async throws -> VpnDevice {
        try await device.create(on: db)
        return device
    }
}
