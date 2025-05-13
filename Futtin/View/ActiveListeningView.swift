


import SwiftUI

struct ActiveListeningView: View {
    @StateObject private var viewModel = ScenarioViewModel()
    @State private var selectedScenario: Scenario? = nil
    @StateObject private var progressVM = ProgressViewModel()

    @State private var completedLevels: [Int] = [1]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color("Background").ignoresSafeArea()

                ScrollViewReader { scrollProxy in
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            ForEach((1...10).reversed(), id: \.self) { level in
                                VStack(spacing: 4) {
                                    Button(action: {
                                        if let scenario = viewModel.scenario(for: level) {
                                            selectedScenario = scenario
                                        }
                                    }) {
                                        Image(completedLevels.contains(level) ? "circlelevel" : "greylevel")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .overlay(
                                                Text(arabicNumber(level))
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 40, weight: .bold))
                                            )
                                    }
                                    .disabled(!canAccess(level: level))
                                    .id(level)

                                    if level != 10 && level != 1 {
                                        Image(lineImageName(for: level))
                                            .resizable()
                                            .frame(width: 6, height: 28)
                                        Image(lineImageName(for: level))
                                            .resizable()
                                            .frame(width: 6, height: 28)
                                    } else if level == 1 {
                                        // بدون خطوط تحت 1
                                        EmptyView()
                                    }
                                }
                            }

                            Spacer(minLength: 100)
                        }
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            scrollProxy.scrollTo(1, anchor: .center)
                        }
                    }
                }

                NavigationLink(
                    destination: Group {
                        if let scenario = selectedScenario {
                            ListeningLevelView(scenario: scenario, onComplete: {
                                markLevelAsCompleted(level: scenario.level)
                            })
                        } else {
                            EmptyView()
                        }
                    },
                    isActive: Binding<Bool>(
                        get: { selectedScenario != nil },
                        set: { if !$0 { selectedScenario = nil } }
                    )
                ) {
                    EmptyView()
                }

                BottomNavBar(currentTab: .customize, progressVM: progressVM)
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }

    func canAccess(level: Int) -> Bool {
        completedLevels.contains(level) || level == nextAvailableLevel()
    }

    func nextAvailableLevel() -> Int {
        (completedLevels.max() ?? 0) + 1
    }

    func markLevelAsCompleted(level: Int) {
        if !completedLevels.contains(level) {
            completedLevels.append(level)
            completedLevels = completedLevels.sorted()
        }
    }

    func lineImageName(for level: Int) -> String {
        completedLevels.contains(level) ? "bluelevel" : "soundlevel"
    }

    func arabicNumber(_ num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")
        return formatter.string(from: NSNumber(value: num)) ?? "\(num)"
    }
}
