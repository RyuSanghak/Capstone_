//
//  MapView.swift
//  Capstone_
//
//  Created by Sanghak Ryu on 9/25/24.
//

import SwiftUI
import SceneKit

struct MapView: View {
    @EnvironmentObject var viewModel: MapViewModel

    var body: some View {
        VStack{
            if let scene = viewModel.scene {
                SceneView(
                    scene: scene,
                    options: [.allowsCameraControl , .autoenablesDefaultLighting]
                )
                .edgesIgnoringSafeArea(.all)
            } else {
                Text("Loading scene...")
            }
        }
        // Button to move to the next node
        Button(action: {
            // Trigger nextNodeButtonPressed() in the ViewModel
            viewModel.nextNodeButtonPressed()
        }) {
            Text("Next Node")
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .onAppear(){
        }
    }
}


