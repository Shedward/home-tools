import Fluent

final class Migrations_0_0_6_0: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("vpn_device")
            .delete()
        try await database.schema("vpn_address")
            .delete()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("vpn_address")
            .id()
            .field("host", .string)
            .field("enabled", .bool)
            .field("created_at", .datetime)
            .create()

        try await database.schema("vpn_device")
            .id()
            .field("device_id", .uuid, .required, .references("device", "id", onDelete: .cascade))
            .field("state", .string, .required)
            .field("created_at", .datetime)
            .create()
    }
}

