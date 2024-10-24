

import Foundation

class Dijkstra: ObservableObject {
    var graph: [String: [String: Float]] = [:]
    var startNode: nodes?
    var endNode: nodes?
    var shortestPath: [nodes] = []
    
    func createGraphList(nodes: [nodes], edges: [edges]){
        for node in nodes {
            graph[node.name] = [:]
        }
        
        for edge in edges {
            if graph.keys.contains(edge.from) {
                graph[edge.from]?[edge.to] = getDistances(from: edge.from, to: edge.to)
            }
            
        }
        print(graph.count)
    }
    
    func getDistances(from: String, to: String) -> Float? {
        if let fromNode = mapNodes.first(where: { $0.name == from }),
           let toNode = mapNodes.first(where: { $0.name == to }) {
            
            let distance = sqrt(pow(fromNode.x - toNode.x, 2) + pow(fromNode.y - toNode.y, 2))
            
            return distance
        }
        return nil
    }
}


