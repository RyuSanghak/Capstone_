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
    @State private var selectedRoom: String?


    
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
    
    var filteredRooms: [String] {
        switch selectedBuilding {
        case "Memorial Field House":
            return FH1F
        case "Engineering":
            return engineeringBuildings
        case "MainCampus":
            return mainCampusBuildings
        default:
            return ["hi"]
        }
    }
    
    
    var body: some View {
        VStack(spacing: 16){
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
            
            DropDownView(title: "Rooms",
                         prompt: "Select",
                         options: filteredRooms,
                         maxHeight: 200,
                         selection: $selectedRoom)
        }
    }

}

#Preview {
    CampusNavigatorView()
}
