import Foundation

struct Scenario {
    let level: Int
    let title: String
    let mainAudio: String
    let interruptionRange: ClosedRange<TimeInterval>
    let branches: [ScenarioBranch]
}

struct ScenarioBranch {
    let userOption: String
    let narratorAudio: String?
    let feedback: String
    let feedbackType: FeedbackType
}

enum FeedbackType {
    case correct
    case neutral
    case incorrect
}
