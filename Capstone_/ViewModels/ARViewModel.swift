import ARKit
import SceneKit
import SwiftUI
import simd

class ARViewModel: NSObject, ObservableObject, ARSessionDelegate, ARSCNViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var arView: ARSCNView!

    var campNaviViewModel: CampusNavigatorViewModel
    
    @Published var arConfiguration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()

    var currentNodeIndex: Int = 0  // 현재 노드의 인덱스
    var currentNode: SCNNode?      // 현재 표시되는 노드
    var initialNode: nodes?
    var initialAnchor: ARAnchor?
    var distanceTextNode: SCNNode?
    var scaleFactor: Float = 5.623
    var arMapNodes: [nodes] = []
    var userPathNodeList: [SCNNode] = []
    
    
    init(campusNavigatorViewModel: CampusNavigatorViewModel) {
        self.campNaviViewModel = campusNavigatorViewModel
        super.init()
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        arConfiguration.isLightEstimationEnabled = true
        arConfiguration.worldAlignment = .gravityAndHeading
        arConfiguration.planeDetection = [.horizontal, .vertical]
        arConfiguration.environmentTexturing = .automatic

    }
    
    func configureARSession(for arView: ARSCNView) {
        self.arView = arView
        arView.delegate = self
        arView.session.delegate = self
        arView.scene = SCNScene()
        
        arView.debugOptions = [
            ARSCNDebugOptions.showFeaturePoints,
            //ARSCNDebugOptions.showWorldOrigin,
            ARSCNDebugOptions.showPhysicsShapes
        ]
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .tracking
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.leadingAnchor.constraint(equalTo: arView.leadingAnchor),
            coachingOverlay.trailingAnchor.constraint(equalTo: arView.trailingAnchor),
            coachingOverlay.topAnchor.constraint(equalTo: arView.topAnchor),
            coachingOverlay.bottomAnchor.constraint(equalTo: arView.bottomAnchor)
        ])
        arView.session.run(arConfiguration)
        
    }
    
    func resetARSession() {
        
        arView.session.pause()
        
        arView.scene.rootNode.enumerateChildNodes { (node, stop) in  // Erase original anchor and node
            node.removeFromParentNode()
        }
        
        if let anchors = arView.session.currentFrame?.anchors {
            for anchor in anchors {
                arView.session.remove(anchor: anchor)
            }
        }
        
        self.currentNodeIndex = 0
        self.currentNode = nil
        self.initialNode = nil
        self.initialAnchor = nil
        self.distanceTextNode = nil
        self.userPathNodeList.removeAll()
        
        //arView.session.run(arConfiguration, options: [.resetTracking, .removeExistingAnchors])
        
        print("reset completed")
        
    }
    
    func startARSession() {
        configureARSession(for: arView)        // setup AR Session
        makeScaleUpNodeList()                  // create UP scale node list: arMapNodes
    }
    
    func startPathFinding() {
        addInitialWorldAnchor()
        self.initialNode = arMapNodes.first(where: { $0.name == pathList.first}) // set the first pathList node as a initial node.
        addAllPathNode()
        addPathPoints()
        
    }
    
    func makeScaleUpNodeList() {
        for node in FHnodes {
            let arNode = nodes(name: node.name, x: scaleFactor * node.x, y: scaleFactor * node.y, z: scaleFactor * node.z)
            arMapNodes.append(arNode)
        }
        
    }
    
    func callNodesData() -> String {
        let buildingName = campNaviViewModel.selectedBuilding
        switch buildingName {
        case "Memorial Field House":
            return "FHnodes"
        case "Rocket Hall":
            return "TestNodes"
        case "Nitschke Hall":
            return "TestNodes"
        default:
            return "[]"
        }
    }
    
    func addInitialWorldAnchor() {
        let position = SCNVector3(0, 0, 0)
        
        var transform = matrix_identity_float4x4
        transform.columns.3.x = position.x
        transform.columns.3.y = position.y
        transform.columns.3.z = position.z
        
        let worldAnchor = ARAnchor(transform: transform)
        initialAnchor = worldAnchor
        arView.session.add(anchor: worldAnchor)
        
        print("World anchor added at position \(position)")
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
                node.position.y = 0.0
                
                let sphere = SCNSphere(radius: 0.1)
                sphere.firstMaterial?.diffuse.contents = UIColor.blue
                node.geometry = sphere
                node.isHidden = true
                
                arView.scene.rootNode.addChildNode(node)
                
                userPathNodeList.append(node)
                
                if node.name == initialNode.name {
                    currentNode = node
                }
            }
        }
        
    }

    
    func manageNodeVisibility() {
        guard let currentNode = currentNode else { return }
        for node in userPathNodeList {
            if currentNode.name == node.name {
                currentNode.isHidden = false
            } else {
                node.isHidden = true
            }
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
            let pointPosition = SCNVector3(0, -yOffset, 0)
    
            let sphereGeometry = SCNSphere(radius: 0.01)
            sphereGeometry.firstMaterial?.diffuse.contents = UIColor.red
            
            let sphereNode = SCNNode(geometry: sphereGeometry)
            sphereNode.position = pointPosition
            
            targetNode.addChildNode(sphereNode)
        }
        
        let platformWidth: CGFloat = 0.2
        let platformHeight: CGFloat = 0.02
        let platformDepth: CGFloat = 0.2
        let platformYOffset: Float = 1.2 // distance between from node to below

        let platformGeometry = SCNBox(width: platformWidth, height: platformHeight, length: platformDepth, chamferRadius: 0)
        platformGeometry.firstMaterial?.diffuse.contents = UIColor.gray
        
        let platformNode = SCNNode(geometry: platformGeometry)
        platformNode.position = SCNVector3(0, -platformYOffset, 0)
    
        targetNode.addChildNode(platformNode)
    }
    
    func addPathPoints() {
        guard let targetNode = currentNode else { return }
        
        let spacing: Float = 0.1
        
        for node in userPathNodeList {
            let fromNode = node
            
            if node == userPathNodeList.last { return }
            
            let toNode = userPathNodeList[userPathNodeList.firstIndex(of: node)! + 1]
            
            let fromNodePosition = SCNVector3(fromNode.position.x, fromNode.position.y - 1, fromNode.position.z)
            let toNodePosition = SCNVector3(toNode.position.x, toNode.position.y - 1, toNode.position.z)
            
            let direction = SCNVector3(
                toNodePosition.x - fromNodePosition.x,
                toNodePosition.y - fromNodePosition.y,
                toNodePosition.z - fromNodePosition.z
            )
            
            let distance = sqrt(pow(direction.x, 2) + pow(direction.y, 2) + pow(direction.z, 2))
            
            var currentPosition = fromNodePosition
            
            let step = SCNVector3(
                direction.x / distance * spacing,
                direction.y / distance * spacing,
                direction.z / distance * spacing
            )
            
            for _ in stride(from: 0, to: distance, by: spacing) {
                let sphereGeometry = SCNSphere(radius: 0.01)
                sphereGeometry.firstMaterial?.diffuse.contents = UIColor.red
                let sphereNode = SCNNode(geometry: sphereGeometry)
                sphereNode.position = currentPosition
                arView.scene.rootNode.addChildNode(sphereNode)
                
                // 다음 위치로 이동
                currentPosition = SCNVector3(
                    currentPosition.x + step.x,
                    currentPosition.y + step.y,
                    currentPosition.z + step.z
                )
            }
            
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
            if currentNode == userPathNodeList.last {
                print("User has reached the end of the path.")
            }
            if let nextNodeIndex = pathList.firstIndex(of: currentNode.name!), nextNodeIndex + 1 < pathList.count {
                //deletePointsBelowNode()
                self.currentNode = userPathNodeList[nextNodeIndex+1]
                addPointsBelowNode()
                print("Next Node: \(self.currentNode?.name ?? "")")
            }
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
        manageNodeVisibility()
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
