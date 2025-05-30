import SwiftUI

struct TextSenarioView: View {
    @ObservedObject var progressVM: ProgressViewModel
    @State private var showScenarioSheet = false
    @State private var selectedLevel: Int? = nil
    @State private var selectedScenarioType: ScenarioType? = nil
    @State private var navigateToScenario = false
    @ObservedObject var scenarioVM: ScenarioViewModel


    enum ScenarioType {
        case text, audio
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background").ignoresSafeArea()

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

                                ForEach(1...10, id: \.self) { level in
                                    let x = level % 2 == 0 ? imageWidth * 0.3 : imageWidth * 0.7
                                    let y = imageHeight * (0.18 + 0.07 * Double(10 - level))
                                    levelButton(level: level, x: x, y: y)
                                }
                            }
                            .frame(width: imageWidth, height: imageHeight)
                        }
                        .scrollContentBackground(.hidden)
                        .onAppear {
                            withAnimation {
                                proxy.scrollTo("level1", anchor: .center)
                            }
                        }
                    }
                }

                NavigationLink(
                    destination: destinationView(),
                    isActive: $navigateToScenario,
                    label: { EmptyView() }
                )
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showScenarioSheet) {
                ScenarioSelectionSheet(
                    onSelectText: {
                        selectedScenarioType = .text
                        showScenarioSheet = false
                        navigateToScenario = true
                    },
                    onSelectAudio: {
                        selectedScenarioType = .audio
                        showScenarioSheet = false
                        navigateToScenario = true
                    }
                )
                .presentationDetents([.height(220)])
            }
        }
    }

    @ViewBuilder
    func destinationView() -> some View {
        if let level = selectedLevel, let scenarioType = selectedScenarioType {
            switch scenarioType {
            case .text:
                if let scenario = scenarios.first(where: { $0.level == level }) {
                    ScenarioLevelView(scenario: scenario, progressVM: progressVM)
                        .environment(\.layoutDirection, .rightToLeft)
                } else {
                    Text("السيناريو النصي غير موجود")
                }

            case .audio:
                if let scenario = scenarioVM.audioScenarios.first(where: { $0.level == level }) {

                    ListeningLevelView(
                        scenario: scenario,
                        onComplete: { },
                        showTabBar: .constant(false),
                        progressVM: progressVM
                    )
                } else {
                    Text("السيناريو الصوتي غير موجود")
                }
            }
        } else {
            EmptyView()
        }
    }


    @ViewBuilder
    func levelButton(level: Int, x: CGFloat, y: CGFloat) -> some View {
        let isUnlocked = progressVM.totalPoints >= (level - 1) * 10

        ZStack {
            if isUnlocked {
                Button {
                    selectedLevel = level
                    showScenarioSheet = true
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 80, height: 80)
                }
            } else {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Circle()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .bold))
                            )
                    )
            }
        }
        .position(x: x, y: y)
        .id(level == 1 ? "level1" : nil)
    }

    func getImageHeight(forWidth width: CGFloat) -> CGFloat {
        guard let uiImage = UIImage(named: "allLevelsBackground") else { return 0 }
        let aspectRatio = uiImage.size.height / uiImage.size.width
        return width * aspectRatio
    }
}
