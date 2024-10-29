import SwiftUI
import ARKit
import SceneKit

struct ARView: View {
    @ObservedObject var viewModel: ARViewModel
    var body: some View {
        VStack {
            ARViewContainer(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
            /*
            Button(action: {
                viewModel.setInitialPosition()
            }) {
                Text("set initial position")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: {
                viewModel.calculateDistance()
            }) {
                Text("check distance")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            //.padding(.bottom, 50)

            */
        }
        .onAppear(){
            findPath(buildingName: "asef", start: "3", end: "39")
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
