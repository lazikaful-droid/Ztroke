//
//  StrokeAnalysisResult.swift
//  PoonaApp
//

import Foundation

// MARK: - Stroke Analysis Data Contract

enum StrokeType: String, Codable {
    case forehand
    case backhand
    case unknown
}

enum StrokeQuality: String, Codable {
    case perfect
    case good
    case miss
}

struct StrokeAnalysisResult: Identifiable, Codable {
    let id: UUID
    let type: StrokeType
    let confidence: Double
    let score: Double
    let timestamp: TimeInterval

    let amplitudeScore: Double
    let velocityScore: Double
    let angleScore: Double
    let smoothnessScore: Double

    var quality: StrokeQuality {
        if score >= 8.0 { return .perfect }
        else if score >= 5.0 { return .good }
        else { return .miss }
    }
}
