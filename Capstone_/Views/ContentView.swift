// ContentView.swift
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var arViewModel: ARViewModel
    @ObservedObject var headingProvider = HeadingProvider()

    var body: some View {
        ZStack {
            
            VStack{
                
                ARView()
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.7)
                    .environmentObject(arViewModel)
                
                MapView() // navigate to MapView
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.3)
                    .transition(.opacity)
                    .environmentObject(mapViewModel)
                
            }
        }
        
    }
        //.animation(.easeInOut(duration: 1), value: isActive)
}



