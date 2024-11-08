import ARKit
import SceneKit
import SwiftUI
import simd

class ARViewModel: NSObject, ObservableObject, ARSessionDelegate, ARSCNViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var arView: ARSCNView!
    
    @Published var arConfiguration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    
    var currentNodeIndex: Int = 0  // 현재 노드의 인덱스
    var currentNode: SCNNode?      // 현재 표시되는 노드
    var initialNode: nodes?
    var initialAnchor: ARAnchor?
    var distanceTextNode: SCNNode?
    var lineNode: SCNNode?
    var scaleFactor: Float = 5.623
    var arMapNodes: [nodes] = []
    
    
    let globalRotationDegrees: Float = 100.0
    
    override init() {
        super.init()
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        arConfiguration.isLightEstimationEnabled = true
        arConfiguration.worldAlignment = .gravityAndHeading
        //arConfiguration.planeDetection = [.horizontal, .vertical]

    }
    
    func configureARSession(for arView: ARSCNView) {
        self.arView = arView
        arView.delegate = self
        arView.session.delegate = self
        arView.scene = SCNScene()
        arView.session.run(arConfiguration)
    }
    
    func startARSession() {
        configureARSession(for: arView)        // setup AR Session
        addInitialWorldAnchor()
        makeScaleUpNodeList()                  // create UP scale node list: arMapNodes
    }
    
    func startPathFinding() {
        self.initialNode = arMapNodes.first(where: { $0.name == pathList.first})
        addAllPathNode()
        
    }
    
    func makeScaleUpNodeList() {
        for node in mapNodes {
            let arNode = nodes(name: node.name, x: scaleFactor * node.x, y: scaleFactor * node.y, z: scaleFactor * node.z)
            arMapNodes.append(arNode)
        }
        
    }
    
    func addInitialWorldAnchor() {
        // 원하는 위치 설정 (예: 원점)
        let position = SCNVector3(0, 0, 0)
        
        // Yaw 회전 행렬 생성
        let rotation = rotationMatrix(yawDegrees: globalRotationDegrees)
        
        // 변환 행렬 설정
        var transform = matrix_identity_float4x4
        transform.columns.3.x = position.x
        transform.columns.3.y = position.y
        transform.columns.3.z = position.z
        transform = matrix_multiply(transform, rotation)
        
        let worldAnchor = ARAnchor(transform: transform)
        initialAnchor = worldAnchor
        arView.session.add(anchor: worldAnchor)
        
        print("World anchor added with rotation of \(globalRotationDegrees) degrees at position \(position)")
    }
    
    func rotationMatrix(yawDegrees: Float) -> simd_float4x4 {
        let yawRadians = yawDegrees * Float.pi / 180.0
        var matrix = matrix_identity_float4x4
        matrix.columns.0.x = cos(yawRadians)
        matrix.columns.0.z = sin(yawRadians)
        matrix.columns.2.x = -sin(yawRadians)
        matrix.columns.2.z = cos(yawRadians)
        return matrix
    }
    
    //  convert virtual 2D coordinate into AR3D coordinates
    func convertVirtual2DToAR3D(x: Float, y: Float) -> SCNVector3 {
        let scaleFactor: Float = 1  // 가상 좌표계 단위당 ARKit의 단위 (미터)
       
        let originOffset = SCNVector3(0, 0, 0)  // 필요에 따라 설정
        
        let arX = x * scaleFactor + originOffset.x
        let arY = 0.0 + originOffset.y  // 평면 상에 있으므로 y값은 0
        let arZ = -y * scaleFactor + originOffset.z
        
        return SCNVector3(arX, arY, arZ)
    }
    
    func addAllPathNode() {
        guard let initialNode = initialNode else { print("Couldn't find initial node"); return }
        
        for pathNodeName in pathList {
            if let pathNodeData = arMapNodes.first(where: { $0.name == pathNodeName }) {
                let relativeX = pathNodeData.x - initialNode.x
                let relativeY = 0.0
                let relativeZ = -(pathNodeData.y - initialNode.y)
                
                let node = SCNNode()
                node.name = pathNodeData.name
                node.position = SCNVector3(relativeX, Float(relativeY), relativeZ)
                node.position.y = 0.1
                
                let sphere = SCNSphere(radius: 0.1)
                sphere.firstMaterial?.diffuse.contents = UIColor.blue
                node.geometry = sphere
                node.isHidden = false
                
                if pathNodeData.name == "f1n19" {
                    currentNode = node
                }
                arView.scene.rootNode.addChildNode(node)
                print(node.position)
            }
        }
        
    }
    
    func manageNodeVisibility() {
        for pathNodeName in pathList {
            
        }
    }
    
    func addNextNode() {
        if currentNode != nil {
            currentNode?.removeFromParentNode()
        }
        
        if currentNodeIndex < pathList.count {
            let nodeName = pathList[currentNodeIndex]
            if let nodeData = mapNodes.first(where: { $0.name == nodeName }) {
                
                // 첫 번째 노드인 경우
                if currentNodeIndex == 0 {
                    initialNode = nodeData
                    // 첫 번째 노드를 원점(0,0,0)에 배치
                    let nodePosition = SCNVector3(0, 0, 0)
                    //initialNodePosition = nodePosition  // 필요하다면 저장
                    
                    let node = SCNNode()
                    node.position = nodePosition
                    let sphere = SCNSphere(radius: 0.11)
                    sphere.firstMaterial?.diffuse.contents = UIColor.blue
                    node.geometry = sphere
                    node.name = nodeData.name
                    
                    arView.scene.rootNode.addChildNode(node)
                    currentNodeIndex += 1
                    print("First node added at user's position")
                } else {
                    // 다른 노드인 경우, 첫 번째 노드에 상대적인 위치 계산
                    let previousNodePosition = currentNode?.position ?? SCNVector3(0, 0, 0)
                    let offset = convertVirtual2DToAR3D(x: nodeData.x, y: nodeData.y)
                    let nodePosition = SCNVector3(
                        -initialNode!.x + offset.x,
                         -initialNode!.y + offset.y,
                         -initialNode!.z + offset.z
                    )
                    print("offset: ")
                    
                    let node = SCNNode()
                    node.position = nodePosition
                    let sphere = SCNSphere(radius: 0.11)
                    sphere.firstMaterial?.diffuse.contents = UIColor.blue
                    node.geometry = sphere
                    node.name = nodeData.name
                    arView.scene.rootNode.addChildNode(node)
                    currentNode = node
                    currentNodeIndex += 1
                    print("Node added: \(node.name ?? "") at position \(node.position)")
                }
                
            } else {
                print("Node \(nodeName) not found in mapNodes.")
            }
        } else {
            print("Arrived at the end of the path.")
        }
    }

    
    func addSpawnNode(){
        let targetNode = currentNode!
        let radius: CGFloat = 2
        let height: CGFloat = 0.1
        let circleGeometry = SCNCylinder(radius: radius, height: height)
        
        circleGeometry.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.5)
        circleGeometry.firstMaterial?.isDoubleSided = true
        
        let cylinderNode = SCNNode(geometry: circleGeometry)
        cylinderNode.position = SCNVector3(targetNode.position.x, targetNode.position.y - 5, targetNode.position.z)
        
        print(cylinderNode.position)
        //cylinderNode.eulerAngles.x = -.pi / 2
        targetNode.addChildNode(cylinderNode)
        cylinderNode.position = SCNVector3(0, -10, 0)
        
        
    }
    
    func addPointsBelowNode() {
        guard let targetNode = currentNode else { return }
        
        let numberOfPoints = 10
        let spacing: Float = 0.1 // space between each point
        
        for i in 1...numberOfPoints {
            let yOffset = Float(i) * spacing
            let pointPosition = SCNVector3(
                targetNode.position.x,
                targetNode.position.y - yOffset,
                targetNode.position.z
            )
    
            let sphereGeometry = SCNSphere(radius: 0.01)
            sphereGeometry.firstMaterial?.diffuse.contents = UIColor.red
            
            let sphereNode = SCNNode(geometry: sphereGeometry)
            sphereNode.position = pointPosition
            
            arView.scene.rootNode.addChildNode(sphereNode)
        }
    }
    
    func addPointDirectionNode() {
        guard let targetNode = currentNode else { return }
        guard let currentFrame = arView?.session.currentFrame else { return }
        
        let numberofPoints = 10
        let spacing: Float = 0.1
        
        let cameraPosition = SCNVector3(
            currentFrame.camera.transform.columns.3.x,
            currentFrame.camera.transform.columns.3.y,
            currentFrame.camera.transform.columns.3.z
        )
        
        while(true) {
            
        }
        
    }


    func lineBetweenNodes(positionA: SCNVector3, positionB: SCNVector3) -> SCNNode {
        let vertices: [SCNVector3] = [positionA, positionB]
        let source = SCNGeometrySource(vertices: vertices)
        let indices: [UInt32] = [0, 1]
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        let geometry = SCNGeometry(sources: [source], elements: [element])
        geometry.firstMaterial?.diffuse.contents = UIColor.green
        let node = SCNNode(geometry: geometry)
        return node
    }

    // check if the user is closed enough to the node
    func checkNodeProximity() {
        guard let currentNode = currentNode else { return }
        guard let currentFrame = arView?.session.currentFrame else { return }
        
        let cameraPosition = SCNVector3(
            currentFrame.camera.transform.columns.3.x,
            currentFrame.camera.transform.columns.3.y,
            currentFrame.camera.transform.columns.3.z
        )
        
        let nodePosition = currentNode.worldPosition
        
        let distance = cameraPosition.distance(to: nodePosition)
        
        updateDistanceText(distance: distance) // showing distance data to user.
        
        if distance < 0.5 {
            currentNodeIndex += 1
            addNextNode()
        }
    }


    func updateDistanceText(distance: Float) {
        //guard let distance = getDistanceToNextNode() else { return }
        
        let distanceText = String(format: "%.2f m", distance)

        if let textGeometry = distanceTextNode?.geometry as? SCNText {
            textGeometry.string = distanceText
        } else {
            
            let textGeometry = SCNText(string: distanceText, extrusionDepth: 0.1)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.white
            textGeometry.font = UIFont.systemFont(ofSize: 1)
            textGeometry.flatness = 0.1
            
            distanceTextNode = SCNNode(geometry: textGeometry)
            
            let scale: Float = 0.1
            distanceTextNode?.scale = SCNVector3(scale, scale, scale)
            
            arView.scene.rootNode.addChildNode(distanceTextNode!)
        }
        
        // place the text in front of the camera
        if let cameraNode = arView.pointOfView {
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -10
            translation.columns.3.y = -5
            let textNodeTransform = simd_mul(cameraNode.simdTransform, translation)
            distanceTextNode?.simdTransform = textNodeTransform

            // set the text always look at user.
            let billboardConstraint = SCNBillboardConstraint()
            billboardConstraint.freeAxes = .all
            distanceTextNode?.constraints = [billboardConstraint]
        }
    }

    
    // ARSessionDelegate method
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("ARSession failed with error: \(error.localizedDescription)")
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        checkNodeProximity()
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("ARSession was interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("ARSession interruption ended and restarted")
        session.run(arConfiguration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func updateNodeScales(){
        guard let currentNode = currentNode else { return }
        guard let currentFrame = arView?.session.currentFrame else { return }
        
        let cameraPosition = SCNVector3(
            currentFrame.camera.transform.columns.3.x,
            currentFrame.camera.transform.columns.3.y,
            currentFrame.camera.transform.columns.3.z
        )
        
        let nodePosition = currentNode.worldPosition
        
        let distance = cameraPosition.distance(to: nodePosition)
        //updateDistanceText(distance: distance)
        let minScale: Float = 0.05
        let maxScale: Float = 0.3
        let scaleFactor = max(minScale, min(maxScale, 1.0 / distance))
        currentNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
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
