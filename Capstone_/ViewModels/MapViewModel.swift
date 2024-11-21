// ViewModels/MapViewModel.swift
import Foundation
import SceneKit
import Combine

class MapViewModel: ObservableObject {
    @Published var maps: [IndoorMap] = []
    @Published var selectedMap: IndoorMap?
    
    @Published var scene: SCNScene?
    
    var currentNode: String?
    var currentNodeIndex: Int = 0
    
    var userPathNodeList: [SCNNode] = []
    var filteredNodeList: [nodes] = []
        
    init(){
    }
    
    func loadMaps(buildingName: String) {
                // 매번 filteredNodeList를 초기화하여 값이 쌓이지 않도록 합니다.
                filteredNodeList = []

                // FHnodes에서 1층에 있는 모든 노드들 필터해서 filterNodes에 삽이
        let filteredNodes = FHnodes.filter {
            $0.name.prefix(3) == "f1n" ||
            $0.name.prefix(6) == "Room 1" ||
            $0.name.prefix(10) == "Restroom 1" ||
            $0.name.prefix(4) == "Door" ||
            $0.name.prefix(8) == "Stair C1" ||
            $0.name.prefix(11) == "Elevator C1"
        }
        
                // 필터된 노드를 filteredNodeList에 추가
                for node in filteredNodes {
                    filteredNodeList.append(node)
                }
                
                // 특정 건물 이름에 대해서만 맵을 설정
                if buildingName == "Memorial Field House" {
                    maps = [  // maps 배열을 초기화
                            IndoorMap(name: "MFH_1", filename: "MFH_1.usdz"),
                            IndoorMap(name: "MFH_2", filename: "MFH_2.usdz"),
                        ]
                    
                    // filteredNodeList와 currentNodeName을 비교하여 맵 선택
                    var mapFound = false

                    for node in filteredNodeList {
                        if node.name == currentNode {
                            selectedMap = maps[0]  // 일치하면 첫 번째 맵 선택
                            print("일치")
                            mapFound = true
                            break  // 일치하면 루프 종료
                        }
                    }

                    // 일치하는 맵이 없으면 두 번째 맵 선택
                    if !mapFound {
                        selectedMap = maps[1]
                        print("불일치")
                    }

                    print("선택된 맵: \(selectedMap?.name ?? "맵 없음")")
                    
                    // 상태 변화를 알리기
                    DispatchQueue.main.async {
                        self.objectWillChange.send()
                    }
                        
                    // Debugging: currentNodeName과 filteredNodeList의 이름들 출력
                    print("Current Node Name: \(currentNode ?? "No current node")")
                    let nodeNames = filteredNodeList.map { $0.name }
                    print("Filtered Node Names: \(nodeNames)")
                }
            }
    
    func createMapScene(mapName: String) -> SCNScene {
        guard let selectedMap = selectedMap else {
            scene = nil
            return SCNScene() // return empty scene
        }

        let scene = SCNScene()
        
        if let mapNode = loadUSDZModel(named: selectedMap.name){
            scene.rootNode.addChildNode(mapNode)
            
            for nodeName in pathList {
                if let node = FHnodes.first(where: { $0.name == nodeName }) {
                    let sphereNode = createSphereNode(position: SCNVector3(x: node.x, y: node.y, z: node.z))
                    scene.rootNode.addChildNode(sphereNode)
                    
                } else {
                    print("Error: Could not find node with name \(nodeName)")
                }
            }
        }
        
        // Draw lines only between consecutive nodes in pathList
        for i in 0..<(pathList.count) {
            if i+1 < pathList.count{
                let fromNodeName = pathList[i]
                let toNodeName = pathList[i+1]
                if let fromNode = FHnodes.first(where: { $0.name == fromNodeName }),
                let toNode = FHnodes.first(where: { $0.name == toNodeName }) {
                    
                // Create a line node between `fromNode` and `toNode`
                let lineNode = createLineNode(from: SCNVector3(x: fromNode.x, y: fromNode.y, z: fromNode.z),
                                              to: SCNVector3(x: toNode.x, y: toNode.y, z: toNode.z))
                scene.rootNode.addChildNode(lineNode)
            }
            } else {
                print("Error: ")
            }
        }
        
        print(scene.rootNode.scale)
        print(scene.rootNode.boundingBox)
        
        updateNodeColor(scene: scene)

        return scene
    }

