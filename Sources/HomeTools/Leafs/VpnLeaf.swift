struct VpnLeaf: Leaf {
  static let template = "vpn"

  struct AllDevices: Encodable {
    let allDevices: [VpnDeviceFull]
  }

  let current: VpnDeviceFull?
  let allDevices: AllDevices?
}