
import Vapor

struct RouterCredentials: Codable {
    let username: String
    let password: String
    
    var basicHeader: String {
        "Basic " + "\(username):\(password)".base64String()
    }
}

final class RouterService {
    private let host: String
    private let client: Client
    private let credentials: RouterCredentials
    
    init(host: String, credentials: RouterCredentials, client: Client) {
        self.client = client
        self.credentials = credentials
        self.host = host
    }

    func request(_ path: String, beforeSend: (inout ClientRequest) throws -> () = { _ in }) async throws -> ClientResponse {
        try await client.get("http://\(host)/rest\(path)") { request in
            try beforeSend(&request)
            request.headers.add(name: "Authorization", value: credentials.basicHeader)
        }
    }
}
