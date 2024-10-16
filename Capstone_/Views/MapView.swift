//
//  MapView.swift
//  Capstone_
//
//  Created by Sanghak Ryu on 9/25/24.
//

import SwiftUI
import SceneKit

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel

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
    }
}


