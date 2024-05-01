struct DeviceLeaf: Leaf {
  static let template = "device"

    let ip: String
    let currentDevice: Device?
    let allDevices: [Device]
}