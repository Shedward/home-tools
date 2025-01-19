import Vapor

extension Request {
    func ipAddress() -> String? {
        headers["X-Real-IP"].first ?? remoteAddress?.ipAddress
    }
}
