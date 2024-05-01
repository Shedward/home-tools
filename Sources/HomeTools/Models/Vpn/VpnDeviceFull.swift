import Vapor

struct VpnDeviceFull: Content {
  let id: UUID
  let name: String
  let address: String
  let state: VpnDevice.State
  let createdAt: Date?

  init(vpnDevice: VpnDevice) throws {
    guard let id = vpnDevice.id else {
      throw InternalError("VpnDeviceFull should only be produced from created VpnDevice")
    }

    self.id = id
    self.name = vpnDevice.$device.name
    self.address = vpnDevice.device.address
    self.state = vpnDevice.state
    self.createdAt = vpnDevice.createdAt
  }
}