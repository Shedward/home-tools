
actor ToolsListService {
    private var registeredTools: [Tool] = []
    
    func register(_ toolController: any ToolController) {
        registeredTools.append(toolController.tool)
    }
    
    func register(_ tool: Tool) {
        registeredTools.append(tool)
    }
    
    func tools() async -> [Tool] {
        registeredTools
    }
}
