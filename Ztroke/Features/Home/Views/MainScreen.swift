import SwiftUI

struct MainScreen: View {
    @Bindable var coordinator: AppCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                Color.navy
                    .opacity(0.08)
                    .ignoresSafeArea()

                VStack {
                    Text("Summary")
                        .font(.ztrokeTitle)
                        .foregroundColor(.black)
                        .padding(.trailing, 245)
                        .padding(.top, 50)

                    SummaryView(viewModel: coordinator.homeViewModel)
                        .padding(.top, -60)

                    PracticeCount(viewModel: coordinator.homeViewModel)
                        .padding(.top, -53)

                    Button(action: { coordinator.showHistory() }) {
                        History(session: coordinator.latestSession)
                            .padding(.top, 6)
                    }

                    Text("Training Mode")
                        .font(.system(size: 17, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .opacity(0.9)
                        .padding(.trailing, 220)
                        .padding(.top, 30)

                    HStack {
                        TrainingCard(
                            title: "Forehand",
                            mirrored: false,
                            action: { coordinator.showTraining(for: .forehand) }
                        )

                        TrainingCard(
                            title: "Backhand",
                            mirrored: true,
                            action: { coordinator.showTraining(for: .backhand) }
                        )
                    }

                    Text("Choose the stroke above to practice.")
                        .font(.ztrokeBodySecondary)
                        .foregroundColor(.black)
                        .opacity(0.8)
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .history:
                    HistoryScreen(viewModel: coordinator.historyViewModel)
                case .training(let stroke):
                    if stroke == .forehand {
                        ForehandView()
                    } else {
                        BackhandView()
                    }
                case .cameraSetup:
                    CameraSetUpScreen(coordinator: coordinator)
                case .practice, .practiceSummary:
                    EmptyView()
                }
            }
        }
    }
}

private struct TrainingCard: View {
    let title: String
    let mirrored: Bool
    let action: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Radius.lg)
                .frame(width: 165, height: 140)
                .foregroundStyle(Color.navy)

            Button(action: action) {
                VStack {
                    Image(systemName: "figure.badminton")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gold)
                        .scaleEffect(x: mirrored ? -1 : 1, y: 1)
                        .padding(.bottom, 5)

                    Text(title)
                        .font(.ztrokeCaptionBold)
                        .foregroundColor(.gold)
                }
            }
        }
    }
}

#Preview {
    MainScreen(coordinator: AppCoordinator())
}
