
import Vapor

protocol ToolController: RouteCollection {
    var tool: Tool { get }
}
