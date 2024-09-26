//
//  Capstone_App.swift
//  Capstone_
//
//  Created by Sanghak Ryu on 9/25/24.
//

import SwiftUI

@main
struct Capstone_App: App {
    @StateObject var mapViewModel = MapViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mapViewModel)
        }
    }
}
