//
//  ProgressViewModel.swift
//  Fatten
//
//  Created by layan alwasaidi on 12/05/2025.
//

import Foundation

class ProgressViewModel: ObservableObject {
    @Published var totalPoints: Int {
        didSet {
            savePoints()
        }
    }

    let maxPoints = 100 // 10 مستويات × 10 نقاط

    init() {
        // نحمل النقاط من التخزين عند البداية
        self.totalPoints = UserDefaults.standard.integer(forKey: "SavedTotalPoints")
    }

    func addPoints(_ points: Int) {
        // نتجنب زيادة النقاط إذا وصل الحد الأعلى
        if totalPoints < maxPoints {
            totalPoints += points
            if totalPoints > maxPoints {
                totalPoints = maxPoints
            }
        }
    }

    func savePoints() {
        UserDefaults.standard.set(totalPoints, forKey: "SavedTotalPoints")
    }

    var progress: Double {
        Double(totalPoints) / Double(maxPoints)
    }

    func resetPoints() {
        totalPoints = 0
    }
}
