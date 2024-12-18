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
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
                    .disabled(!viewModel.isNavigationEnabled) // 비활성화 상태
                    .tint(viewModel.isNavigationEnabled ? .blue : .gray) // 활성화 시 파란색, 비활성화 시 회색
                    .animation(.easeInOut(duration: 0.3), value: viewModel.isNavigationEnabled)
                    .environmentObject(mapViewModel)
                    .environmentObject(arViewModel)
                    
                    .simultaneousGesture(TapGesture().onEnded {
                        // Ensure non-optional values are passed to findPath
                        guard let startInput = viewModel.startInput, let endInput = viewModel.endInput, let selectedBuilding = viewModel.selectedBuilding else {
                            print("Start or End input is missing")

                            return
                        }
                        findPath(buildingName: selectedBuilding, start: startInput, end: endInput)
                        mapViewModel.loadMaps(buildingName: viewModel.getBuildingName())
                        mapViewModel.loadScene()
                        
                 
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
