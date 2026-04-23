import SwiftUI

struct TrainingSetupView: View {
    let trainingType: TrainingModule.TrainingType
    @State private var viewModel = TrainingSessionViewModel()
    
    var body: some View {
        VStack(spacing: Spacing.xl) {
            Text("Session Setup")
                .font(.poonaLargeTitle)
                .padding(.top, Spacing.xxxl)
            
            Text("Select your training duration")
                .font(.poonaBodySecondary)
                .foregroundStyle(Color.poonaSecondaryLabel)
            
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
                    .background(Color.poonaAccent)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.full))
            }
        }
        .padding(.horizontal, Spacing.lg)
        .background(Color.poonaBackground.ignoresSafeArea())
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
                    .foregroundStyle(Color.poonaLabel)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color.poonaAccent)
                }
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.vertical, Spacing.md)
            .background(isSelected ? Color.poonaAccent.opacity(0.1) : Color.poonaSecondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: Radius.md))
        }
    }
}

#Preview {
    NavigationStack {
        TrainingSetupView(trainingType: .forehand)
    }
}
