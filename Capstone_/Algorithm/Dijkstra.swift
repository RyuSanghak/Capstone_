//
//  Dijkstra.swift
//  Capstone_
//
//  Created by Yulia Lee on 10/28/24.
//

import GameplayKit
import CoreGraphics
let myGraph = GKGraph()

class MyNode: GKGraphNode {
  let name: String
  var travelCost: [GKGraphNode: Float] = [:]

  init(name: String) {
    self.name = name
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    self.name = ""
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

func print(_ path: [GKGraphNode]) {
  path.compactMap({ $0 as? MyNode}).forEach { node in
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

func findPath() {
    let n1 = MyNode(name: "1") //Hallway
    let n2 = MyNode(name: "2")
    let n3 = MyNode(name: "3")
    let n4 = MyNode(name: "4")
    let n5 = MyNode(name: "5")
    let n6 = MyNode(name: "6")
    let n7 = MyNode(name: "7")
    let n8 = MyNode(name: "8")
    let n9 = MyNode(name: "9")
    let n10 = MyNode(name: "10")
    let n11 = MyNode(name: "11")
    let n12 = MyNode(name: "12")
    let n13 = MyNode(name: "13")
    let n14 = MyNode(name: "14")
    let n15 = MyNode(name: "15")
    let n16 = MyNode(name: "16")
    let n17 = MyNode(name: "17")
    let n18 = MyNode(name: "18")
    let n19 = MyNode(name: "19")
    let n20 = MyNode(name: "20")
    let n21 = MyNode(name: "21")
    let n22 = MyNode(name: "22")
    let n23 = MyNode(name: "23")
    let n24 = MyNode(name: "24")
    let n25 = MyNode(name: "25")
    let n26 = MyNode(name: "26")
    let n27 = MyNode(name: "27")
    let n28 = MyNode(name: "28")
    let n29 = MyNode(name: "29")
    let n30 = MyNode(name: "30")
    let n31 = MyNode(name: "31")
    let n32 = MyNode(name: "32")
    let n33 = MyNode(name: "33")
    let n34 = MyNode(name: "34")
    let n35 = MyNode(name: "35")
    let n36 = MyNode(name: "36")
    let n37 = MyNode(name: "37")
    let n38 = MyNode(name: "38")
    let n39 = MyNode(name: "39")
    let n40 = MyNode(name: "40")

    

    myGraph.add([
        n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
        n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
        n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
        n31, n32, n33, n34, n35, n36, n37, n38, n39, n40
    ])
    
    
    n1.addConnection(to: n2, weight: 0)
    n2.addConnection(to: n3, weight: 0)
    n3.addConnection(to: n13, weight: 0)
    let path = myGraph.findPath(from: n1, to: n3)
    print(path)
    printCost(for: path)
    
    
    struct Point3D {
        var x: Double
        var y: Double
        var z: Double
    }


    func euclideanDistance(pointA: Point3D, pointB: Point3D) -> Double {
        let dx = pointA.x - pointB.x
        let dy = pointA.y - pointB.y
        let dz = pointA.z - pointB.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }

    // Example usage
    let pointA = Point3D(x: 1.0, y: 2.0, z: 0)
    let pointB = Point3D(x: 4.0, y: 5.0, z: 0)
    let distance = euclideanDistance(pointA: pointA, pointB: pointB)
    print("Distance: \(String(format: "%.2f",distance))")
    
    
    
}





