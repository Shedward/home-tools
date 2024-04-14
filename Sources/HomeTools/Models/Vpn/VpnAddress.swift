
import Fluent
import Vapor

final class VpnAddress: Model, Content {

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
    self.host = ""
    self.isEnabled = true
  }

  init(host: String, isEnabled: Bool = true) {
    self.host = host
    self.isEnabled = isEnabled
  }
}