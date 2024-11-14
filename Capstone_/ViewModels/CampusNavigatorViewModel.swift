import SwiftUI
import Combine

class CampusNavigatorViewModel: ObservableObject {
    @Published var selectedCampus: String? = "MainCampus"
    @Published var selectedBuilding: String?
    @Published var startInput: String?
    @Published var endInput: String?
    @Published var isSplashActive = false
    @Published var path = NavigationPath()

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

    func activateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 1)) {
                self.isSplashActive = true
            }
        }
    }
    
    func getBuildingName() -> String {
        return selectedBuilding ?? " "
    }
}

