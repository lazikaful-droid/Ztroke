import Foundation

struct SessionAnalysisSummary: Codable, Identifiable {
    let id: UUID
    let sessionId: UUID
    let trainingType: String
    let totalStrokes: Int
    let averageScore: Double
    let bestScore: Double
    let qualityDistribution: QualityDistribution
    let strokes: [StrokeAnalysisResult]
    let date: Date

    struct QualityDistribution: Codable {
        let perfect: Int
        let good: Int
        let miss: Int
    }

    init(
        sessionId: UUID,
        trainingType: String,
        totalStrokes: Int,
        averageScore: Double,
        bestScore: Double,
        qualityDistribution: QualityDistribution,
        strokes: [StrokeAnalysisResult],
        date: Date = .now
    ) {
        self.id = sessionId
        self.sessionId = sessionId
        self.trainingType = trainingType
        self.totalStrokes = totalStrokes
        self.averageScore = averageScore
        self.bestScore = bestScore
        self.qualityDistribution = qualityDistribution
        self.strokes = strokes
        self.date = date
    }
}
