//
//  DataModel.swift
//  Ztroke
//
//  Created by Zulkifli on 22/04/26.
//

import Foundation

enum StrokeType: String, CaseIterable, Identifiable, Hashable {
    case forehand
    case backhand

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }

    var symbolName: String {
        "figure.badminton"
    }

    var mirrored: Bool {
        self == .backhand
    }
}

struct PracticeSetup: Hashable {
    let stroke: StrokeType
    let durationMinutes: Int
}

struct PracticeSession: Identifiable, Hashable {
    let id: UUID
    let date: Date
    let stroke: StrokeType
    let durationMinutes: Int
    let swingCount: Int
    let correctCount: Int

    var incorrectCount: Int {
        max(swingCount - correctCount, 0)
    }

    var accuracy: Double {
        guard swingCount > 0 else { return 0 }
        return Double(correctCount) / Double(swingCount)
    }
}

struct PracticeOverview {
    let sessionCount: Int
    let totalMinutes: Int
    let totalSwings: Int
    let correctSwings: Int

    var incorrectSwings: Int {
        max(totalSwings - correctSwings, 0)
    }

    var accuracyRate: Double {
        guard totalSwings > 0 else { return 0 }
        return Double(correctSwings) / Double(totalSwings)
    }
}

enum AppRoute: Hashable {
    case history
    case cameraSetup(StrokeType)
    case practice(PracticeSetup)
    case practiceSummary(UUID)
}
