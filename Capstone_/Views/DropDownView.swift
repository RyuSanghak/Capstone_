//
//  SearchView.swift
//  Capstone_
//
//  Created by Seokhyun Hong on 9/25/24.
//

import SwiftUI

struct DropDownView: View {
    let title: String
    let prompt: String
    let options: [String]
    let maxHeight: CGFloat
    
    @State private var isExpanded = false
    
    @Binding var selection: String?
    
    @Environment(\.colorScheme) var scheme
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.footnote)
                .foregroundStyle(.gray)
                .opacity(0.8)
            VStack {
                HStack {
                    Text(selection ?? prompt)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        //rotate icon
                        .rotationEffect(.degrees(isExpanded ? -180 : 0))
                }
                .frame(height: 40)
                .background(scheme == .dark ? .black : .white)
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation(.snappy) {isExpanded.toggle()}
                }
                if isExpanded {
                    ScrollView {
                        VStack{
                            ForEach(options, id: \.self) { option in
                                HStack {
                                    Text(option)
                                        .foregroundStyle(selection == option ? Color.primary : .gray)
                                    
                                    Spacer()
                                    
                                    if selection == option {
                                        Image(systemName: "checkmark")
                                            .font(.subheadline)
                                    }
                                }
                                .frame(height: 40)
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation(.snappy){
                                        selection = option
                                        isExpanded.toggle()
                                    }
                                }
                            }
                        }
                        .transition(.move(edge: .bottom))
                    }
                    .frame( maxHeight: maxHeight )
                }
            }
            .background(scheme == .dark ? .black : .white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .primary.opacity(0.2), radius: 4)
            .frame(width: 200)

        }
    }
}


