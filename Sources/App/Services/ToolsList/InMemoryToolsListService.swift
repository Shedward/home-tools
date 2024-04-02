
actor InMemoryToolsListService: ToolsListService {
  private var registeredTools: [Tool] = []

  func register(_ toolController: any ToolController) {
    registeredTools.append(toolController.tool)
  }

  func tools() async -> [Tool] {
    registeredTools
  }
}