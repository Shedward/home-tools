
protocol ToolsListService {
  func register(_ toolController: ToolController) async
  func register(_ tool: Tool) async
  func tools() async -> [Tool]
}