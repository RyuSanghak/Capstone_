import SwiftUI
import ARKit

@main
struct Capstone_App: App {
    @StateObject var mapViewModel = MapViewModel()
<<<<<<< HEAD
    @StateObject var arViewModel = ARViewModel()
    @StateObject var campNaviViewModel = CampusNavigatorViewModel()
=======
    @StateObject var campNaviViewModel = CampusNavigatorViewModel()
    @StateObject var arViewModel: ARViewModel
    
    init() {
            let campNaviVM = CampusNavigatorViewModel()
            _campNaviViewModel = StateObject(wrappedValue: campNaviVM)
            _arViewModel = StateObject(wrappedValue: ARViewModel(campusNavigatorViewModel: campNaviVM))
        }
>>>>>>> sryu
    
    var body: some Scene {
        WindowGroup {
            CampusNavigatorView()
                .environmentObject(mapViewModel)
                .environmentObject(arViewModel)
                .environmentObject(campNaviViewModel)
        }
    }
}
