//
//  SessionAnalysisSummary.swift
//  PoonaApp
//

import Foundation

struct SessionAnalysisSummary: Codable {
    let sessionId: UUID
    let trainingType: String
    let totalStrokes: Int
    let averageScore: Double
    let bestScore: Double
    let qualityDistribution: QualityDistribution
    let strokes: [StrokeAnalysisResult]

    struct QualityDistribution: Codable {
        let perfect: Int
        let good: Int
        let miss: Int
    }
}
