import Foundation
import Observation

@Observable
final class AppCoordinator {
    var path: [AppRoute] = []
    var sessions: [SessionAnalysisSummary] = []

    init(sessions: [SessionAnalysisSummary] = []) {
        self.sessions = sessions.sorted { $0.date > $1.date }
    }

    var homeViewModel: HomeViewModel {
        HomeViewModel(sessions: sessions)
    }

    var historyViewModel: HistoryViewModel {
        HistoryViewModel(sessions: sessions)
    }

    var latestSession: SessionAnalysisSummary? {
        sessions.first
    }

    func showHistory() {
        path.append(.history)
    }

    func showTraining(for stroke: StrokeType) {
        path.append(.training(stroke))
    }

    func addSession(_ session: SessionAnalysisSummary) {
        sessions.insert(session, at: 0)
    }

    func returnToHome() {
        path.removeAll()
    }
}
