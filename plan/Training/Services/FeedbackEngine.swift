//
//  FeedbackEngine.swift
//  PoonaApp
//

import Foundation

struct FeedbackEngine {

    func generate(from summary: SessionAnalysisSummary) -> [String] {
        var feedback: [String] = []

        guard summary.totalStrokes > 0 else {
            feedback.append("No strokes were detected. Ensure the camera has a clear view of your full body.")
            return feedback
        }

        let avgAmplitude = summary.strokes.map(\.amplitudeScore).reduce(0, +) / Double(summary.strokes.count)
        if avgAmplitude < 0.5 {
            feedback.append("Your swing amplitude is low. Try extending your arm fully through the stroke.")
        }

        let avgVelocity = summary.strokes.map(\.velocityScore).reduce(0, +) / Double(summary.strokes.count)
        if avgVelocity < 0.5 {
            feedback.append("Your swing speed could be higher. Focus on accelerating through the contact point.")
        }

        let avgAngle = summary.strokes.map(\.angleScore).reduce(0, +) / Double(summary.strokes.count)
        if avgAngle < 0.6 {
            feedback.append("Your elbow angle at contact needs adjustment. Check your form against the ideal position.")
        }

        let avgSmoothness = summary.strokes.map(\.smoothnessScore).reduce(0, +) / Double(summary.strokes.count)
        if avgSmoothness < 0.5 {
            feedback.append("Your strokes appear choppy. Try to maintain a fluid, continuous motion.")
        }

        if summary.trainingType == "backhand" && summary.qualityDistribution.miss > summary.totalStrokes / 2 {
            feedback.append("More than half your backhand strokes were missed. Slow down and focus on form.")
        }

        if summary.averageScore >= 8.0 {
            feedback.append("Outstanding session! Your stroke quality is excellent across the board.")
        } else if summary.averageScore >= 6.0 {
            feedback.append("Good session. You're building solid consistency — keep it up.")
        }

        return feedback
    }
}
