// ViewModels/MapViewModel.swift
import Foundation
import SceneKit
import Combine

class MapViewModel: ObservableObject {
    @Published var maps: [IndoorMap] = []
    @Published var selectedMap: IndoorMap?
    
    @Published var scene: SCNScene?
    
    
    init() {
        //loadMaps()
    }
    
    func loadMaps(buildingName: String) {
        
        if buildingName == "Memorial Field House" {
            maps = [
                IndoorMap(name: "MFH_1", filename: "MFH_1.usdz"),
                IndoorMap(name: "MFH_2", filename: "MFH_2.usdz"),
                
            ]
            selectedMap = maps.first // init selectedMap
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
        for i in 0..<(pathList.count - 1) {
            let fromNodeName = pathList[i]
            let toNodeName = pathList[i + 1]
            
            if let fromNode = FHnodes.first(where: { $0.name == fromNodeName }),
               let toNode = FHnodes.first(where: { $0.name == toNodeName }) {
                
                // Create a line node between `fromNode` and `toNode`
                let lineNode = createLineNode(from: SCNVector3(x: fromNode.x, y: fromNode.y, z: fromNode.z),
                                              to: SCNVector3(x: toNode.x, y: toNode.y, z: toNode.z))
                scene.rootNode.addChildNode(lineNode)
            } else {
                print("Error: Could not find nodes for edge from \(fromNodeName) to \(toNodeName)")
            }
        }
        
        print(scene.rootNode.scale)
        print(scene.rootNode.boundingBox)
        
        

        return scene
    }
    
    func createLineNode(from start: SCNVector3, to end: SCNVector3) -> SCNNode {
        let vertices: [SCNVector3] = [start, end]
        
        let source = SCNGeometrySource(vertices: vertices)
        
        let indices: [Int32] = [0, 100]
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        
        let lineGeometry = SCNGeometry(sources: [source], elements: [element])
        lineGeometry.firstMaterial?.diffuse.contents = UIColor.blue

        return SCNNode(geometry: lineGeometry)
    }

    
    func createSphereNode(position: SCNVector3) -> SCNNode {
        let sphere = SCNSphere(radius: 0.1)
        sphere.firstMaterial?.diffuse.contents = UIColor.red

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

    
    func loadScene() {

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
