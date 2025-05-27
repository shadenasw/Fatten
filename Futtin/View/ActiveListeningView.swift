import SwiftUI

struct ActiveListeningView: View {
    @StateObject private var viewModel = ScenarioViewModel()
    @State private var selectedScenario: Scenario? = nil
    @ObservedObject var progressVM: ProgressViewModel

    var currentTab: BottomNavTab
    var onTabSelected: (BottomNavTab) -> Void

    @Binding var showTabBar: Bool
    @State private var completedLevels: [Int] = []

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color("Background").ignoresSafeArea()

                VStack(spacing: 0) {
                    ScrollViewReader { scrollProxy in
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 6) {
                                ForEach((1...10).reversed(), id: \.self) { level in
                                    VStack(spacing: 10) {
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
                                                        .foregroundColor(
                                                            (completedLevels.contains(level) || level == nextAvailableLevel) ?
                                                            Color("LevelAvailable") :
                                                            Color("LevelUnavailable")
                                                        )


                                                        .font(.custom("Geeza Pro", size: 42).weight(.bold))
                                                )
                                        }
                                        .disabled(!canAccess(level: level))
                                        .id(level)

                                        if level != 1 {
                                            Image(lineImageName(for: level - 1))
                                                .resizable()
                                                .frame(width: 6, height: 28)
                                            Image(lineImageName(for: level - 1))
                                                .resizable()
                                                .frame(width: 6, height: 28)
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
                }

                NavigationLink(
                    destination: selectedScenario.map { scenario in
                        ListeningLevelView(
                            scenario: scenario,
                            onComplete: {
                                markLevelAsCompleted(level: scenario.level)
                            },
                            showTabBar: $showTabBar,
                            progressVM: progressVM
                        )
                    },
                    isActive: Binding<Bool>(
                        get: { selectedScenario != nil },
                        set: { if !$0 { selectedScenario = nil } }
                    )
                ) {
                    EmptyView()
                }
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }

    // ✅ المرحلة الحالية المكتملة
    var currentLevel: Int {
        completedLevels.max() ?? 0
    }

    // ✅ المرحلة الجاية المسموح بها
    var nextAvailableLevel: Int {
        currentLevel + 1
    }

    // ✅ الشروط
    func canAccess(level: Int) -> Bool {
        return level == 1 || level <= nextAvailableLevel
    }

    func lineImageName(for level: Int) -> String {
        return completedLevels.contains(level) ? "bluelevel" : "soundlevel"
    }

    func markLevelAsCompleted(level: Int) {
        if !completedLevels.contains(level) {
            completedLevels.append(level)
            completedLevels = completedLevels.sorted()
        }
    }

    func arabicNumber(_ num: Int) -> String {
        let englishToArabic = ["0":"٠", "1":"١", "2":"٢", "3":"٣", "4":"٤",
                               "5":"٥", "6":"٦", "7":"٧", "8":"٨", "9":"٩"]

        let numberStr = String(num)
        var arabicStr = ""

        for char in numberStr {
            arabicStr.append(englishToArabic[String(char)] ?? String(char))
        }

        return arabicStr
    }
}
