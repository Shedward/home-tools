
import Fluent
import Vapor

final class Device: Model, Content {

  static let schema = "device"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "name")
  var name: String

  @Field(key: "address")
  var address: String

  @Field(key: "mac")
  var mac: String?

  @Timestamp(key: "created_at", on: .create)
  var createdAt: Date?

  init() {
    self.name = ""
    self.address = ""
  }

  init(name: String, address: String, mac: String?) {
    self.name = name
    self.address = address
    self.mac = mac
  }
}