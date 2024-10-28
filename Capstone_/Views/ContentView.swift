// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var isSplashActive = false
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var arViewModel: ARViewModel

    var body: some View {
        ZStack {
            if isSplashActive {
                VStack{
                   
//                    CampusNavigatorView()
                    
                    ARView(viewModel: arViewModel)
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.7)
                    
                    MapView(viewModel: mapViewModel) // navigate to MapView floor 1
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.3)
                        .transition(.opacity)
                    
//                        MapView(viewModel: mapViewModel2) // navigate to MapView floor2
//                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.3)
//                        .transition(.opacity)
                    
                }
                
            } else {
                // SplashView
                SplashView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 1)) {
                    isSplashActive = true
                }
            }
        }
    }
        //.animation(.easeInOut(duration: 1), value: isActive)
}



