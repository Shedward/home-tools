
import Fluent
import Vapor

final class VpnDevice: Model, Content {

  static let schema = "vpn_device"

  @ID(key: .id)
  var id: UUID?

  @Parent(key: "device_id")
  var device: Device

  @Field(key: "state")
  var state: State

  @Timestamp(key: "created_at", on: .create)
  var createdAt: Date?

  init() {
    self.device = Device()
    self.state = .disabled
  }

  init(device: Device, state: State = .disabled) {
    self.device = device
    self.state = state
  }
}

extension VpnDevice {
  enum State: String, Codable {
    case disabled
    case whitelist
    case all
  }
}