import ARKit
import SceneKit
import SwiftUI

class ARViewModel: NSObject, ObservableObject, ARSessionDelegate, ARSCNViewDelegate {
    
    @IBOutlet var arView: ARSCNView!
    
    @Published var arConfiguration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    
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
        arView.session.run(arConfiguration)
    }
    
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
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("ARSession was interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("ARSession interruption ended and restarted")
        session.run(arConfiguration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // 노드의 스케일을 거리와 비례하여 조정하는 함수
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
        
        // 거리에 비례한 스케일 설정 (너무 작거나 커지지 않도록 제한)
        let minScale: Float = 0.05
        let maxScale: Float = 0.3
        let scaleFactor = max(minScale, min(maxScale, 1.0 / distance))
        currentNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
    }
}

// SCNVector3 확장: 거리 계산을 위한 함수
extension SCNVector3 {
    func distance(to vector: SCNVector3) -> Float {
        let dx = self.x - vector.x
        let dy = self.y - vector.y
        let dz = self.z - vector.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }
}
