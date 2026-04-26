import Foundation

struct SessionConfig: Equatable {
    let duration: TimeInterval

    static let presets: [SessionConfig] = [
        SessionConfig(duration: 60),
        SessionConfig(duration: 300),
        SessionConfig(duration: 600),
        SessionConfig(duration: 900),
        SessionConfig(duration: 1800),
        SessionConfig(duration: 2700),
        SessionConfig(duration: 3600)
    ]

    static let `default` = SessionConfig(duration: 60)

    var displayText: String {
        if duration < 60 {
            return "\(Int(duration)) Seconds"
        } else if duration == 60 {
            return "1 Minute"
        } else {
            return "\(Int(duration / 60)) Minutes"
        }
    }
}
