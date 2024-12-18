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
