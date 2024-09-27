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
            
        ]
        selectedMap = maps.first // init selectedMap
    }

    
    func createMapScene(mapName: String) -> SCNScene {
        guard let selectedMap = selectedMap else {
            scene = nil
            return SCNScene() // return empty scene
        }

        let scene = SCNScene()
        
        if let mapNode = loadUSDZModel(named: selectedMap.name){
            scene.rootNode.addChildNode(mapNode)
            
            let node1 = createSphereNode(position: SCNVector3(x: -100, y: -100, z: 30))
            let node2 = createSphereNode(position: SCNVector3(x: 200, y: -50, z: 30))
            let node3 = createSphereNode(position: SCNVector3(x: 300, y: 300, z: 30))
            
            scene.rootNode.addChildNode(node1)
            scene.rootNode.addChildNode(node2)
            scene.rootNode.addChildNode(node3)
            
            // 노드 간 선 그리기
            let line1 = createLine(from: node1.position, to: node2.position)
            let line2 = createLine(from: node2.position, to: node3.position)
            
            scene.rootNode.addChildNode(line1)
            scene.rootNode.addChildNode(line2)
            
            /*
            let overViewCamNode = SCNNode()
            overViewCamNode.camera = SCNCamera()
            overViewCamNode.position = SCNVector3(x: 0, y: 4000, z: 0)
            overViewCamNode.eulerAngles = SCNVector3(x: -.pi / 2, y: 0, z: 0)
            overViewCamNode.look(at: SCNVector3(x: 0, y: 0, z: 0))
            overViewCamNode.camera?.usesOrthographicProjection = true
            //mapNode.addChildNode(overViewCamNode)
             */
        }

        print(scene.rootNode.scale)
        print(scene.rootNode.boundingBox)
        
        

        return scene
    }
    
    func createSphereNode(position: SCNVector3) -> SCNNode {
        let sphere = SCNSphere(radius: 10)
        sphere.firstMaterial?.diffuse.contents = UIColor.red

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
            mapNode.scale = SCNVector3(0.01, 0.01, 0.01) // 1/100 scale

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
