
import Vapor

struct OnlineController: ToolController {

    let tool = Tool(
        name: "Online",
        url: "/online",
        description: "Устройства в сети"
    )

    func boot(routes: any RoutesBuilder) throws {
        let device = routes.grouped("online")
        device.get(use: index)

        let deviceApi = routes.grouped("api", "online")
        deviceApi.post("probe", use: apiProbe)
        deviceApi.get(use: apiGet)
    }

    func index(req: Request) async throws -> [RouterService.DHCPLease] {
        try await req.services.router.dhcpLeases()
    }
}

extension OnlineController {

    struct ApiProbeResponse: Content {
        let count: Int
    }

    /// Probe currently online devices
    ///
    /// POST /api/online/probe
    func apiProbe(req: Request) async throws -> ApiProbeResponse {
        let leases = try await req.services.router.dhcpLeases()
        let online = leases
            .filter { $0.lastSeen?.isEmpty == false }
            .map { lease in
                with(Online()) {
                    $0.address = lease.address
                    $0.mac = lease.macAddress
                    $0.host = lease.hostName
                    $0.comment = lease.comment
                    $0.lastSeen = lease.lastSeen
                    $0.expiresAfter = lease.expiresAfter
                }
            }
        try await online.create(on: req.db)

        return ApiProbeResponse(count: online.count)
    }

    /// Return list of all probes before given time
    ///
    /// GET /api/online
    /// Query:
    /// - max: max count, by default 100
    func apiGet(req: Request) async throws -> [Online] {
        try await req.db.query(Online.self)
            .limit(req.query.get(Int?.self, at: "max") ?? 100)
            .all()
    }
}
