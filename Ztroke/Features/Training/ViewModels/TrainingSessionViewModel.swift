import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class TrainingSessionViewModel {
    var sessionState: SessionState = .idle
    var selectedConfig: SessionConfig = .default
    var remainingTime: TimeInterval = 0
    var detectedBody: DetectedBody?
    var jointAngles: [JointAngle] = []
    var trainingType: TrainingModule.TrainingType = .forehand

    private var countdownTimer: Timer?
    private var sessionTimer: Timer?
    private var currentCountdownValue: Int = 5

    init(config: SessionConfig = .default) {
        self.selectedConfig = config
    }

    func selectConfig(_ config: SessionConfig) {
        selectedConfig = config
    }

    func setTrainingType(_ type: TrainingModule.TrainingType) {
        trainingType = type
    }

    func startSession() {
        sessionState = .idle
        remainingTime = selectedConfig.duration
    }

    func updateDetectedBody(_ body: DetectedBody?) {
        detectedBody = body

        switch sessionState {
        case .idle:
            if let body = body, body.isComplete {
                transitionToBodyDetected()
            }
        case .bodyDetected, .countdown:
            if let body = body, !body.isComplete {
                resetToIdle()
            }
        case .sessionActive:
            if let body = body {
                jointAngles = JointAngleCalculator.calculateAngles(from: body)
            }
        case .sessionEnded:
            break
        }
    }

    private func transitionToBodyDetected() {
        withAnimation(.easeInOut(duration: 0.4)) {
            sessionState = .bodyDetected
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.startCountdown()
        }
    }

    private func startCountdown() {
        currentCountdownValue = 5
        sessionState = .countdown(currentCountdownValue)

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }

            self.currentCountdownValue -= 1

            if self.currentCountdownValue > 0 {
                self.sessionState = .countdown(self.currentCountdownValue)
            } else {
                self.countdownTimer?.invalidate()
                self.countdownTimer = nil
                self.startActiveSession()
            }
        }
    }

    private func startActiveSession() {
        sessionState = .sessionActive
        remainingTime = selectedConfig.duration

        sessionTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }

            self.remainingTime -= 1

            if self.remainingTime <= 0 {
                self.endSession()
            }
        }
    }

    private func resetToIdle() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        currentCountdownValue = 5

        withAnimation(.easeInOut(duration: 0.4)) {
            sessionState = .idle
        }
    }

    func stopSession() {
        endSession()
    }

    private func endSession() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        sessionTimer?.invalidate()
        sessionTimer = nil
        sessionState = .sessionEnded
    }

    func reset() {
        endSession()
        detectedBody = nil
        jointAngles = []
        sessionState = .idle
    }

    var formattedRemainingTime: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
