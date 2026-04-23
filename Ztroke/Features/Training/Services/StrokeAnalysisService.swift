import CoreGraphics
import Foundation

enum DominantHand: String {
    case left
    case right
}

final class StrokeAnalysisService: @unchecked Sendable {

    private enum SwingState {
        case idle
        case prep(
            startTime: TimeInterval,
            startPosition: CGPoint,
            peakPosition: CGPoint,
            frameHistory: [CGPoint],
            smoothedPosition: CGPoint?,
            smoothedVelocity: CGPoint?,
            peakVelocity: Double,
            minJointConfidence: Float,
            elbowAngleAtCompletion: Double?
        )
    }

    private let queue = DispatchQueue(
        label: "com.ztroke.strokeAnalysis",
        qos: .userInteractive
    )
    private var swingState: SwingState = .idle
    private var dominantHand: DominantHand = .right
    private var handLocked = false
    private let config: StrokeAnalysisConfig

    var onStrokeDetected: ((StrokeAnalysisResult) -> Void)?

    init(config: StrokeAnalysisConfig) {
        self.config = config
    }

    func process(body: DetectedBody, angles: [JointAngle], timestamp: TimeInterval) {
        queue.async { [weak self] in
            self?.processFrame(body: body, angles: angles, timestamp: timestamp)
        }
    }

    private func processFrame(body: DetectedBody, angles: [JointAngle], timestamp: TimeInterval) {
        if !handLocked {
            dominantHand = determineDominantHand(from: body)
            handLocked = true
        }

        let wristJoint: BodyJoint = dominantHand == .right ? .rightWrist : .leftWrist
        let shoulderJoint: BodyJoint = dominantHand == .right ? .rightShoulder : .leftShoulder

        guard let wrist = body.joints[wristJoint],
              let shoulder = body.joints[shoulderJoint] else { return }

        let wristPos = CGPoint(x: wrist.location.x, y: wrist.location.y)
        let shoulderPos = CGPoint(x: shoulder.location.x, y: shoulder.location.y)
        let jointConfidence = wrist.confidence

        let elbowAngle = getElbowAngle(from: angles)

        switch swingState {
        case .idle:
            handleIdleState(
                wristPos: wristPos,
                shoulderPos: shoulderPos,
                timestamp: timestamp,
                elbowAngle: elbowAngle
            )
        case .prep(let startTime, let startPosition, let peakPosition, let frameHistory,
                   let smoothedPosition, let smoothedVelocity, let peakVelocity,
                   let minConf, _):
            handlePrepState(
                wristPos: wristPos,
                shoulderPos: shoulderPos,
                startTime: startTime,
                startPosition: startPosition,
                peakPosition: peakPosition,
                frameHistory: frameHistory,
                smoothedPosition: smoothedPosition,
                smoothedVelocity: smoothedVelocity,
                peakVelocity: peakVelocity,
                minJointConfidence: minConf,
                jointConfidence: Float(jointConfidence),
                timestamp: timestamp,
                elbowAngle: elbowAngle
            )
        }
    }

    private func handleIdleState(
        wristPos: CGPoint,
        shoulderPos: CGPoint,
        timestamp: TimeInterval,
        elbowAngle: Double
    ) {
        switch config.idealElbowAngle {
        case 90.0:
            if wristPos.y < shoulderPos.y {
                swingState = .prep(
                    startTime: timestamp,
                    startPosition: wristPos,
                    peakPosition: wristPos,
                    frameHistory: [wristPos],
                    smoothedPosition: wristPos,
                    smoothedVelocity: nil,
                    peakVelocity: 0,
                    minJointConfidence: Float.greatestFiniteMagnitude,
                    elbowAngleAtCompletion: nil
                )
            }
        default:
            if wristPos.y > shoulderPos.y {
                swingState = .prep(
                    startTime: timestamp,
                    startPosition: wristPos,
                    peakPosition: wristPos,
                    frameHistory: [wristPos],
                    smoothedPosition: wristPos,
                    smoothedVelocity: nil,
                    peakVelocity: 0,
                    minJointConfidence: Float.greatestFiniteMagnitude,
                    elbowAngleAtCompletion: nil
                )
            }
        }
    }

