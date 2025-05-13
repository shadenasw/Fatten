//
//  TextSenarioView.swift
//  Qiyam
//
//  Created by shaden  on 10/11/1446 AH.
//
import SwiftUI

struct TextSenarioView: View {
    @State private var selectedScenario: TextScenarios? = nil
    @StateObject private var progressVM = ProgressViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geo in
                    ScrollViewReader { proxy in
                        ScrollView(.vertical, showsIndicators: false) {
                            let imageWidth = geo.size.width
                            let imageHeight = getImageHeight(forWidth: imageWidth)

                            ZStack {
                                Image("allLevelsBackground")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: imageWidth, height: imageHeight)
                                
                                

                                // ✅ أزرار المستويات
                                levelButton(level: 10, x: imageWidth * 0.3, y: imageHeight * 0.18)
                                levelButton(level: 9,  x: imageWidth * 0.7, y: imageHeight * 0.25)
                                levelButton(level: 8,  x: imageWidth * 0.3, y: imageHeight * 0.30)
                                levelButton(level: 7,  x: imageWidth * 0.7, y: imageHeight * 0.38)
                                levelButton(level: 6,  x: imageWidth * 0.3, y: imageHeight * 0.45)
                                levelButton(level: 5,  x: imageWidth * 0.7, y: imageHeight * 0.50)
                                levelButton(level: 4,  x: imageWidth * 0.3, y: imageHeight * 0.58)
                                levelButton(level: 3,  x: imageWidth * 0.7, y: imageHeight * 0.66)
                                levelButton(level: 2,  x: imageWidth * 0.3, y: imageHeight * 0.73)
                                levelButton(level: 1,  x: imageWidth * 0.7, y: imageHeight * 0.80)
                                    .id("level1")
                            }
                            .frame(width: imageWidth, height: imageHeight)
                        }
                        .scrollContentBackground(.hidden)
                        .ignoresSafeArea(edges: .all)
                        .onAppear {
                            withAnimation {
                                proxy.scrollTo("level1", anchor: .center)
                            }
                        }
                    }
                }

                // ✅ البار السفلي
                BottomNavBar(currentTab: .map, progressVM: progressVM)
                    .navigationBarBackButtonHidden(true)

            }
            .background(
                NavigationLink(
                    destination: selectedScenario.map {
                        ScenarioLevelView(scenario: $0, progressVM: progressVM)
                            .environment(\.layoutDirection, .rightToLeft)
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
            .ignoresSafeArea()
        }
    }

    @ViewBuilder
    func levelButton(level: Int, x: CGFloat, y: CGFloat) -> some View {
        let isUnlocked = progressVM.totalPoints >= (level - 1) * 10

        ZStack {
            // زر غير ظاهر يفتح فقط إذا unlocked
            Button(action: {
                if isUnlocked {
                    selectedScenario = scenarios.first(where: { $0.level == level })
                }
            }) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 80, height: 80)
            }
            .disabled(!isUnlocked)

            // قفل مع تغبيش إذا مقفول
            if !isUnlocked {
                Circle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "lock.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                    )
            }
        }
        .position(x: x, y: y)
    }

    func getImageHeight(forWidth width: CGFloat) -> CGFloat {
        guard let uiImage = UIImage(named: "allLevelsBackground") else { return 0 }
        let aspectRatio = uiImage.size.height / uiImage.size.width
        return width * aspectRatio
    }
    
    func arabicNumber(_ num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")
        return formatter.string(from: NSNumber(value: num)) ?? "\(num)"
    }

}
