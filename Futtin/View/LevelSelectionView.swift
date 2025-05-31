//
//  LevelSelectionView.swift
//  Futtin
//
//  Created by Lana Alyahya on 31/05/2025.
//


import SwiftUI

struct LevelSelectionView: View {
    @StateObject var progressManager = ScenarioProgressViewModel()
    @StateObject var progressVM = ProgressViewModel()
    @StateObject var scenarioVM = ScenarioViewModel()

    @State private var selectedLevel: Int? = nil
    @State private var showScenarioSheet = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(1...10, id: \.self) { level in
                    ZStack {
                        Image("img_level_\(level)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                if progressManager.isLevelUnlocked(level) {
                                    selectedLevel = level
                                    showScenarioSheet = true
                                }
                            }

                        if !progressManager.isLevelUnlocked(level) {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.black.opacity(0.5))
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.6))
                                        .frame(width: 80, height: 80)
                                )
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showScenarioSheet) {
            if let level = selectedLevel {
                ScenarioSelectionSheet(
                    level: selectedLevel ?? 1,
                    didCompleteText: progressManager.levelProgressList.first(where: { $0.level == selectedLevel })?.didCompleteText ?? false,
                    didCompleteAudio: progressManager.levelProgressList.first(where: { $0.level == selectedLevel })?.didCompleteAudio ?? false,
                    onSelectText: {
                        if let level = selectedLevel {
                            progressManager.completeTextScenario(for: level)
                        }
                        showScenarioSheet = false
                    },
                    onSelectAudio: {
                        if let level = selectedLevel {
                            progressManager.completeAudioScenario(for: level)
                        }
                        showScenarioSheet = false
                    }
                )

            }
        }
    }
}