    func createLineNode(from: SCNVector3, to: SCNVector3) -> SCNNode {
        let distance = sqrt(pow(to.x - from.x, 2) + pow(to.y - from.y, 2) + pow(to.z - from.z, 2))
        
        let cylinder = SCNCylinder(radius: 0.05, height: CGFloat(distance))
        cylinder.firstMaterial?.diffuse.contents = UIColor.blue // Set the line color
        
        let lineNode = SCNNode(geometry: cylinder)
        
        lineNode.position = SCNVector3(
            (from.x + to.x) / 2,
            (from.y + to.y) / 2,
            (from.z + to.z) / 2
        )
        if to.x > from.x && to.y > from.y {
            lineNode.eulerAngles.z += .pi // Flip 180 degrees around z-axis to invert along the x-axis
        }
        if to.x > from.x && to.y < from.y {
            lineNode.eulerAngles.z -= .pi
        }

        lineNode.look(at: to)
        lineNode.eulerAngles.x += .pi / 2 // Rotate 90 degrees around x-axis to align correctly
        
        
        return lineNode
    }

    
    func createSphereNode(position: SCNVector3) -> SCNNode {
        let sphere = SCNSphere(radius: 0.1)
//        sphere.firstMaterial?.diffuse.contents = UIColor.blue

        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = position

        return sphereNode
    }
    
    func loadUSDZModel(named name: String) -> SCNNode? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "usdz")
        else {
            print("Failed to find USDZ file: \(name).usdz")
            return nil
        }

        do {
            let mapScene = try SCNScene(url: url, options: nil)
        
            // Copy the rootNode of Scene to mapNode
            let mapNode = SCNNode()
            for child in mapScene.rootNode.childNodes {
                mapNode.addChildNode(child)
            }

            // set the position and scale for mapNode
            mapNode.position = SCNVector3(0, 0, 0)
            //mapNode.scale = SCNVector3(0.01, 0.01, 0.01) // 1/100 scale
            //mapNode.scale = SCNVector3(1, 1, 1)
            // set name of mapNode
            mapNode.name = selectedMap?.name

            return mapNode
        } catch {
            print("Failed to load USDZ file: \(error)")
            return nil
        }
    }
    
    
    // Function to be called when the button is pressed to go to the next node
    func nextNodeButtonPressed() {
        // Increment the index to go to the next node
        if currentNodeIndex < pathList.count {
            loadScene() // Reload the scene to reflect the change
        }
    }
    
    // Function to simulate updating currentNode
    func updateCurrentNode() {
        currentNode = pathList[currentNodeIndex] // Update the currentNode value
        print("!!!!!!Current Node is: ", currentNode) // Print currentNode
    }
    
    // Update the color of the current node (based on currentNodeIndex)
    func updateNodeColor(scene: SCNScene) {
        // Reset color of all nodes in pathList to blue
//        for i in 0..<pathList.count {
//            if let node = FHnodes.first(where: { $0.name == pathList[i] }) {
//                let sphereNode = createSphereNode(position: SCNVector3(x: node.x, y: node.y, z: node.z))
//                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//                scene.rootNode.addChildNode(sphereNode)
//            }
//        }
        
        // Update color of the current node to red
        if currentNodeIndex < pathList.count {
            let currentNodeName = pathList[currentNodeIndex]
            if let node = FHnodes.first(where: { $0.name == currentNodeName }) {
                let sphereNode = createSphereNode(position: SCNVector3(x: node.x, y: node.y, z: node.z))
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                scene.rootNode.addChildNode(sphereNode)
            }
        }
    }
    
    func loadScene() {
        guard let selectedMap = selectedMap else {
            scene = nil
            print("scene nil")
            return
        }
        
        let mapScene = createMapScene(mapName: selectedMap.name)
       
        DispatchQueue.main.async {
            self.scene = mapScene
        }
        print("scene loaded")
       // updateCurrentNode()
    }
    
    
    
}
