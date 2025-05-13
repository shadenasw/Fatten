//
//  Scenario.swift
//  Qiyam
//
//  Created by Lana Alyahya on 11/05/2025.
//

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
enum BannerType {
    case success, fail, timeout
}
