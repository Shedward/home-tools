import Fluent

final class Migrations_0_1_0_0: AsyncMigration {
    // Added mac to devices tables to track them even if IP changed

    func prepare(on database: any Database) async throws {
        try await database.schema("device")
            .id()
            .field("name", .string)
            .field("address", .string)
            .field("mac", .string, .required)
            .field("created_at", .datetime)
            .create()

        try await database.schema("online")
            .id()
            .field("address", .string, .required)
            .field("mac", .string, .required)
            .field("host", .string)
            .field("comment", .string)
            .field("last_seen", .string)
            .field("expires_after", .string)
            .field("created_at", .datetime)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("device")
            .delete()

        try await database.schema("online")
            .delete()
    }
}

