
import Fluent
import Vapor

final class VpnAddress: Model, Content, @unchecked Sendable {

    static let schema = "vpn_address"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "host")
    var host: String

    @Field(key: "enabled")
    var isEnabled: Bool

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() {
    }

    init(host: String, isEnabled: Bool = true) {
        self.host = host
        self.isEnabled = isEnabled
    }
}
