import GameplayKit
import CoreGraphics
let myGraph = GKGraph()
var pathList: [String] = []

class MyNode: GKGraphNode {
    let name: String
    let x,y,z: Float
    var travelCost: [GKGraphNode: Float] = [:]
    
    init(name: String, x: Float, y: Float, z: Float) {
        self.name = name
        self.x = x
        self.y = y
        self.z = z
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let decodedName = aDecoder.decodeObject(forKey: "name") as? String else {
            return nil
        }
        self.name = decodedName
        self.x = aDecoder.decodeFloat(forKey: "x")
        self.y = aDecoder.decodeFloat(forKey: "y")
        self.z = aDecoder.decodeFloat(forKey: "z")
        super.init()
    }
    
    override func cost(to node: GKGraphNode) -> Float {
        return travelCost[node] ?? 0
    }
    
    func addConnection(to node: GKGraphNode, bidirectional: Bool = true, weight: Float) {
        self.addConnections(to: [node], bidirectional: bidirectional)
        travelCost[node] = weight
        guard bidirectional else { return }
        (node as? MyNode)?.travelCost[self] = weight
    }
}


func printPath(_ path: [GKGraphNode]) {
    path.compactMap({ $0 as? MyNode}).forEach { node in
        print(node.name)
    }
}

func printCost(for path: [GKGraphNode]) {
    guard path.count > 1 else {
            print("Path is too short to calculate cost.")
            return
        }
        
        var total: Float = 0
        for i in 0..<(path.count - 1) {
            total += path[i].cost(to: path[i + 1])
        }
        print(total)
    
}

func findPath(buildingName: String, start: String, end: String) {
    
    var nodeList: [MyNode] = []
    pathList.removeAll()
    

    //빌딩별로 데이터 셋업
    var selectedNodes: [nodes] {
        switch buildingName {
        case "Memorial Field House":
            return FHnodes
        case "Rocket Hall":
            return TestNodes
        case "Nitschke Hall":
            return TestNodes
        default:
            return []
        }
    }
    
    
    var selectedEdges: [edges] {
        switch buildingName {
        case "Memorial Field House":
            return FHedges
        case "Rocket Hall":
            return TestconnectNodes
        case "Nitschke Hall":
            return TestconnectNodes
        default:
            return []
        }
    }
    
    for node in selectedNodes{
        nodeList.append(MyNode(name: node.name,x: node.x, y: node.y, z: node.z))
    }

    myGraph.add(nodeList)
    
    for edge in selectedEdges {
        if let fromNode = nodeList.first(where: { $0.name == edge.from }) {
            if let toNode = nodeList.first(where: { $0.name == edge.to }) {
                fromNode.addConnection(to: toNode, weight: euclideanDistance(pointA: fromNode, pointB: toNode))
            }
            else {
                print("couldn't find node \(edge.to)")
            }
        }
        else {
             print("Couldn't find node \(edge.from)")
        }
    }
    
    let path = myGraph.findPath(from: (nodeList.first (where: { $0.name == start }))!, to: (nodeList.first (where: { $0.name == end }))!)
    
    printPath(path)
    printCost(for: path)
    
    path.compactMap({ $0 as? MyNode}).forEach { node in  // make path list as String
        pathList.append(node.name)
    }
    
    print("path: \(pathList)")
    //print building name
    print(buildingName, ", printing in Dijkstra")


    func euclideanDistance(pointA: MyNode, pointB: MyNode) -> Float {
        let dx = pointA.x - pointB.x
        let dy = pointA.y - pointB.y
        let dz = pointA.z - pointB.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }

    //print("Distance: \(String(format: "%.2f",distance))")
    
    
    
}
