import Fluent
import Vapor

final class Online: Model, Content, @unchecked Sendable {

    static let schema = "online"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "address")
    var address: String

    @Field(key: "mac")
    var mac: String

    @Field(key: "host")
    var host: String?

    @Field(key: "comment")
    var comment: String?

    @Field(key: "last_seen")
    var lastSeen: String?

    @Field(key: "expires_after")
    var expiresAfter: String?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() {
    }
}
