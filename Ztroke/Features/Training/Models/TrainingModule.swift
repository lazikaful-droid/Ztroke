import Foundation

struct TrainingModule: Identifiable, Hashable {
    let id: UUID = UUID()
    let title: String
    let imageName: String?
    let type: TrainingType

    enum TrainingType: String, CaseIterable {
        case forehand
        case backhand
        case comingsoon
    }
}

extension TrainingModule {
    static let availableModules: [TrainingModule] = [
        TrainingModule(title: "Forehand Training", imageName: nil, type: .forehand),
        TrainingModule(title: "Backhand Training", imageName: nil, type: .backhand),
        TrainingModule(title: "Coming Soon", imageName: nil, type: .comingsoon),
    ]
}
