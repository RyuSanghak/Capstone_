//
//  CampusNavigatorView.swift
//  Capstone_
//
//  Created by Sanghak Ryu on 9/26/24.
//

import SwiftUI

struct CampusNavigatorView: View {
    
    @State private var selectedCampus : String? = "MainCampus"
    @State private var selectedBuilding: String?
    @State private var startRoom: String?
    @State private var endRoom: String?
    @State private var path = NavigationPath()
    @State private var isSplashActive = false
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var arViewModel: ARViewModel
    @State private var isPressed = false
    
    var filteredBuildings: [String] {
        switch selectedCampus {
        case "HealthScience":
            return healthScienceBuildings
        case "Engineering":
            return engineeringBuildings
        case "MainCampus":
            return mainCampusBuildings
        default:
            return []
        }
    }
    
    var startRooms: [String] {
        switch selectedBuilding {
        case "Memorial Field House":
            return FH_START
        case "Engineering":
            return engineeringBuildings
        case "MainCampus":
            return mainCampusBuildings
        default:
            return ["Please Select Building First"]
        }
    }
    
    var endRooms: [String] {
        switch selectedBuilding {
        case "Memorial Field House":
            return FH_END
        case "Engineering":
            return engineeringBuildings
        case "MainCampus":
            return mainCampusBuildings
        default:
            return ["Please Select Building First"]
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16){
                if isSplashActive {
                    
                     DropDownView(title: "Campus",
                     prompt: "Select",
                     options: campus,
                     maxHeight: 140,
                     selection: $selectedCampus)
                     
                     DropDownView(title: "Buildings",
                     prompt: "Select",
                     options: filteredBuildings,
                     maxHeight: 200,
                     selection: $selectedBuilding)
                     
                     DropDownView(title: "Start Rooms",
                     prompt: "Select",
                     options: startRooms,
                     maxHeight: 200,
                     selection: $startRoom)
                     
                     DropDownView(title: "End Rooms",
                     prompt: "Select",
                     options: endRooms,
                     maxHeight: 200,
                     selection: $endRoom)
                     
                    NavigationLink(destination: ContentView()){
                        Text("next")
                            .padding()
                            .background(.regularMaterial)
                            .colorScheme(.dark)
                            .cornerRadius(12)
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                    }
                    .environmentObject(mapViewModel)
                    .environmentObject(arViewModel)
                } else {
                    SplashView()
                }
                
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 1)) {
                        isSplashActive = true
                    }
                }
            }
        }
    }
}

