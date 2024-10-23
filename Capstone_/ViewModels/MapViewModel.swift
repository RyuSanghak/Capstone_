// ViewModels/MapViewModel.swift
import Foundation
import SceneKit
import Combine

class MapViewModel: ObservableObject {
    @Published var maps: [IndoorMap] = []
    @Published var selectedMap: IndoorMap? {
        didSet {  //
            loadScene()
        }
    }
    @Published var scene: SCNScene?
    
    
    init() {
        loadMaps()
    }
    
    private func loadMaps() {
        maps = [
            IndoorMap(name: "MFH_1", filename: "MFH_1.usdz"),
            IndoorMap(name: "MFH_2", filename: "MFH_2.usdz"),
            
        ]
        selectedMap = maps.last // init selectedMap
    }

    
    func createMapScene(mapName: String) -> SCNScene {
        guard let selectedMap = selectedMap else {
            scene = nil
            return SCNScene() // return empty scene
        }

        let scene = SCNScene()
        
        if let mapNode = loadUSDZModel(named: selectedMap.name) {
            scene.rootNode.addChildNode(mapNode)

            // Call the function to create nodes and edges
            createNodesAndEdges(mapNodes: mapNodesTwo, connectNodes: connectNodes2, scene: scene)
            
            // Optional: Add camera setup here
            let overViewCamNode = SCNNode()
            overViewCamNode.camera = SCNCamera()
            overViewCamNode.position = SCNVector3(x: 0, y: 4000, z: 0)
            overViewCamNode.eulerAngles = SCNVector3(x: -.pi / 2, y: 0, z: 0)
            overViewCamNode.look(at: SCNVector3(x: 0, y: 0, z: 0))
            overViewCamNode.camera?.usesOrthographicProjection = true
        }

        print(scene.rootNode.scale)
        print(scene.rootNode.boundingBox)
        
        return scene
    }

    
    func createNodesAndEdges(mapNodes: [nodes], connectNodes: [edges], scene: SCNScene) {
        // Create a dictionary to store node positions
        var nodePositions = [String: SCNNode]()
        
        // Add nodes (dots) to the scene
        for nodeData in mapNodes {
            // If the node's name is "3", make it blue, otherwise keep it red
            let color: UIColor = nodeData.name == "3" ? .blue : .red
            
            let node = createSphereNode(position: SCNVector3(x: Float(nodeData.x), y: Float(nodeData.y), z: Float(nodeData.z)), color: color)
            node.name = nodeData.name // Optionally set the name of the node
            scene.rootNode.addChildNode(node)
            
            // Store node position for connecting edges
            nodePositions[nodeData.name] = node
        }
        
        // Add edges (lines) between nodes
        for edgeData in connectNodes {
            if let fromNode = nodePositions[edgeData.from], let toNode = nodePositions[edgeData.to] {
                let line = createLine(from: fromNode.position, to: toNode.position)
                scene.rootNode.addChildNode(line)
            }
        }
    }


    
    func createSphereNode(position: SCNVector3, color: UIColor = .red) -> SCNNode {
        let sphere = SCNSphere(radius: 0.1)
        sphere.firstMaterial?.diffuse.contents = color

        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = position

        return sphereNode
    }
    
    func createLine(from: SCNVector3, to: SCNVector3) -> SCNNode {
        let vertices = [from, to]
        
        let vertexSource = SCNGeometrySource(vertices: vertices)
        let indices: [Int32] = [0, 1]
        let indexData = Data(bytes: indices, count: indices.count * MemoryLayout<Int32>.size)
        let geometryElement = SCNGeometryElement(data: indexData,
                                                 primitiveType: .line,
                                                 primitiveCount: 1,
                                                 bytesPerIndex: MemoryLayout<Int32>.size)
        
        let lineGeometry = SCNGeometry(sources: [vertexSource], elements: [geometryElement])
        lineGeometry.firstMaterial?.diffuse.contents = UIColor.yellow
        lineGeometry.firstMaterial?.isDoubleSided = true
        
        let lineNode = SCNNode(geometry: lineGeometry)
        return lineNode
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
//            mapNode.scale = SCNVector3(0.01, 0.01, 0.01) // 1/100 scale
            mapNode.scale = SCNVector3(1, 1, 1)
            // set name of mapNode
            mapNode.name = selectedMap?.name

            return mapNode
        } catch {
            print("Failed to load USDZ file: \(error)")
            return nil
        }
    }

    
    private func loadScene() {

        guard let selectedMap = selectedMap else {
            scene = nil
            return
        }
        
        let mapScene = createMapScene(mapName: selectedMap.name)
       
        DispatchQueue.main.async {
            self.scene = mapScene
        }
            
    }
}
