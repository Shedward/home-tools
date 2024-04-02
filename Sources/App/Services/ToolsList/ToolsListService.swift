
protocol ToolsListService {
  func register(_ toolController: ToolController) async
  func tools() async -> [Tool]
}