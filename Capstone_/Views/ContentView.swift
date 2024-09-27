// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var isSplashActive = false
    @EnvironmentObject var mapViewModel: MapViewModel

    var body: some View {
        ZStack {
            if isSplashActive {
                VStack{
                    //CampusNavigatorView()
                    
                    
                    MapView(mapViewModel: mapViewModel) // navigate to MapView
                        .transition(.opacity)
                    
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

#Preview {
    ContentView()
}

