
import SwiftUI
import ARKit

@main
struct Capstone_App: App {
    @StateObject var mapViewModel = MapViewModel()
    @StateObject var arViewModel = ARViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mapViewModel)
                .environmentObject(arViewModel)
        }
    }
}
