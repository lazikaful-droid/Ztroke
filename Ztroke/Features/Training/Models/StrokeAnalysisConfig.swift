import Foundation

struct StrokeAnalysisConfig {
    let minDisplacement: Double
    let idealDisplacement: Double

    let minFrameVelocity: Double
    let idealVelocity: Double

    let idealElbowAngle: Double
    let maxAngleDeviation: Double

    let smoothingAlpha: Double
    let velocitySmoothingAlpha: Double

    let minJointConfidence: Float

    let amplitudeWeight: Double
    let velocityWeight: Double
    let angleWeight: Double
    let smoothnessWeight: Double

    static let forehand = StrokeAnalysisConfig(
        minDisplacement: 0.20,
        idealDisplacement: 0.40,
        minFrameVelocity: 0.04,
        idealVelocity: 0.08,
        idealElbowAngle: 90.0,
        maxAngleDeviation: 45.0,
        smoothingAlpha: 0.3,
        velocitySmoothingAlpha: 0.5,
        minJointConfidence: 0.5,
        amplitudeWeight: 0.30,
        velocityWeight: 0.25,
        angleWeight: 0.25,
        smoothnessWeight: 0.20
    )

    static let backhand = StrokeAnalysisConfig(
        minDisplacement: 0.20,
        idealDisplacement: 0.40,
        minFrameVelocity: 0.05,
        idealVelocity: 0.10,
        idealElbowAngle: 120.0,
        maxAngleDeviation: 45.0,
        smoothingAlpha: 0.3,
        velocitySmoothingAlpha: 0.5,
        minJointConfidence: 0.5,
        amplitudeWeight: 0.30,
        velocityWeight: 0.25,
        angleWeight: 0.25,
        smoothnessWeight: 0.20
    )
}
