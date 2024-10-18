import Foundation

@MainActor
func runDijkstraAlgorithm() {
    // Dijkstra Algorithm
    let graphs: [String: [String: Int]] = [
        "A": ["B": 5, "C": 0],
        "B": ["D": 15, "E": 20],
        "C": ["D": 30, "E": 35],
        "D": ["F": 5],
        "E": ["F": 10],
        "F": [:]
    ]
    
    var costs = [
        "B": Int.max,
        "C": Int.max,
        "D": Int.max,
        "E": Int.max,
        "F": Int.max
    ]
    
    var parents = [
        "B": "A",
        "C": "A",
        "D": "",
        "E": "",
        "F": ""
    ]
    
    var processedNodes: [String] = []
    
    // Find the lowest cost node that hasn't been processed
    func findLowestCostNode(costs: [String: Int]) -> String {
        var lowest_cost = Int.max
        var lowest_node = ""
        
        for (key, value) in costs {
            if value < lowest_cost && !processedNodes.contains(key) {
                lowest_cost = value
                lowest_node = key
            }
        }
        
        return lowest_node
    }
    
    // Continue until all nodes are processed
    var node = findLowestCostNode(costs: costs)
    
    while node != "" {
        let cost = costs[node]!
        let neighbors = graphs[node]!
        
        for (neighbor, neighborCost) in neighbors {
            let new_cost = cost + neighborCost
            if new_cost < costs[neighbor]! {
                costs[neighbor] = new_cost
                parents[neighbor] = node
            }
        }
        
        processedNodes.append(node)
        node = findLowestCostNode(costs: costs)
    }
    
    // Print parents and costs
    print(parents)
    print(costs)
    
    // Find the route
    var routes: [String] = []
    routes.append("F")
    
    var parent = parents["F"]
    routes.append(parent!)
    
    while parent != "A" {
        parent = parents[parent!]
        routes.append(parent!)
    }
    
    // Print the shortest path
    for (index, item) in routes.reversed().enumerated() {
        if index == routes.count - 1 {
            print(item)
        } else {
            print(item, terminator: "->")
        }
    }
    // Output: A->B->E->F
    
    // Print the cost
    print(costs["F"]!)
}

// Call the function
runDijkstraAlgorithm()

