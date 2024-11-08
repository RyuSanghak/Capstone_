import SwiftUI


struct CampusNavigatorView: View {
    @EnvironmentObject var viewModel: CampusNavigatorViewModel
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var arViewModel: ARViewModel
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if viewModel.isSplashActive {
                    
                    DropDownView(
                        title: "Campus",
                        prompt: "Select",
                        options: campus,
                        maxHeight: 140,
                        selection: $viewModel.selectedCampus
                    )
                    
                    DropDownView(
                        title: "Buildings",
                        prompt: "Select",
                        options: viewModel.filteredBuildings,
                        maxHeight: 200,
                        selection: $viewModel.selectedBuilding
                    )
                    
                    DropDownView(
                        title: "Start Rooms",
                        prompt: "Select",
                        options: viewModel.startRooms,
                        maxHeight: 200,
                        selection: $viewModel.startInput
                    )
                    
                    DropDownView(
                        title: "End Rooms",
                        prompt: "Select",
                        options: viewModel.endRooms,
                        maxHeight: 200,
                        selection: $viewModel.endInput
                    )
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Next")
                            .padding()
                            .background(.regularMaterial)
                            .colorScheme(.dark)
                            .cornerRadius(12)
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                    }
                    .environmentObject(mapViewModel)
                    .environmentObject(arViewModel)
                    .simultaneousGesture(TapGesture().onEnded {
                        // Ensure non-optional values are passed to findPath
                        guard let startInput = viewModel.startInput, let endInput = viewModel.endInput, let selectedBuilding = viewModel.selectedBuilding else {
                            print("Start or End input is missing")

                            return
                        }
                        
                        
                        findPath(buildingName: selectedBuilding, start: startInput, end: endInput)
                 
                    })
                } else {
                    SplashView()
                }
            }
            .onAppear {
                viewModel.activateSplash()
            }
        }
    }
}
