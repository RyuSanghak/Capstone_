// Views/SplashView.swift
import SwiftUI

struct SplashView: View {
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                Image("Capstone_Logo") // 프로젝트의 Assets에 있는 이미지 이름
                    .resizable()
                    .cornerRadius(30)
                    .aspectRatio(contentMode: .fit)
                    .padding(.all)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 0.8)) {
                    self.size = 0.9
                    self.opacity = 1.0
                }
            }
        }
    }
}
