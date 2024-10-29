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
    path.flatMap({ $0 as? MyNode}).forEach { node in
        print(node.name)
    }
}

func printCost(for path: [GKGraphNode]) {
    var total: Float = 0
    for i in 0..<(path.count-1) {
        total += path[i].cost(to: path[i+1])
    }
    print(total)
    
}

func findPath(buildingName: String, start: String, end: String) {
    
    var nodeList: [MyNode] = []
    
    for node in mapNodes{
        nodeList.append(MyNode(name: node.name,x: node.x, y: node.y, z: node.z))
    }

    myGraph.add(nodeList)
    
    for edge in connectNodes {
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
    
    path.compactMap({ $0 as? MyNode}).forEach { node in
        pathList.append(node.name)
    }
    
    print("path: \(pathList)")


    func euclideanDistance(pointA: MyNode, pointB: MyNode) -> Float {
        let dx = pointA.x - pointB.x
        let dy = pointA.y - pointB.y
        let dz = pointA.z - pointB.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }

    //print("Distance: \(String(format: "%.2f",distance))")
    
    
    
}





