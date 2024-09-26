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
    
    private func loadScene() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        
        guard let selectedMap = selectedMap else {
            scene = nil
            return
        }
        
        if let loadedScene = SCNScene(named: selectedMap.filename) {
            DispatchQueue.main.async {
                let mapNode = loadedScene.rootNode.clone()
                mapNode.position = SCNVector3(x: 100, y: 100, z: 0)
                self.scene = loadedScene
                //self.scene?.rootNode.addChildNode(cameraNode)
            }
        } else {
            print("Failed to load scene: \(selectedMap.filename)")
            scene = nil
        }
    }
}
