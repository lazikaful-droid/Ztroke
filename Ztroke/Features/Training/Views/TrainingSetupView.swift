import SwiftUI

struct TrainingSetupView: View {
    let trainingType: TrainingModule.TrainingType
    @State private var viewModel = TrainingSessionViewModel()

    var body: some View {
        VStack(spacing: Spacing.xl) {
            Text("Session Setup")
                .font(.ztrokeLargeTitle)
                .padding(.top, Spacing.xxxl)

            Text("Select your training duration")
                .font(.ztrokeBodySecondary)
                .foregroundStyle(.black.opacity(0.7))

            VStack(spacing: Spacing.md) {
                ForEach(SessionConfig.presets, id: \.duration) { config in
                    DurationButton(
                        config: config,
                        isSelected: viewModel.selectedConfig.duration == config.duration,
                        action: { viewModel.selectedConfig = config }
                    )
                }
            }

            Spacer()

            NavigationLink(destination: CameraSessionView(viewModel: viewModel, trainingType: trainingType)) {
                Text("Start")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Spacing.md)
                    .background(Color.navy)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.full))
            }
        }
        .padding(.horizontal, Spacing.lg)
        .background(Color.navy.opacity(0.05).ignoresSafeArea())
        .onAppear {
            viewModel.setTrainingType(trainingType)
        }
    }
}

private struct DurationButton: View {
    let config: SessionConfig
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(config.displayText)
                    .foregroundStyle(.black)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color.navy)
                }
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.vertical, Spacing.md)
            .background(isSelected ? Color.navy.opacity(0.1) : Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: Radius.md))
        }
    }
}

#Preview {
    NavigationStack {
        TrainingSetupView(trainingType: .forehand)
    }
}
