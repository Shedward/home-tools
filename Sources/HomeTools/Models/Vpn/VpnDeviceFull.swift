import Vapor
import Fluent

struct VpnDeviceFull: Content {
  let id: UUID
  let name: String
  let address: String
  let state: VpnDevice.State
  let createdAt: Date?

  init(vpnDevice: VpnDevice, on db: any Database) async throws {
    let device = try await vpnDevice.$device.get(on: db)

    try self.init(vpnDevice: vpnDevice, device: device)
  }

  init(vpnDevice: VpnDevice, device: Device) throws {
    guard vpnDevice.device.id == device.id else {
      throw InternalError("VpnDevice have different device id")
    }
    
    guard let id = vpnDevice.id else {
      throw InternalError("VpnDeviceFull should only be produced from created VpnDevice")
    }

    self.id = id
    self.name = device.name
    self.address = device.address
    self.state = vpnDevice.state
    self.createdAt = vpnDevice.createdAt
  }
}