// ContentView.swift
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var arViewModel: ARViewModel
    @ObservedObject var headingProvider = HeadingProvider()

    var body: some View {
        ZStack {
            
            VStack{
                
                ARView(viewModel: arViewModel)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.7)
                
                MapView(viewModel: mapViewModel) // navigate to MapView
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.3)
                    .transition(.opacity)
                
            }
        }
        
    }
        //.animation(.easeInOut(duration: 1), value: isActive)
}



