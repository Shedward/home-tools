struct VpnLeaf: Leaf {
  static let template = "vpn"

  let sources: [RouterService.AddressListItem]
  let destinations: [RouterService.AddressListItem]
}