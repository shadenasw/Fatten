//
//  ScenarioDetailView.swift
//
//
//  Created by shaden  on 10/11/1446 AH.
//
import SwiftUI

struct ScenarioLevelView: View {
    let scenario: TextScenarios
    @ObservedObject var progressVM: ProgressViewModel  // ✅ أضفناها
    @Binding var showTabBar: Bool

    @State private var selectedChoiceIndex: Int? = nil
    @State private var showFeedback = false
    @State private var feedbackMessage = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 10) {
            Text("المستوى \(scenario.level)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, -5)

            ZStack {
                Image("scenario_box")
                    .resizable()
                    .scaledToFit()
                Text(scenario.description)
                    .multilineTextAlignment(.center)
                    .padding(30)
            }
            .frame(width: 330, height: 180)
            .padding(.horizontal)

            Image(scenario.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.horizontal)

            VStack(spacing: 15) {
                ForEach(Array(scenario.choices.enumerated()), id: \.offset) { index, choice in
                    FixedOptionButton(
                        text: choice.text,
                        label: optionLetter(for: index),
                        isSelected: selectedChoiceIndex == index
                    ) {
                        if selectedChoiceIndex == nil { // ✅ فقط أول مرة
                            selectedChoiceIndex = index
                            feedbackMessage = feedback(for: choice.points)
                            showFeedback = true
                            progressVM.addPoints(choice.points) // ✅ هنا الإضافة
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.clear.opacity(0.2))
                            .frame(width: 36, height: 36)
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .overlay(
            Group {
                if showFeedback {
                    feedbackOverlay
                }
            }
        )
        .onAppear {
            showTabBar = false
        }
        .onDisappear {
            showTabBar = true
        }

    }

    var feedbackOverlay: some View {
        ZStack {
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ZStack {
                    Image("textNotify")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320)

                    VStack(alignment: .center, spacing: 6) {
                        if let index = selectedChoiceIndex {
                            Text(notificationTitle(for: scenario.choices[index].points))
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.top, 45)

                            Text(notificationMessage(for: scenario.level, points: scenario.choices[index].points))
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .padding(.horizontal, 24)
                                .padding(.bottom, 20)
                        }
                    }
                    .frame(width: 270)

                    Button(action: {
                        showFeedback = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black.opacity(0.7))
                    }
                    .offset(x: -130, y: -100)
                }
            }
        }
    }

    func optionLetter(for index: Int) -> String {
        switch index {
        case 0: return "أ"
        case 1: return "ب"
        case 2: return "ج"
        default: return ""
        }
    }

    func feedback(for points: Int) -> String {
        switch points {
        case 10:
            return "أحسنت! اخترت أفضل إجابة.\nتم تسجيل ١٠ نقاط لتقدمك"
        case 5:
            return "إجابتك جيدة! لكن لا يزال هناك مجال للتطور.\nتم تسجيل ٥ نقاط لتقدمك"
        default:
            return "إجابة لا بأس بها! هناك خيار أفضل.\nتم تسجيل نقطة لتقدمك"
        }
    }

    func notificationTitle(for points: Int) -> String {
        switch points {
        case 10: return "أحسنت!"
        case 5: return "إجابتك جيدة!"
        default: return "إجابة لا بأس بها!"
        }
    }

    func notificationMessage(for level: Int, points: Int) -> String {
        switch points {
        case 10: return "في هذا المستوى، اخترت أفضل إجابة وعززت مهارتك.\nتم تسجيل ١٠ نقاط لتقدمك"
        case 5: return "أظهرت وعيًا جزئيًا، لكن لا يزال هناك مجال للتطور.\nتم تسجيل ٥ نقاط لتقدمك"
        default: return "كان هناك خيار أفضل يساعدك أكثر.\nتم تسجيل نقطة لتقدمك"
        }
    }
}

struct FixedOptionButton: View {
    let text: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Image(isSelected ? "Option_clicked" : "Option")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 20)

                HStack {
                    Text(text)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 60)
                        .padding(.trailing, 12)
                }

                Text(label)
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 36, height: 36)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
            }
            .frame(height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

