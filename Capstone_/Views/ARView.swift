import SwiftUI
import ARKit
import SceneKit

struct ARView: View {
    @ObservedObject var viewModel: ARViewModel
    
    var body: some View {
        VStack {
            ARViewContainer(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                // 사용자의 앞에 점 추가
                if let arView = viewModel.arView,
                   let currentFrame = arView.session.currentFrame {

                    var translation = matrix_identity_float4x4
                    for i in 0..<20 {
                        // 카메라의 현재 위치를 가져와 50cm 앞에 점을 추가
                        //var translation = matrix_identity_float4x4
                        translation.columns.3.z = -1.0 - Float(i)// 카메라 앞 50cm
                        translation.columns.3.y = 2
                        translation.columns.3.x = 2
                        let transform = simd_mul(currentFrame.camera.transform, translation)

                        // 새로운 앵커를 생성하여 AR 세션에 추가
                        let dotAnchor = ARAnchor(transform: transform)
                        arView.session.add(anchor: dotAnchor)
                    }
                    for i in 0..<5 {
                        // 카메라의 현재 위치를 가져와 50cm 앞에 점을 추가
                        //var translation = matrix_identity_float4x4
                        //translation.columns.3.z = -1.0
                        translation.columns.3.y = 2.0 - Float(i)
                        translation.columns.3.x = 2.0 + Float(i)
                        let transform = simd_mul(currentFrame.camera.transform, translation)

                        // 새로운 앵커를 생성하여 AR 세션에 추가
                        let dotAnchor = ARAnchor(transform: transform)
                        arView.session.add(anchor: dotAnchor)
                    }
                    
                }
            }) {
                Text("Place Object")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .onAppear(){
                findPath()
            }
            //.padding(.bottom, 50)

            
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        viewModel.configureARSession(for: arView)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
}
