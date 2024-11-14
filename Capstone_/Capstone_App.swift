import SwiftUI
import ARKit

//@main
struct Capstone_App: App {
    @StateObject var mapViewModel = MapViewModel()
    @StateObject var campNaviViewModel = CampusNavigatorViewModel()
    @StateObject var arViewModel: ARViewModel
    
    init() {
            let campNaviVM = CampusNavigatorViewModel()
            _campNaviViewModel = StateObject(wrappedValue: campNaviVM)
            _arViewModel = StateObject(wrappedValue: ARViewModel(campusNavigatorViewModel: campNaviVM))
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
