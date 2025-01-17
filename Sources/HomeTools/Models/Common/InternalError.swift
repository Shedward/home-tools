
import Vapor

struct InternalError: DebuggableError, Codable {
    let identifier: String
    let reason: String

    init(_ reason: String, file: StaticString = #fileID, line: UInt = #line) {
        self.identifier = "\(file):\(line)"
        self.reason = reason
    }
}
