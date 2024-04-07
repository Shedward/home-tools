
import Fluent

final class Migrations_0_0_3_2: AsyncMigration {

  func prepare(on database: any Database) async throws {
    try await database.schema("vpn_device")
      .id()
      .field("device_id", .uuid, .required, .references("device", "id"))
      .field("state", .string, .required)
      .field("created_at", .datetime)
      .create()

    try await database.schema("device")
      .id()
      .field("name", .string, .required)
      .field("address", .string, .required)
      .field("mac", .string)
      .field("created_at", .datetime)
      .create()

    try await database.schema("vpn_address")
      .id()
      .field("host", .string)
      .field("enabled", .bool)
      .field("created_at", .datetime)
      .create()
  }

  func revert(on database: any Database) async throws {
    try await database.schema("vpn_device")
      .delete()

    try await database.schema("device")
      .delete()

    try await database.schema("vpn_address")
      .delete()
  }
}