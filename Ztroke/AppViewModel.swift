//
//  AppViewModel.swift
//  Ztroke
//
//  Created by Codex on 26/04/25.
//

import Foundation
import Observation

@Observable
final class AppViewModel {
    var path: [AppRoute] = []
    var practiceDurationMinutes = 15
    private(set) var sessions: [PracticeSession]
    private(set) var activeSetup: PracticeSetup?

    init(sessions: [PracticeSession] = PracticeSession.sampleData) {
        self.sessions = sessions.sorted { $0.date > $1.date }
    }

    var overview: PracticeOverview {
        PracticeOverview(
            sessionCount: sessions.count,
            totalMinutes: sessions.reduce(0) { $0 + $1.durationMinutes },
            totalSwings: sessions.reduce(0) { $0 + $1.swingCount },
            correctSwings: sessions.reduce(0) { $0 + $1.correctCount }
        )
    }

    var latestSession: PracticeSession? {
        sessions.first
    }

    func showHistory() {
        path.append(.history)
    }

    func showSetup(for stroke: StrokeType) {
        practiceDurationMinutes = 15
        path.append(.cameraSetup(stroke))
    }

    func startPractice(for stroke: StrokeType) {
        let setup = PracticeSetup(
            stroke: stroke,
            durationMinutes: max(practiceDurationMinutes, 1)
        )
        activeSetup = setup
        path.append(.practice(setup))
    }

    func finishPractice() {
        guard let setup = activeSetup else { return }

        let swingCount = max(setup.durationMinutes * 6, 12)
        let accuracyBias = setup.stroke == .forehand ? 0.78 : 0.72
        let correctCount = Int(Double(swingCount) * accuracyBias)
        let session = PracticeSession(
            id: UUID(),
            date: .now,
            stroke: setup.stroke,
            durationMinutes: setup.durationMinutes,
            swingCount: swingCount,
            correctCount: correctCount
        )

        sessions.insert(session, at: 0)
        activeSetup = nil
        path = [.practiceSummary(session.id)]
    }

    func returnToHome() {
        activeSetup = nil
        path.removeAll()
    }

    func session(for id: UUID) -> PracticeSession? {
        sessions.first { $0.id == id }
    }
}

extension PracticeSession {
    static let sampleData: [PracticeSession] = [
        PracticeSession(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? .now,
            stroke: .forehand,
            durationMinutes: 40,
            swingCount: 50,
            correctCount: 36
        ),
        PracticeSession(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: -3, to: .now) ?? .now,
            stroke: .backhand,
            durationMinutes: 35,
            swingCount: 42,
            correctCount: 28
        ),
        PracticeSession(
            id: UUID(),
            date: Calendar.current.date(byAdding: .day, value: -5, to: .now) ?? .now,
            stroke: .forehand,
            durationMinutes: 25,
            swingCount: 30,
            correctCount: 24
        )
    ]
}
