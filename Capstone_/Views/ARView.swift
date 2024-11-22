import SwiftUI
import ARKit
import SceneKit

struct ARView: View {
    @EnvironmentObject var viewModel: ARViewModel
    var body: some View {
        NavigationView {
            if viewModel.isSessionStarted {
                VStack {
                    ARViewContainer(viewModel: viewModel)
                        .edgesIgnoringSafeArea(.all)
                    Button(action: {
                        viewModel.rootMoveleft() // 세션 시작 상태를 표시하기 위한 변수
                    }) {
                        Text("left")
                            .font(.title)
                    }
                    .padding()
                    Button(action: {
                        viewModel.rootMoveright() // 세션 시작 상태를 표시하기 위한 변수
                    }) {
                        Text("right")
                            .font(.title)
                    }
                    .padding()
                }
                .onAppear() {
                    viewModel.startARSession()
                    viewModel.startPathFinding()
                }
                .onDisappear() {
                    viewModel.isSessionStarted = false
                    viewModel.resetARSession()
                }
            } else {
                CompassView()
                    .environmentObject(viewModel)
            }
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
