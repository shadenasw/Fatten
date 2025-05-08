//
//  TextSenarioView.swift
//  Qiyam
//
//  Created by shaden  on 10/11/1446 AH.
//
import SwiftUI

struct TextSenarioView: View {
    @State private var selectedScenario: TextScenarios? = nil

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ZStack {
                    Image("allLevelsBackground")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width)

                    // ✅ Level 1 button
                    levelButton(level: 1, x: UIScreen.main.bounds.width * 0.2, y: 150)

                    // ✅ Level 2 button
                    levelButton(level: 2, x: UIScreen.main.bounds.width * 0.5, y: 300)

                    // ✅ Level 3 button
                    levelButton(level: 3, x: UIScreen.main.bounds.width * 0.7, y: 450)

                    // ✅ Level 4 button
                    levelButton(level: 4, x: UIScreen.main.bounds.width * 0.3, y: 600)

                    // ✅ Level 5 button
                    levelButton(level: 5, x: UIScreen.main.bounds.width * 0.6, y: 750)

                    // ✅ Level 6 button
                    levelButton(level: 6, x: UIScreen.main.bounds.width * 0.4, y: 900)

                    // ✅ Level 7 button
                    levelButton(level: 7, x: UIScreen.main.bounds.width * 0.8, y: 1050)

                    // ✅ Level 8 button
                    levelButton(level: 8, x: UIScreen.main.bounds.width * 0.2, y: 1200)

                    // ✅ Level 9 button
                    levelButton(level: 9, x: UIScreen.main.bounds.width * 0.5, y: 1350)

                    // ✅ Level 10 button
                    levelButton(level: 10, x: UIScreen.main.bounds.width * 0.7, y: 1500)
                }
                .frame(height: 1600) // اضبطيها حسب طول الصورة الحقيقي
            }
            .background(
                NavigationLink(
                    destination: selectedScenario.map {
                        ScenarioLevelView(scenario: $0)
                                   .environment(\.layoutDirection, .rightToLeft) // ✅ هنا نحطها بس
                           },
                    isActive: Binding<Bool>(
                        get: { selectedScenario != nil },
                        set: { if !$0 { selectedScenario = nil } }
                    )
                ) {
                    EmptyView()
                }
            )
            .navigationBarHidden(true)
        }
    }

    @ViewBuilder
    func levelButton(level: Int, x: CGFloat, y: CGFloat) -> some View {
        Button(action: {
            selectedScenario = scenarios.first(where: { $0.level == level })
        }) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 80, height: 80)
                .background(
                    Color.blue.opacity(0.2) // ✅ عشان تجربين المكان، تقدرين تمسحينها بعدين
                )
                .cornerRadius(12)
                .overlay(
                    Text("\(level)")
                        .foregroundColor(.white)
                        .font(.caption)
                        .opacity(0.8)
                )
        }
        .position(x: x, y: y)
    }
}
