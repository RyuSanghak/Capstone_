import ARKit
import SceneKit
import SwiftUI
import simd

<<<<<<< HEAD
class ARViewModel: NSObject, ObservableObject, ARSessionDelegate, ARSCNViewDelegate {
    
    @IBOutlet var arView: ARSCNView!
=======
class ARViewModel: NSObject, ObservableObject, ARSessionDelegate, ARSCNViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var arView: ARSCNView!

    var campNaviViewModel: CampusNavigatorViewModel
>>>>>>> sryu
    
    @Published var arConfiguration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()

    var currentNodeIndex: Int = 0  // 현재 노드의 인덱스
    var currentNode: SCNNode?      // 현재 표시되는 노드
    var initialNode: nodes?
    var initialAnchor: ARAnchor?
    var distanceTextNode: SCNNode?
    var scaleFactor: Float = 5.623
    var arMapNodes: [nodes] = []
    var userPathNodeList: [SCNNode] = []
    
<<<<<<< HEAD
    var currentNodeIndex: Int = 0  // 현재 노드의 인덱스
    var currentNode: SCNNode?      // 현재 표시되는 노드
    var initialAnchor: ARAnchor?
    var distanceTextNode: SCNText?
    
    struct MapNode {
        var name: String
        var x: Float  // 가상 좌표계의 x 좌표
        var y: Float  // 가상 좌표계의 y 좌표
    }
    
    
    override init() {
=======
    
    init(campusNavigatorViewModel: CampusNavigatorViewModel) {
        self.campNaviViewModel = campusNavigatorViewModel
>>>>>>> sryu
        super.init()
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        arConfiguration.isLightEstimationEnabled = true
        arConfiguration.worldAlignment = .gravityAndHeading
        arConfiguration.planeDetection = [.horizontal, .vertical]
        arConfiguration.environmentTexturing = .automatic
<<<<<<< HEAD
=======

>>>>>>> sryu
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
    
<<<<<<< HEAD
    func startARSession() {
        configureARSession(for: arView)        // 1. AR 세션 설정
        addInitialWorldAnchor()               // 2. 초기 월드 앵커 추가

        
        
    }
    
    func addInitialWorldAnchor() {
        let anchorTransform = matrix_identity_float4x4
        let worldAnchor = ARAnchor(transform: anchorTransform)
        initialAnchor = worldAnchor
        arView.session.add(anchor: worldAnchor)
        print("World anchor added at (0, 0, 0)")
    }
    
    //  convert virtual 2D coordinate into AR3D coordinates
    func convertVirtual2DToAR3D(x: Float, y: Float) -> SCNVector3 {
        let scaleFactor: Float = 1.0  // 가상 좌표계 단위당 ARKit의 단위 (미터)
        
        // 회전 변환 (필요에 따라 적용)
        let angle = Float.pi / 2  // 90도 회전 예시
        let rotatedX = x * cos(angle) - y * sin(angle)
        let rotatedY = x * sin(angle) + y * cos(angle)
        
        // 이동 변환 (원점 맞춤)
        let originOffset = SCNVector3(0, 0, 0)  // 필요에 따라 설정
        
        // 최종 변환된 좌표
        let arX = rotatedX * scaleFactor + originOffset.x
        let arY = 0.0 + originOffset.y  // 평면 상에 있으므로 y값은 0
        let arZ = rotatedY * scaleFactor + originOffset.z
        
        return SCNVector3(arX, arY, arZ)
=======
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
        
>>>>>>> sryu
    }

    
<<<<<<< HEAD
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
        //updateDistanceText(distance: distance)
        // 특정 거리(예: 0.5미터) 이하로 가까워지면 다음 노드로 업데이트
        if distance < 0.5 {
            currentNodeIndex += 1
        }
    }
    
    func displayTextInFrontOfUser(text: String) {
        // 1. 텍스트 지오메트리 생성
        let textGeometry = SCNText(string: text, extrusionDepth: 0.01)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.white
        textGeometry.font = UIFont.systemFont(ofSize: 1)
        textGeometry.alignmentMode = CATextLayerAlignmentMode.center.rawValue
        textGeometry.truncationMode = CATextLayerTruncationMode.none.rawValue
        textGeometry.isWrapped = true
        textGeometry.flatness = 0.1

        // 2. 텍스트 노드 생성 및 스케일 조정
        let textNode = SCNNode(geometry: textGeometry)
        textNode.scale = SCNVector3(0.1, 0.1, 0.1)

        // 3. 카메라 노드 가져오기
        guard let cameraNode = arView.pointOfView else { return }

        // 4. 텍스트 노드를 카메라 앞에 배치
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -10  // 원하는 거리로 조정 가능
        translation.columns.3.y = -5
        
        let textNodeTransform = simd_mul(cameraNode.simdTransform, translation)
        textNode.simdTransform = textNodeTransform

        // 5. 텍스트 노드가 항상 카메라를 바라보도록 설정
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .all
        textNode.constraints = [billboardConstraint]
        print("Text Node Position: \(textNode.position)")
        // 6. 씬에 텍스트 노드 추가
        arView.scene.rootNode.addChildNode(textNode)
        print("textnode added")
    }


    func updateDistanceText(distance: Float) {
        //guard let distance = getDistanceToNextNode() else { return }

        // 거리를 미터 단위로 표시, 소수점 두 자리까지
        let distanceText = String(format: "%.2f m", distance)

        // 기존 텍스트 노드 제거
        //distanceTextNode?.removeFromParentNode()

        // SCNText 생성
        let textGeometry = SCNText(string: distanceText, extrusionDepth: 0.1)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.white
        textGeometry.font = UIFont.systemFont(ofSize: 1)
        textGeometry.flatness = 0.1

        // 텍스트 노드 생성
        let textNode = SCNNode(geometry: textGeometry)

        // 텍스트 노드의 스케일 조정 (너무 크게 나타나지 않도록)
        let scale: Float = 1
        textNode.scale = SCNVector3(scale, scale, scale)

        // 카메라 앞에 배치
        if let cameraNode = arView.pointOfView {
            // 텍스트를 카메라 앞 0.5미터 지점에 위치
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.3
            let textNodeTransform = simd_mul(cameraNode.simdTransform, translation)
            textNode.simdTransform = textNodeTransform

            // 텍스트가 항상 카메라를 바라보도록 회전 설정
            let billboardConstraint = SCNBillboardConstraint()
            billboardConstraint.freeAxes = .all
            textNode.constraints = [billboardConstraint]
            //print(distance)
            // 씬에 텍스트 노드 추가
            arView.scene.rootNode.addChildNode(textNode)
            //distanceTextNode = textNode
        }
    }

    
    // ARSessionDelegate method
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("ARSession failed with error: \(error.localizedDescription)")
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        //updateNodeScales()
        checkNodeProximity()
    }
    
=======
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
    
>>>>>>> sryu
    func sessionWasInterrupted(_ session: ARSession) {
        print("ARSession was interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("ARSession interruption ended and restarted")
        session.run(arConfiguration, options: [.resetTracking, .removeExistingAnchors])
    }
<<<<<<< HEAD
    
    // 노드의 스케일을 거리와 비례하여 조정하는 함수
=======

>>>>>>> sryu
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
<<<<<<< HEAD
        
        // 거리에 비례한 스케일 설정 (너무 작거나 커지지 않도록 제한)
=======
        //updateDistanceText(distance: distance)
>>>>>>> sryu
        let minScale: Float = 0.05
        let maxScale: Float = 0.3
        let scaleFactor = max(minScale, min(maxScale, 1.0 / distance))
        currentNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
    }
}

<<<<<<< HEAD
// SCNVector3 확장: 거리 계산을 위한 함수
=======
>>>>>>> sryu
extension SCNVector3 {
    func distance(to vector: SCNVector3) -> Float {
        let dx = self.x - vector.x
        let dy = self.y - vector.y
        let dz = self.z - vector.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }
}
