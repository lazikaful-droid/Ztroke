import Foundation

@Observable
final class HomeViewModel {
    let sessions: [SessionAnalysisSummary]

    init(sessions: [SessionAnalysisSummary]) {
        self.sessions = sessions
    }

    var overview: PracticeOverview {
        PracticeOverview(
            sessionCount: sessions.count,
            totalMinutes: sessions.reduce(0) { $0 + Int($1.strokes.first?.timestamp ?? 0) / 60 },
            totalSwings: sessions.reduce(0) { $0 + $1.totalStrokes },
            correctSwings: sessions.reduce(0) { $0 + $1.qualityDistribution.perfect + $1.qualityDistribution.good }
        )
    }

    var latestSession: SessionAnalysisSummary? {
        sessions.first
    }

    var sessionCount: Int { sessions.count }

    var totalSwings: Int {
        sessions.reduce(0) { $0 + $1.totalStrokes }
    }

    var accuracyRate: Double {
        let total = sessions.reduce(0) { $0 + $1.totalStrokes }
        let correct = sessions.reduce(0) { $0 + $1.qualityDistribution.perfect + $1.qualityDistribution.good }
        guard total > 0 else { return 0 }
        return Double(correct) / Double(total)
    }
}
