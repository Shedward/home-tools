
import Vapor

extension RouterService {

    struct AddressListItem: Codable {
        let address: String
        let comment: String
        let disabled: String
        let list: String
    }

    struct AddressList {
        private let service: RouterService
        private let name: String

        init(service: RouterService, name: String) {
            self.service = service
            self.name = name
        }

        func items() async throws -> [AddressListItem] {
            try await service.request("/ip/firewall/address-list?list=\(name)")
                .content.decode([AddressListItem].self)
        }
    }

    func addressList(_ name: String) -> AddressList {
        AddressList(service: self, name: name)
    }

    func addressListItems() async throws -> [AddressListItem] {
        try await request("/ip/firewall/address-list")
            .content.decode([AddressListItem].self)
    }
}