    private func handlePrepState(
        wristPos: CGPoint,
        shoulderPos: CGPoint,
        startTime: TimeInterval,
        startPosition: CGPoint,
        peakPosition: CGPoint,
        frameHistory: [CGPoint],
        smoothedPosition: CGPoint?,
        smoothedVelocity: CGPoint?,
        peakVelocity: Double,
        minJointConfidence: Float,
        jointConfidence: Float,
        timestamp: TimeInterval,
        elbowAngle: Double
    ) {
        guard jointConfidence >= config.minJointConfidence else { return }

        var currentSmoothedPosition: CGPoint
        if let prev = smoothedPosition {
            currentSmoothedPosition = ema(previous: prev, current: wristPos, alpha: config.smoothingAlpha)
        } else {
            currentSmoothedPosition = wristPos
        }

        var currentVelocity: CGPoint
        var currentPeakVelocity = peakVelocity
        if let prevSmoothed = smoothedPosition {
            let rawVelocity = CGPoint(
                x: currentSmoothedPosition.x - prevSmoothed.x,
                y: currentSmoothedPosition.y - prevSmoothed.y
            )
            if let prevVel = smoothedVelocity {
                currentVelocity = ema(previous: prevVel, current: rawVelocity, alpha: config.velocitySmoothingAlpha)
            } else {
                currentVelocity = rawVelocity
            }
            let instantaneousVelocity = sqrt(
                Double(currentVelocity.x * currentVelocity.x + currentVelocity.y * currentVelocity.y)
            )
            currentPeakVelocity = max(currentPeakVelocity, instantaneousVelocity)
        } else {
            currentVelocity = .zero
        }

        var updatedHistory = frameHistory
        updatedHistory.append(currentSmoothedPosition)
        if updatedHistory.count > 5 {
            updatedHistory.removeFirst()
        }

        let newMinConfidence = min(minJointConfidence, jointConfidence)

        switch config.idealElbowAngle {
        case 90.0:
            handleForehandPrep(
                wristPos: wristPos,
                shoulderPos: shoulderPos,
                startTime: startTime,
                startPosition: startPosition,
                peakPosition: peakPosition,
                frameHistory: updatedHistory,
                smoothedPosition: currentSmoothedPosition,
                smoothedVelocity: currentVelocity,
                peakVelocity: currentPeakVelocity,
                minJointConfidence: newMinConfidence,
                timestamp: timestamp,
                elbowAngle: elbowAngle
            )
        default:
            handleBackhandPrep(
                wristPos: wristPos,
                shoulderPos: shoulderPos,
                startTime: startTime,
                startPosition: startPosition,
                peakPosition: peakPosition,
                frameHistory: updatedHistory,
                smoothedPosition: currentSmoothedPosition,
                smoothedVelocity: currentVelocity,
                peakVelocity: currentPeakVelocity,
                minJointConfidence: newMinConfidence,
                timestamp: timestamp,
                elbowAngle: elbowAngle
            )
        }
    }

    private func handleForehandPrep(
        wristPos: CGPoint,
        shoulderPos: CGPoint,
        startTime: TimeInterval,
        startPosition: CGPoint,
        peakPosition: CGPoint,
        frameHistory: [CGPoint],
        smoothedPosition: CGPoint,
        smoothedVelocity: CGPoint,
        peakVelocity: Double,
        minJointConfidence: Float,
        timestamp: TimeInterval,
        elbowAngle: Double
    ) {
        var newPeakPosition = peakPosition
        if wristPos.y > newPeakPosition.y {
            newPeakPosition = wristPos
        }

        let maxDropY = newPeakPosition.y - wristPos.y
        let instantaneousVelocity = sqrt(
            Double(smoothedVelocity.x * smoothedVelocity.x + smoothedVelocity.y * smoothedVelocity.y)
        )

        if maxDropY > config.minDisplacement
            && instantaneousVelocity > config.minFrameVelocity
            && wristPos.y > shoulderPos.y {
            let peakDisplacement = abs(newPeakPosition.y - startPosition.y)
            emitStroke(
                type: .forehand,
                peakDisplacement: peakDisplacement,
                peakVelocity: peakVelocity,
                elbowAngle: elbowAngle,
                frameHistory: frameHistory,
                minConfidence: minJointConfidence,
                timestamp: timestamp
            )
            swingState = .idle
            return
        }

        if wristPos.y > shoulderPos.y && maxDropY < 0.15 {
            swingState = .idle
            return
        }

        swingState = .prep(
            startTime: startTime,
            startPosition: startPosition,
            peakPosition: newPeakPosition,
            frameHistory: frameHistory,
            smoothedPosition: smoothedPosition,
            smoothedVelocity: smoothedVelocity,
            peakVelocity: peakVelocity,
            minJointConfidence: minJointConfidence,
            elbowAngleAtCompletion: elbowAngle
        )
    }

