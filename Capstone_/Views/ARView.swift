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
                viewModel.startPathFinding()
            }) {
                Text("set initial position")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onAppear() {
            viewModel.startARSession()
        }
        .onDisappear() {
            viewModel.resetARSession()
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
