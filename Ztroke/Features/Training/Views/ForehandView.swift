import SwiftUI

struct ForehandView: View {
    var body: some View {
        ZStack {
            Color.navy.opacity(0.05).ignoresSafeArea()

            VStack(spacing: Spacing.lg) {
                Text("Forehand Training")
                    .font(.ztrokeLargeTitle)

                Text("Position yourself in front of the camera and start your session")
                    .font(.ztrokeBodySecondary)
                    .foregroundStyle(.black.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.xl)

                NavigationLink(destination: TrainingSetupView(trainingType: .forehand)) {
                    Text("Start Session")
                        .font(.ztrokeCTALabel)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.md)
                        .background(
                            Color.navy,
                            in: RoundedRectangle(cornerRadius: Radius.full)
                        )
                }
                .padding(.horizontal, Spacing.xl)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ForehandView()
}
