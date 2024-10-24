import ARKit
import SceneKit
import SwiftUI

class ARViewModel: NSObject, ObservableObject, ARSessionDelegate, ARSCNViewDelegate {
    
    @IBOutlet var arView: ARSCNView!
    
    @Published var arConfiguration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    
    private var planeNodes: [ARPlaneAnchor: SCNNode] = [:]
    private var dotNodes: [ARAnchor: SCNNode] = [:] // dotNodes
    var arrowNode: SCNNode?
    var initialAnchor: ARAnchor?
        
    override init() {
        super.init()
        setupConfiguration()
    }
    
    private func setupConfiguration() { // setup configuration of AR session
        arConfiguration.isLightEstimationEnabled = true
    }
    
    func configureARSession(for arView: ARSCNView) {
        self.arView = arView
        arView.delegate = self
        arView.session.delegate = self
        arView.scene = SCNScene()
        arView.session.run(arConfiguration)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("ARSesssion failed with error: \(error.localizedDescription)")
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        updateArrowNodePosition() // 매 프레임마다 화살표 위치 업데이트
    }

    
    func sessionWasInterrupted(_ session: ARSession) {
        print("ARSesssion was interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("ARSesssion interruption ended and Restarted")
        session.run(session.configuration!, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // If new Anchor Added
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor.name == "dotAnchor" {
            let dotNode = createDotNode(with: anchor)
            node.addChildNode(dotNode)
        }
    }

     // If Anchor is updated
     func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
         guard let currentFrame = arView?.session.currentFrame else { return }
        
         if let dotNode = dotNodes[anchor] {
             dotNode.position = SCNVector3(anchor.transform.columns.3.x, anchor.transform.columns.3.y, anchor.transform.columns.3.z)
         }
     }

    func createDotNode(with anchor: ARAnchor) -> SCNNode {
        let dot = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemBlue
        dot.materials = [material]
        
        let dotNode = SCNNode(geometry: dot)
        dotNode.position = SCNVector3(anchor.transform.columns.3.x, anchor.transform.columns.3.y, anchor.transform.columns.3.z)
        
        return dotNode
    }
    
    func convertCoordinates(x: Float, y: Float, z: Float) ->(Float, Float, Float) {
        let scaleFactor: Float = 0.01
        let x: Float = x * scaleFactor
        let y: Float = y * scaleFactor
        let z: Float = z * scaleFactor
        
        let x_adjusted: Float = x
        let y_adjusted: Float = z - 1
        let z_adjusted: Float = -y
        
        return (x_adjusted, y_adjusted, z_adjusted)
    }
    
    func addNodesToScene() {
        for nodeData in mapNodes {
            let (x, y, z) = convertCoordinates(x: nodeData.x, y: nodeData.y, z: nodeData.z)

            let newArrowNode = createArrowNode()
            newArrowNode.position = SCNVector3(x, y, z)
            arView.scene.rootNode.addChildNode(newArrowNode)
        }
     }
    
    func createArrowNode() -> SCNNode {
        // 화살표의 몸체를 원기둥으로 생성
        let shaft = SCNCylinder(radius: 0.03, height: 0.2)
        shaft.firstMaterial?.diffuse.contents = UIColor.red
        let shaftNode = SCNNode(geometry: shaft)
        shaftNode.position = SCNVector3(0, 0, 0)

        // 화살표의 머리를 원뿔로 생성
        let head = SCNCone(topRadius: 0.0, bottomRadius: 0.08, height: 0.15)
        head.firstMaterial?.diffuse.contents = UIColor.red
        let headNode = SCNNode(geometry: head)
        headNode.position = SCNVector3(0, 0.1, 0) // 몸체 끝에 위치시킴

        // 몸체와 머리를 합쳐서 하나의 노드로 만들기
        let arrowNode = SCNNode()
        arrowNode.addChildNode(shaftNode)
        arrowNode.addChildNode(headNode)
        
        arrowNode.name = "arrowNode"
        
        return arrowNode
    }
    
    func updateArrowNodePosition() {
        guard let currentFrame = arView?.session.currentFrame else { return }
        
        let cameraTransform = currentFrame.camera.transform
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1.0     // 1 meter in front of the camera
        //translation.columns.3.y = -0.3
        translation.columns.3.x = 0.5
    
        
        if let arrowNode = arrowNode {
            arrowNode.simdTransform = simd_mul(cameraTransform, translation)
            arrowNode.eulerAngles = SCNVector3( 30, -atan2(cameraTransform.columns.2.x, cameraTransform.columns.2.z), 0)
            
        } else {
            let newArrowNode = createArrowNode()
            arView.scene.rootNode.addChildNode(newArrowNode)
            arrowNode = newArrowNode
            print("arrowNode created and added")
        }
    }
    
    func setInitialPosition() {
        if let currentFrame = arView?.session.currentFrame {
            initialAnchor = nil
            print("initial position set")
        }
        else {
            print("initial position not set")
        }
    }
    
    func calculateDistance() {
        if let currentFrame = arView?.session.currentFrame, let initialAnchor = initialAnchor {
            let distance = simd_distance(currentFrame.camera.transform.columns.3, initialAnchor.transform.columns.3)
            
            print("distance: \(distance)")
        }
        else {
            print("couldn't calculate distance")
        }
    }
}
