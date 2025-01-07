import Vapor

extension RouterService {

    struct DHCPLease: Content {
        let id: String

        let address: String
        let activeAddress: String?
        let macAddress: String
        let activeMacAddress: String?

        let activeServer: String?
        let addressLists: String?
        let blocked: String?
        let clientId: String?
        let comment: String?
        let dhcpOption: String?
        let disabled: String?
        let dynamic: String?
        let expiresAfter: String?
        let hostName: String?
        let lastSeen: String?
        let radius: String?
        let server: String?
        let status: String?

        enum CodingKeys: String, CodingKey {
            case id = ".id"
            case activeAddress = "active-address"
            case activeMacAddress = "active-mac-address"
            case activeServer = "active-server"
            case address
            case addressLists = "address-lists"
            case blocked
            case clientId = "client-id"
            case comment
            case dhcpOption = "dhcp-option"
            case disabled
            case dynamic
            case expiresAfter = "expires-after"
            case hostName = "host-name"
            case lastSeen = "last-seen"
            case macAddress = "mac-address"
            case radius
            case server
            case status
        }
    }


    func dhcpLeases() async throws -> [DHCPLease] {
        let response = try await request("/ip/dhcp-server/lease")

        return try response
            .content
            .decode([DHCPLease].self)
    }
}

