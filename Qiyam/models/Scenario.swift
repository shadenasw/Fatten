//
//  Scenario.swift
//  Qiyam
//
//  Created by Lana Alyahya on 11/05/2025.
//

import Foundation

struct Scenario: Identifiable {
    let id = UUID()
    let level: Int
    let title: String
    let mainAudio: String
    let interruptionRange: ClosedRange<TimeInterval>
    let branches: [ScenarioBranch]?
}

struct ScenarioBranch {
    let userOption: String
    let narratorAudio: String?
    
}
