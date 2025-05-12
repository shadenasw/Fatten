import SwiftUI

struct ActiveListeningView: View {
    @StateObject private var viewModel = ScenarioViewModel()
    @State private var selectedScenario: Scenario? = nil

    let completedLevels: [Int] = [1, 2, 3]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.black.ignoresSafeArea()

                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach((1...10).reversed(), id: \.self) { level in
                            VStack(spacing: 4) {
                                if level != 10 {
                                    Image(lineImageName(for: level + 1))
                                        .resizable()
                                        .frame(width: 6, height: 28)

                                    Image(lineImageName(for: level + 1))
                                        .resizable()
                                        .frame(width: 6, height: 28)
                                }

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
                            }
                        }

                        Spacer(minLength: 100) // مساحة تحت للبار
                    }
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity)
                }

                // ✅ التنقل التلقائي إلى مستوى الاستماع عند الاختيار
                NavigationLink(
                    destination: Group {
                        if let scenario = selectedScenario {
                            ListeningLevelView(scenario: scenario)
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

                // ✅ البار السفلي ثابت
                BottomNavBar(currentTab: .customize)
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.keyboard, edges: .bottom)
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
