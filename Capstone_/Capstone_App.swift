
import SwiftUI
import ARKit

@main
struct Capstone_App: App {
    @StateObject var mapViewModel = MapViewModel()
    @StateObject var arViewModel = ARViewModel()
    @StateObject var campNaviViewModel = CampusNavigatorViewModel()
    
    var body: some Scene {
        WindowGroup {
            CampusNavigatorView()
                .environmentObject(mapViewModel)
                .environmentObject(arViewModel)
                .environmentObject(campNaviViewModel)
        }
    }
}
