import SwiftUI

struct CompassView: View {
    @EnvironmentObject var arViewModel: ARViewModel

    var body: some View {
        VStack {
            Text("Rotate the device towards the arrow.")
                .font(.headline)
                .padding()

            Image(systemName: "arrow.up")
                .resizable()
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: -arViewModel.currentHeading))
                .foregroundColor(arViewModel.isFacingNorth() ? .green : .red)
                .padding()

            Button(action: {
                arViewModel.isSessionStarted = true // 세션 시작 상태를 표시하기 위한 변수
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            }) {
                Text("Start AR Session")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(arViewModel.isFacingNorth() ? .blue : .gray) // 상태에 따라 색상 변경
            .controlSize(.regular) // 버튼 크기 조정
            .padding()
            .disabled(!arViewModel.isFacingNorth()) // isFacingNorth가 false일 때 비활성화
            .animation(.easeInOut(duration: 0.3), value: arViewModel.isFacingNorth()) // 상태 전환 애니메이션
        }
    }
}
