//
//  ScenarioProgressViewModel.swift
//  Futtin
//
//  Created by Lana Alyahya on 31/05/2025.
//


import Foundation
import SwiftUI

class ScenarioProgressViewModel: ObservableObject {
    @Published var levelProgressList: [LevelProgress] = []

    init() {
        loadProgress()
    }

    func completeTextScenario(for level: Int) {
        updateProgress(for: level) { $0.didCompleteText = true }
    }

    func completeAudioScenario(for level: Int) {
        updateProgress(for: level) { $0.didCompleteAudio = true }
    }

    private func updateProgress(for level: Int, update: (inout LevelProgress) -> Void) {
        if let index = levelProgressList.firstIndex(where: { $0.level == level }) {
            update(&levelProgressList[index])
        } else {
            var progress = LevelProgress(level: level, didCompleteText: false, didCompleteAudio: false)
            update(&progress)
            levelProgressList.append(progress)
        }

        saveProgress()

        // فتح المستوى التالي إذا اكتملت الاثنين
        if let current = levelProgressList.first(where: { $0.level == level }),
           current.didCompleteText && current.didCompleteAudio {
            unlockNextLevel(level + 1)
        }
    }

    func unlockNextLevel(_ level: Int) {
        guard !levelProgressList.contains(where: { $0.level == level }) else { return }
        levelProgressList.append(LevelProgress(level: level, didCompleteText: false, didCompleteAudio: false))
        saveProgress()
    }

    func isLevelUnlocked(_ level: Int) -> Bool {
        level == 1 || levelProgressList.contains(where: { $0.level == level })
    }

    private func saveProgress() {
        if let data = try? JSONEncoder().encode(levelProgressList) {
            UserDefaults.standard.set(data, forKey: "LevelProgress")
        }
    }

    private func loadProgress() {
        if let data = UserDefaults.standard.data(forKey: "LevelProgress"),
           let saved = try? JSONDecoder().decode([LevelProgress].self, from: data) {
            levelProgressList = saved
        } else {
            levelProgressList = [LevelProgress(level: 1, didCompleteText: false, didCompleteAudio: false)]
        }
    }
}
