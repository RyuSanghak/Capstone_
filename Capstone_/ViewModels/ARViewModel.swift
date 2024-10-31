import ARKit
import SceneKit
import SwiftUI

class ARViewModel: NSObject, ObservableObject, ARSessionDelegate, ARSCNViewDelegate {
    
    @IBOutlet var arView: ARSCNView!
    
    @Published var arConfiguration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    
    private var planeNodes: [ARPlaneAnchor: SCNNode] = [:]
    private var dotNodes: [SCNNode] = []
    var arrowNode: SCNNode?
    var startPosition: SCNVector3?
    var initialAnchor: ARAnchor?

    override init() {
        super.init()
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        arConfiguration.isLightEstimationEnabled = true
        arConfiguration.worldAlignment = .gravityAndHeading
        arConfiguration.environmentTexturing = .automatic

    }
    
    func configureARSession(for arView: ARSCNView) {
        self.arView = arView
        arView.delegate = self
        arView.session.delegate = self
        arView.scene = SCNScene()
        arView.session.run(arConfiguration)
    }
    
    // ARView가 로드되거나, 뷰가 처음 나타날 때 다음 코드를 호출하세요.
    func startARSession() {
        configureARSession(for: arView)               // 1. setup AR session
        addInitialWorldAnchor()                      // 2. initialize (0,0,0) World Anchor
    }
    
    func addInitialWorldAnchor() {
        let anchorTransform = matrix_identity_float4x4
        let worldAnchor = ARAnchor(transform: anchorTransform)
        initialAnchor = worldAnchor
        arView.session.add(anchor: worldAnchor)
        print("World anchor added at (0, 0, 0)")
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("ARSesssion failed with error: \(error.localizedDescription)")
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        updateArrowNodePosition() // update ArrowNode's poision per frame
        updateNodeScales()
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("ARSesssion was interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("ARSesssion interruption ended and Restarted")
        session.run(session.configuration!, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor.transform == matrix_identity_float4x4 {
            addNodesWithOffset(anchorNode: node)
        }
        if anchor.name == "dotAnchor" {
            let dotNode = createDotNode(with: anchor)
            node.addChildNode(dotNode)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let currentFrame = arView?.session.currentFrame else { return }
        
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
    
    func convertCoordinates(x: Float, y: Float, z: Float) -> (Float, Float, Float) {
        let scaleFactor: Float = 0.01
        let x_adjusted: Float = x * scaleFactor
        let y_adjusted: Float = z * scaleFactor - 1
        let z_adjusted: Float = -y * scaleFactor
        return (x_adjusted, y_adjusted, z_adjusted)
    }
    
    func addNodesWithOffset(anchorNode: SCNNode) {
        let firstNode = mapNodes.first(where: { $0.name == pathList.first})
        
        let startPosition = SCNVector3(firstNode!.x, firstNode!.z, firstNode!.y)

        for listedNode in pathList {
            if listedNode == firstNode!.name { continue }
            
            if let nodeData = mapNodes.first(where: { $0.name == listedNode }) {
                let nodePosition = SCNVector3(nodeData.x, nodeData.z, nodeData.y)
                
                let relativePosition = SCNVector3(
                    nodePosition.x - startPosition.x,
                    nodePosition.y - startPosition.y,
                    (nodePosition.z - startPosition.z) * -1
                )
                
                let node = SCNNode()
                node.position = relativePosition
                
                let sphere = SCNSphere(radius: 1)
                sphere.firstMaterial?.diffuse.contents = UIColor.blue
                node.geometry = sphere
                node.name = nodeData.name
                dotNodes.append(node)
                anchorNode.addChildNode(node)
                print("node Added: \(relativePosition)")
            } else {
                print("addNodeWithOffset: \(listedNode) not found.")
            }
        }
    }
    
    func updateNodeScales(){
        guard let currentFrame = arView?.session.currentFrame else { return }
        let cameraPosition = SCNVector3(
            currentFrame.camera.transform.columns.3.x,
            currentFrame.camera.transform.columns.3.y,
            currentFrame.camera.transform.columns.3.z
        )
            
        for node in dotNodes{
            let distance = cameraPosition.distance(to: node.position)
            
            // 거리에 비례한 스케일 설정 (너무 커지지 않도록 조정 가능)
            let scaleFactor = max(0.1, 2.0 / distance)
            node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        }
    }

    func createArrowNode() -> SCNNode {
        let shaft = SCNCylinder(radius: 0.03, height: 0.2)
        shaft.firstMaterial?.diffuse.contents = UIColor.red
        let shaftNode = SCNNode(geometry: shaft)
        shaftNode.position = SCNVector3(0, 0, 0)

        let head = SCNCone(topRadius: 0.0, bottomRadius: 0.08, height: 0.15)
        head.firstMaterial?.diffuse.contents = UIColor.red
        let headNode = SCNNode(geometry: head)
        headNode.position = SCNVector3(0, 0.1, 0)

        let arrowNode = SCNNode()
        arrowNode.addChildNode(shaftNode)
        arrowNode.addChildNode(headNode)
        
        
        
        arrowNode.name = "arrowNode"
        
        return arrowNode
    }
    
    func updateArrowNodePosition() {
        guard let currentFrame = arView?.session.currentFrame else { return }
        if dotNodes.isEmpty == false {
            let firstNodePosition = dotNodes[1].position
            
            let cameraPosition = SCNVector3(
                currentFrame.camera.transform.columns.3.x,
                currentFrame.camera.transform.columns.3.y,
                currentFrame.camera.transform.columns.3.z
            )
            
            // 카메라에서 목표 위치까지의 방향 벡터 계산
            let dx = firstNodePosition.x - cameraPosition.x
            
            let dz = firstNodePosition.z - cameraPosition.z
            
            // 각도 계산 (atan2 사용)
            let yaw = atan2(dz, dx)
            
            let cameraTransform = currentFrame.camera.transform
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -1.0
            translation.columns.3.x = 0.5
        
            if let arrowNode = arrowNode {
                arrowNode.simdTransform = simd_mul(cameraTransform, translation)
                //arrowNode.eulerAngles = SCNVector3(0, 0, 0)
                //arrowNode.look(at: SCNVector3(100, 0, 50))

            } else {
                let newArrowNode = createArrowNode()
                arView.scene.rootNode.addChildNode(newArrowNode)
                arrowNode = newArrowNode
                print("arrowNode created and added")
            }
        } else { return }
        
        
    }
    
}

extension SCNVector3 {
    func distance(to vector: SCNVector3) -> Float {
        let dx = self.x - vector.x
        let dy = self.y - vector.y
        let dz = self.z - vector.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }
}
