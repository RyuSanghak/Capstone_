//
//
//  Created by Seokhyun Hong on 9/25/24.
//

import SwiftUI
 
struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive{
            ContentView()
        } else{
           
            ZStack{
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    Image("Capstone_Logo")
                        .resizable()
                        .cornerRadius(30)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                        .padding(.all)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.8)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

