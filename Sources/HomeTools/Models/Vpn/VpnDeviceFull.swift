import Vapor
import Fluent

struct VpnDeviceFull: Content {
  let id: UUID
  let name: String
  let address: String
  let state: VpnDevice.State
  let createdAt: Date?

  init(vpnDevice: VpnDevice, on db: any Database) async throws {
    guard let id = vpnDevice.id else {
      throw InternalError("VpnDeviceFull should only be produced from created VpnDevice")
    }

    self.id = id

    let device = try await vpnDevice.$device.get(on: db)

    self.name = device.name
    self.address = device.address
    self.state = vpnDevice.state
    self.createdAt = vpnDevice.createdAt
  }
}