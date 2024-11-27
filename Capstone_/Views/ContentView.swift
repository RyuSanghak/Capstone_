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
                
                if mapViewModel.mapFound {
                    Text("Floor 1")
                            .foregroundColor(.black) // 텍스트 색상
                            .background(Color.white) // 배경 색상 (항상 흰색)
                } else {
                    Text("Floor 2")
                        .foregroundColor(.black) // 텍스트 색상
                        .background(Color.white) // 다크모드에서도 배경을 하얀색으로 고정
                }
                   
                MapView() // navigate to MapView
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.3)
                    .transition(.opacity)
                    .environmentObject(mapViewModel)
                
            }
            .background(Color.white)
        }
        
    }
        //.animation(.easeInOut(duration: 1), value: isActive)
}



