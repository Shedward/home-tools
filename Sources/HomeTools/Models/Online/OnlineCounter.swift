import Vapor

final class OnlineCounter: Content, @unchecked Sendable {

    var start: Date
    var count: Int

    init(start: Date, count: Int) {
        self.start = start
        self.count = count
    }
}
