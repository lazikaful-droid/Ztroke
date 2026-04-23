import Foundation
import Observation

@MainActor
@Observable
final class StrokeAnalysisState {
    var detectedStrokes: [StrokeAnalysisResult] = []
    var sessionSummary: SessionAnalysisSummary? = nil
    var sessionFeedback: [String] = []

    var strokeCount: Int { detectedStrokes.count }
    var forehandCount: Int { detectedStrokes.filter { $0.type == .forehand }.count }
    var backhandCount: Int { detectedStrokes.filter { $0.type == .backhand }.count }
    var averageScore: Double {
        guard !detectedStrokes.isEmpty else { return 0 }
        return detectedStrokes.map(\.score).reduce(0, +) / Double(detectedStrokes.count)
    }

    func appendStroke(_ result: StrokeAnalysisResult) {
        detectedStrokes.append(result)
    }

    func finalizeSession(trainingType: String) {
        let dist = SessionAnalysisSummary.QualityDistribution(
            perfect: detectedStrokes.filter { $0.quality == .perfect }.count,
            good: detectedStrokes.filter { $0.quality == .good }.count,
            miss: detectedStrokes.filter { $0.quality == .miss }.count
        )
        sessionSummary = SessionAnalysisSummary(
            sessionId: UUID(),
            trainingType: trainingType,
            totalStrokes: detectedStrokes.count,
            averageScore: averageScore,
            bestScore: detectedStrokes.map(\.score).max() ?? 0,
            qualityDistribution: dist,
            strokes: detectedStrokes
        )
        sessionFeedback = FeedbackEngine().generate(from: sessionSummary!)
    }

    func reset() {
        detectedStrokes = []
        sessionSummary = nil
        sessionFeedback = []
    }
}
