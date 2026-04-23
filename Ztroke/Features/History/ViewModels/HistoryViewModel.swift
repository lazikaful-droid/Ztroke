import Foundation

@Observable
final class HistoryViewModel {
    let sessions: [SessionAnalysisSummary]

    init(sessions: [SessionAnalysisSummary]) {
        self.sessions = sessions.sorted { $0.date > $1.date }
    }

    var isEmpty: Bool {
        sessions.isEmpty
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        return formatter.string(from: date)
    }

    func formattedDuration(_ summary: SessionAnalysisSummary) -> String {
        if let lastStroke = summary.strokes.last {
            let minutes = Int(lastStroke.timestamp) / 60
            return "\(minutes) Minutes"
        }
        return "0 Minutes"
    }
}
