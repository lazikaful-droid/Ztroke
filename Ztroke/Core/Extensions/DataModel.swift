import Foundation

enum StrokeType: String, CaseIterable, Identifiable, Hashable, Codable {
    case forehand
    case backhand
    case unknown

    var id: String { rawValue }

    var title: String {
        switch self {
        case .forehand: return "Forehand"
        case .backhand: return "Backhand"
        case .unknown: return "Unknown"
        }
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
    case training(StrokeType)
    case practice(PracticeSetup)
    case practiceSummary(UUID)
}
