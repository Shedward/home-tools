struct VpnLeaf: Leaf {
  static let template = "vpn"

  let current: VpnDeviceFull?
  let availableStates: [VpnDevice.State]
  let allDevices: [VpnDeviceFull]
}