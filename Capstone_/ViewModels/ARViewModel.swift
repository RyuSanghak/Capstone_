import ARKit
import SceneKit
import SwiftUI


class ARViewModel: NSObject, ObservableObject, ARSessionDelegate, ARSCNViewDelegate {
    
    weak var arView: ARSCNView?
    
    @Published var arConfiguration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    
    private var planeNodes: [ARPlaneAnchor: SCNNode] = [:]
    private var dotNodes: [ARAnchor: SCNNode] = [:] // dotNodes
        
    override init() {
        super.init()
        setupConfiguration()
    }
    
    private func setupConfiguration() { // setup configuration of AR session
        //arConfiguration.planeDetection = [.horizontal]
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
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("ARSesssion was interrupted")
    }
    func sessionInterruptionEnded(_ session: ARSession) {
        print("ARSesssion interruption ended and Restarted")
        session.run(session.configuration!, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // If new Anchor Added
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let dotAnchor = anchor as? ARAnchor {
            let dotNode = createDotNode(with: dotAnchor)
            node.addChildNode(dotNode)
        }
    }

     // If Anchor is updated
     func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
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
    
}

