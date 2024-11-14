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
        for i in 0..<(pathList.count) {
            if i+1 < pathList.count{
                let fromNodeName = pathList[i]
                let toNodeName = pathList[i+1]
                if let fromNode = FHnodes.first(where: { $0.name == fromNodeName }),
                let toNode = FHnodes.first(where: { $0.name == toNodeName }) {
//                                print("From")
//                                print (fromNode)
//                                print("To")
//                                print(toNode)
//                                print("---------------------------------")
                    
                        
                        
                    
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
        sphere.firstMaterial?.diffuse.contents = UIColor.blue

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
            print("scene nil")
            return
        }
        
        let mapScene = createMapScene(mapName: selectedMap.name)
       
        DispatchQueue.main.async {
            self.scene = mapScene
        }
            
    }
    
}
