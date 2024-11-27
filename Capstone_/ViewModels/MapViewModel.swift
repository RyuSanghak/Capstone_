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
    var F1_filteredNodeList: [nodes] = []
    var F2_filteredNodeList: [nodes] = []
    
    @Published var mapFound: Bool = false
    var mapIndicator: String?
        
    init(){
    }
    
    func loadMaps(buildingName: String) {
                // 매번 filteredNodeList를 초기화하여 값이 쌓이지 않도록 합니다.
        F1_filteredNodeList = []
        F2_filteredNodeList = []
        
        let F1_filteredNodes = FHnodes.filter {
            $0.name.prefix(3) == "f1n" ||
            $0.name.prefix(6) == "Room 1" ||
            $0.name.prefix(10) == "Restroom 1" ||
            $0.name.prefix(4) == "Door" ||
            $0.name.prefix(8) == "Stair C1" ||
            $0.name.prefix(11) == "Elevator C1"
        }
        for node in F1_filteredNodes {
            F1_filteredNodeList.append(node)
        }
        
        let F2_filteredNodes = FHnodes.filter {
            $0.name.prefix(3) == "f2n" ||
            $0.name.prefix(6) == "Room 2" ||
            $0.name.prefix(10) == "Restroom 2" ||
            $0.name.prefix(8) == "Stair C2" ||
            $0.name.prefix(11) == "Elevator C2"
        }
        for node in F2_filteredNodes {
            F2_filteredNodeList.append(node)
        }
        
                
                // 특정 건물 이름에 대해서만 맵을 설정
                if buildingName == "Memorial Field House" {
                    maps = [  // maps 배열을 초기화
                            IndoorMap(name: "MFH_1", filename: "MFH_1.usdz"),
                            IndoorMap(name: "MFH_2", filename: "MFH_2.usdz"),
                        ]
                    
                    // filteredNodeList와 currentNodeName을 비교하여 맵 선택
                    // var mapFound = false

                    for node in F1_filteredNodeList {
                        if node.name == currentNode {
                            selectedMap = maps[0]  // 일치하면 첫 번째 맵 선택
                            print("일치")
                            mapFound = true
                            break  // 일치하면 루프 종료
                        }
                    }
                    
                    for node in F2_filteredNodeList {
                        if node.name == currentNode {
                            selectedMap = maps[1]  // 일치하면 첫 번째 맵 선택
                            print("불일치")
                            mapFound = false
                            break  // 일치하면 루프 종료
                        }
                    }

                    print("선택된 맵: \(selectedMap?.name ?? "맵 없음")")
                    
                    // 상태 변화를 알리기
                    DispatchQueue.main.async {
                        self.objectWillChange.send()
                    }
                        
                    // Debugging: currentNodeName과 filteredNodeList의 이름들 출력
                    print("Current Node Name: \(currentNode ?? "No current node")")
                    //let nodeNames = filteredNodeList.map { $0.name }
                    //print("Filtered Node Names: \(nodeNames)")
                }
            }
    
    func focusCameraOnPath(scene: SCNScene, pathList: [String]) {
        // Calculate the bounding box based on pathList nodes
        var minX = Float.greatestFiniteMagnitude
        var maxX = -Float.greatestFiniteMagnitude
        var minY = Float.greatestFiniteMagnitude
        var maxY = -Float.greatestFiniteMagnitude
        var minZ = Float.greatestFiniteMagnitude
        var maxZ = -Float.greatestFiniteMagnitude

        for nodeName in pathList {
            if let node = FHnodes.first(where: { $0.name == nodeName }) {
                minX = min(minX, node.x)
                maxX = max(maxX, node.x)
                minY = min(minY, node.y)
                maxY = max(maxY, node.y)
                minZ = min(minZ, node.z)
                maxZ = max(maxZ, node.z)
            }
        }

        // Calculate the center of the bounding box
        let centerX = (minX + maxX) / 2
        let centerY = (minY + maxY) / 2
        let centerZ = (minZ + maxZ) / 2

        // Calculate the size of the bounding box
        let sizeX = maxX - minX
        let sizeY = maxY - minY
        let sizeZ = maxZ - minZ

        // Create a camera node
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        
        // Position the camera to frame the bounding box
        let maxSize = max(sizeX, sizeY, sizeZ)
        cameraNode.position = SCNVector3(centerX, centerY-10, centerZ + Float(maxSize) * 2) // Adjust the Z offset as needed

        // Point the camera at the center of the bounding box
        cameraNode.look(at: SCNVector3(centerX, centerY, centerZ))
    
        // Adjust the camera field of view
        camera.fieldOfView = 22
        print(cameraNode.eulerAngles)
        print("sdalkfjnaslekj")
        // Add the camera to the scene
        scene.rootNode.addChildNode(cameraNode)
    }

    
    func createMapScene(mapName: String) -> SCNScene {
        guard let selectedMap = selectedMap else {
            scene = nil
            return SCNScene() // return empty scene
        }

        let scene = SCNScene()
        
        
        if let mapNode = loadUSDZModel(named: selectedMap.name){
            scene.rootNode.addChildNode(mapNode)
            
            if mapFound {
            for nodeName in pathList {
                if let node = F1_filteredNodeList.first(where: { $0.name == nodeName }) {
                    let sphereNode = createSphereNode(position: SCNVector3(x: node.x, y: node.y, z: node.z))
                    scene.rootNode.addChildNode(sphereNode)
                }
                    
                    
                    // SCNText로 3D 텍스트 객체 생성
                    if mapFound == true {
                        mapIndicator = "F1"
                    }
                    else if mapFound == false {
                        mapIndicator = "F2"
                    }
                    
                    let mapIndicatorText = mapIndicator ?? "No Map" // 기본값으로 "No Map" 설정
                    let textGeometry = SCNText(string: mapIndicatorText, extrusionDepth: 0.1)
                    textGeometry.font = UIFont.systemFont(ofSize: 1.2)
                    textGeometry.firstMaterial?.diffuse.contents = UIColor.gray
                    let textNode = SCNNode(geometry: textGeometry)
                    textNode.position = SCNVector3(x: -8, y: 6, z: 0.1)
                    scene.rootNode.addChildNode(textNode)
                
                }
            } else {
                for nodeName in pathList {
                    if let node = F2_filteredNodeList.first(where: { $0.name == nodeName }) {
                        let sphereNode = createSphereNode(position: SCNVector3(x: node.x, y: node.y, z: node.z))
                        scene.rootNode.addChildNode(sphereNode)
                    }
                        
                        
                        // SCNText로 3D 텍스트 객체 생성
                        if mapFound == true {
                            mapIndicator = "F1"
                        }
                        else if mapFound == false {
                            mapIndicator = "F2"
                        }
                        
                        let mapIndicatorText = mapIndicator ?? "No Map" // 기본값으로 "No Map" 설정
                        let textGeometry = SCNText(string: mapIndicatorText, extrusionDepth: 0.1)
                        textGeometry.font = UIFont.systemFont(ofSize: 1.2)
                        textGeometry.firstMaterial?.diffuse.contents = UIColor.gray
                        let textNode = SCNNode(geometry: textGeometry)
                        textNode.position = SCNVector3(x: -8, y: 6, z: 0.1)
                        scene.rootNode.addChildNode(textNode)
                    
                    }
                }
        }
        
        /*
        // 선그리기
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
         */
        
        // 선 연결 로직
        for i in 0..<(pathList.count) {
            if i + 1 < pathList.count {
                let fromNodeName = pathList[i]
                let toNodeName = pathList[i + 1]
                
                // 1층과 2층 구분에 따라 노드 리스트 선택
                if mapFound {
                    // 1층 노드 리스트 사용
                    if let fromNode = F1_filteredNodeList.first(where: { $0.name == fromNodeName }),
                       let toNode = F1_filteredNodeList.first(where: { $0.name == toNodeName }) {
                        let lineNode = createLineNode(from: SCNVector3(x: fromNode.x, y: fromNode.y, z: fromNode.z),
                                                      to: SCNVector3(x: toNode.x, y: toNode.y, z: toNode.z))
                        scene.rootNode.addChildNode(lineNode)
                    }
                } else {
                    // 2층 노드 리스트 사용
                    if let fromNode = F2_filteredNodeList.first(where: { $0.name == fromNodeName }),
                       let toNode = F2_filteredNodeList.first(where: { $0.name == toNodeName }) {
                        let lineNode = createLineNode(from: SCNVector3(x: fromNode.x, y: fromNode.y, z: fromNode.z),
                                                      to: SCNVector3(x: toNode.x, y: toNode.y, z: toNode.z))
                        scene.rootNode.addChildNode(lineNode)
                    }
                }
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
        // 1. 먼저 현재 씬에서 기존에 추가된 노드들(구체 노드) 제거
        scene.rootNode.enumerateChildNodes { (node, _) in
            if node.geometry is SCNSphere {
                node.removeFromParentNode()
            }
        }
        
        // 2. 층에 따라 적절한 노드 리스트 선택
        let nodeList = mapFound ? F1_filteredNodeList : F2_filteredNodeList
        
        // 3. 현재 경로의 모든 노드 색상 초기화 (파란색)
        for nodeName in pathList {
            if let node = nodeList.first(where: { $0.name == nodeName }) {
                let sphereNode = createSphereNode(position: SCNVector3(x: node.x, y: node.y, z: node.z))
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
                scene.rootNode.addChildNode(sphereNode)
            }
        }
        
        // 4. 현재 노드 색상 변경 (빨간색)
        if currentNodeIndex < pathList.count {
            let currentNodeName = pathList[currentNodeIndex]
            if let currentNode = nodeList.first(where: { $0.name == currentNodeName }) {
                let sphereNode = createSphereNode(position: SCNVector3(x: currentNode.x, y: currentNode.y, z: currentNode.z))
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
        
        // Focus the camera on the path
        focusCameraOnPath(scene: mapScene, pathList: pathList)
        
        DispatchQueue.main.async {
            self.scene = mapScene
        }
        print("scene loaded")
    }
    
    
    
}
