
import Vapor
import Fluent

final class VpnService {
  private let db: any Database

  init(db: any Database) {
    self.db = db
  }

  func devices() async throws -> [VpnDevice] {
    try await VpnDevice.query(on: db).all()
  }

  func addDevice(_ device: VpnDevice) async throws -> VpnDevice {
    try await device.create(on: db)
    return device
  }
}