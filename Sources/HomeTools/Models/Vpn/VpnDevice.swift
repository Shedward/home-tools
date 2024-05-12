
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
    }

    init(deviceId: Device.IDValue, state: State = .disabled) {
        self.$device.id = deviceId
        self.state = state
    }
}

extension VpnDevice {
    enum State: String, Codable, CaseIterable {
        case disabled
        case whitelist
        case all
    }
}
