import SwiftUI

struct CompassView: View {
    @EnvironmentObject var arViewModel: ARViewModel

    var body: some View {
        VStack {
            Text("Make sure your device is facing north.")
                .font(.headline)
                .padding()

            Image(systemName: "arrow.up")
                .resizable()
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: -arViewModel.currentHeading))
                .foregroundColor(arViewModel.isFacingNorth() ? .green : .red)
                .padding()

            if arViewModel.isFacingNorth() {
                Button(action: {
                    arViewModel.isSessionStarted = true // 세션 시작 상태를 표시하기 위한 변수
                }) {
                    Text("Start AR Session")
                        .font(.title)
                }
                .padding()
            }
        }
    }
}
