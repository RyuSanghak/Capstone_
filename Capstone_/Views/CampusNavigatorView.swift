//
//  CampusNavigatorView.swift
//  Capstone_
//
//  Created by Sanghak Ryu on 9/26/24.
//

import SwiftUI

struct CampusNavigatorView: View {
    private let campus = [
            "MainCampus",
            "Engineering",
            "HealthScience"
            ]

    private let mainCampusBuildings = [
            "Student Union",
            "Carlson Library",
            "University Hall",
            "Memorial Field House",
            "Savage Arena",
            "Rocket Hall",
            "Honors Academic Village",
            "Gillham Hall",
            "Bowman-Oddy Laboratories",
            "Wolfe Hall",
            "Stranahan Hall",
            "Fetterman Training Center",
            "Health and Human Services Building",
            "Center for Performing Arts",
            ]
        
    private let engineeringBuildings = [
            "North Engineering",
            "Nitschke Hall"
            ]

    private let healthScienceBuildings = [
            "UT Medical Center",
            "Mulford Library",
            "Health Education Building",
            "Center for Creative Education",
            "Block Health Science Building",
            "Kobacker Center"
            ]
    
    @State private var selectedCampus : String? = "MainCampus"
    @State private var selectedBuilding: String?

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
        }
    }

}

#Preview {
    CampusNavigatorView()
}