    private func handleBackhandPrep(
        wristPos: CGPoint,
        shoulderPos: CGPoint,
        startTime: TimeInterval,
        startPosition: CGPoint,
        peakPosition: CGPoint,
        frameHistory: [CGPoint],
        smoothedPosition: CGPoint,
        smoothedVelocity: CGPoint,
        peakVelocity: Double,
        minJointConfidence: Float,
        timestamp: TimeInterval,
        elbowAngle: Double
    ) {
        var newPeakPosition = peakPosition
        if wristPos.y < newPeakPosition.y {
            newPeakPosition = wristPos
        }

        let deltaX = abs(startPosition.x - wristPos.x)
        let frameVelocityX = abs(smoothedVelocity.x)
        let maxRiseY = wristPos.y - newPeakPosition.y
        let instantaneousVelocityY = abs(smoothedVelocity.y)

        if deltaX > 0.3 && frameVelocityX > config.minFrameVelocity {
            let peakDisplacement = deltaX
            emitStroke(
                type: .backhand,
                peakDisplacement: peakDisplacement,
                peakVelocity: peakVelocity,
                elbowAngle: elbowAngle,
                frameHistory: frameHistory,
                minConfidence: minJointConfidence,
                timestamp: timestamp
            )
            swingState = .idle
            return
        }

        if maxRiseY > config.minDisplacement
            && instantaneousVelocityY > config.minFrameVelocity
            && wristPos.y < shoulderPos.y {
            let peakDisplacement = maxRiseY
            emitStroke(
                type: .backhand,
                peakDisplacement: peakDisplacement,
                peakVelocity: peakVelocity,
                elbowAngle: elbowAngle,
                frameHistory: frameHistory,
                minConfidence: minJointConfidence,
                timestamp: timestamp
            )
            swingState = .idle
            return
        }

        if wristPos.y < shoulderPos.y && maxRiseY < 0.1 {
            swingState = .idle
            return
        }

        swingState = .prep(
            startTime: startTime,
            startPosition: startPosition,
            peakPosition: newPeakPosition,
            frameHistory: frameHistory,
            smoothedPosition: smoothedPosition,
            smoothedVelocity: smoothedVelocity,
            peakVelocity: peakVelocity,
            minJointConfidence: minJointConfidence,
            elbowAngleAtCompletion: elbowAngle
        )
    }

    private func emitStroke(
        type: StrokeType,
        peakDisplacement: Double,
        peakVelocity: Double,
        elbowAngle: Double,
        frameHistory: [CGPoint],
        minConfidence: Float,
        timestamp: TimeInterval
    ) {
        let amplitudeScore = min(peakDisplacement / config.idealDisplacement, 1.0)
        let velocityScore = min(peakVelocity / config.idealVelocity, 1.0)

        let angleDelta = abs(elbowAngle - config.idealElbowAngle)
        let angleScore = max(1.0 - (angleDelta / config.maxAngleDeviation), 0.0)

        let directionChanges = computeDirectionChanges(from: frameHistory)
        let smoothnessScore: Double
        if frameHistory.count > 1 {
            smoothnessScore = max(1.0 - Double(directionChanges) / Double(frameHistory.count), 0.0)
        } else {
            smoothnessScore = 1.0
        }

        let confidence = Double(minConfidence)

        let rawScore = config.amplitudeWeight * amplitudeScore
            + config.velocityWeight * velocityScore
            + config.angleWeight * angleScore
            + config.smoothnessWeight * smoothnessScore

        let score = rawScore * 10.0

        let result = StrokeAnalysisResult(
            id: UUID(),
            type: type,
            confidence: confidence,
            score: score,
            timestamp: timestamp,
            amplitudeScore: amplitudeScore,
            velocityScore: velocityScore,
            angleScore: angleScore,
            smoothnessScore: smoothnessScore
        )

        onStrokeDetected?(result)
    }

    private func determineDominantHand(from body: DetectedBody) -> DominantHand {
        let rightWristY = body.joints[.rightWrist]?.location.y ?? 0
        let leftWristY = body.joints[.leftWrist]?.location.y ?? 0
        return rightWristY > leftWristY ? .right : .left
    }

    private func ema(previous: CGPoint, current: CGPoint, alpha: Double) -> CGPoint {
        let x = alpha * Double(current.x) + (1 - alpha) * Double(previous.x)
        let y = alpha * Double(current.y) + (1 - alpha) * Double(previous.y)
        return CGPoint(x: x, y: y)
    }

    private func computeDirectionChanges(from history: [CGPoint]) -> Int {
        guard history.count >= 3 else { return 0 }
        var changes = 0
        for i in 2..<history.count {
            let prevDx = history[i-1].x - history[i-2].x
            let prevDy = history[i-1].y - history[i-2].y
            let currDx = history[i].x - history[i-1].x
            let currDy = history[i].y - history[i-1].y

            if (prevDx > 0 && currDx < 0) || (prevDx < 0 && currDx > 0) {
                changes += 1
            }
            if (prevDy > 0 && currDy < 0) || (prevDy < 0 && currDy > 0) {
                changes += 1
            }
        }
        return changes
    }

    private func getElbowAngle(from angles: [JointAngle]) -> Double {
        let elbowName = dominantHand == .right ? "Right Elbow" : "Left Elbow"
        if let match = angles.first(where: { $0.name == elbowName }) {
            return Double(match.degrees)
        }
        return config.idealElbowAngle
    }
}
