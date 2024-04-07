
import Fluent

final class DeviceService {
  private let db: any Database

  init(db: any Database) {
    self.db = db
  }

  func device(address: String) async throws -> Device? {
    try await Device.query(on: db)
      .filter(\.$address == address)
      .first()
  }

  func devices() async throws -> [Device] {
    try await Device.query(on: db)
      .all()
  }

  func add(_ device: Device) async throws -> Device {
    try await device.create(on: db)
    return device
  }

  func delete(_ id: UUID) async throws {
    try await Device.find(id, on: db)?.delete(on: db)
  }
}