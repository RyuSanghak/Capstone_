import SwiftUI
import ARKit

@main
struct Capstone_App: App {
    @StateObject var mapViewModel = MapViewModel()
    @StateObject var campNaviViewModel = CampusNavigatorViewModel()
    @StateObject var arViewModel: ARViewModel
    
    init() {
        let campNaviVM = CampusNavigatorViewModel()
        let mapVM = MapViewModel()
        _campNaviViewModel = StateObject(wrappedValue: campNaviVM)
        _mapViewModel = StateObject(wrappedValue: mapVM)
        _arViewModel = StateObject(wrappedValue: ARViewModel(campusNavigatorViewModel: campNaviVM, mapViewModel: mapVM))
    }
    
    var body: some Scene {
        WindowGroup {
            CampusNavigatorView()
                .environmentObject(mapViewModel)
                .environmentObject(arViewModel)
                .environmentObject(campNaviViewModel)
        }
    }
}
