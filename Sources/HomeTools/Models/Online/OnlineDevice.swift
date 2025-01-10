import Vapor

final class OnlineDevice: Content, @unchecked Sendable {
    var address: String
    var mac: String
    var host: String?

    init(online: Online) {
        self.address = online.address
        self.mac = online.mac
        self.host = online.host
    }
}
