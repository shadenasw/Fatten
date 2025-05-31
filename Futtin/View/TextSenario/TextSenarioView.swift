import SwiftUI
import AVFoundation

struct TextSenarioView: View {
    @ObservedObject var progressVM: ProgressViewModel
    @StateObject private var progressManager = ScenarioProgressViewModel()
    @ObservedObject var scenarioVM: ScenarioViewModel

    @State private var showFireworks = false
    @State private var celebrationPlayer: AVAudioPlayer?

    @State private var showScenarioSheet = false
    @State private var selectedLevel: Int? = nil
    @State private var selectedScenarioType: ScenarioType? = nil
    @State private var navigateToScenario = false
    @State private var shouldDismissSheet = false

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

                if showFireworks {
                    ConfettiView()
                        .ignoresSafeArea()
                        .transition(.scale)
                        .zIndex(1)
                }

                

                NavigationLink(
                    destination: destinationView(),
                    isActive: $navigateToScenario,
                    label: { EmptyView() }
                )
                .onChange(of: navigateToScenario) { isActive in
                    if isActive {
                        shouldDismissSheet = true
                        showScenarioSheet = false
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showScenarioSheet) {
                ZStack {
                    Color("Sheet").ignoresSafeArea()

                    if let level = selectedLevel {
                        let progress = progressManager.levelProgressList.first(where: { $0.level == level })

                        ScenarioSelectionSheet(
                            level: level,
                            didCompleteText: progress?.didCompleteText ?? false,
                            didCompleteAudio: progress?.didCompleteAudio ?? false,

                            onSelectText: {
                                selectedScenarioType = .text
                                navigateToScenario = true
                            },

                            onSelectAudio: {
                                selectedScenarioType = .audio
                                navigateToScenario = true
                            }
                        )
                        .presentationDetents([.height(280)])
                    }
                }
            }
            .onChange(of: navigateToScenario) { isActive in
                if !isActive && !shouldDismissSheet {
                    showScenarioSheet = true
                }
            }
        }
    }

    func checkIfBothCompleted(for level: Int) {
        let progress = progressManager.levelProgressList.first { $0.level == level }

        if (progress?.didCompleteText ?? false) && (progress?.didCompleteAudio ?? false) {
            let nextLevel = level + 1
            if nextLevel <= 10 {
                progressManager.unlockNextLevel(nextLevel)
            }

            playCelebrationSound()
            showFireworks = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                showFireworks = false
            }
        }
    }


    func playCelebrationSound() {
        if let path = Bundle.main.path(forResource: "fireworks", ofType: "mp3") {
            do {
                celebrationPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                celebrationPlayer?.play()
            } catch {
                print("❌ فشل تشغيل صوت الاحتفال")
            }
        } else {
            print("❌ ملف fireworks.mp3 غير موجود في المشروع")
        }
    }

    @ViewBuilder
    func destinationView() -> some View {
        if let level = selectedLevel, let scenarioType = selectedScenarioType {
            switch scenarioType {
            case .text:
                if let scenario = scenarios.first(where: { $0.level == level }) {
                    ScenarioLevelView(scenario: scenario, progressVM: progressVM, onComplete: {
                        progressManager.completeTextScenario(for: level)
                        checkIfBothCompleted(for: level)
                        navigateToScenario = false
                        shouldDismissSheet = false
                    })
                    .environment(\.layoutDirection, .rightToLeft)
                } else {
                    Text("السيناريو النصي غير موجود")
                }

            case .audio:
                if let scenario = scenarioVM.audioScenarios.first(where: { $0.level == level }) {
                    ListeningLevelView(
                        scenario: scenario,
                        onComplete: {
                            progressManager.completeAudioScenario(for: level)
                            checkIfBothCompleted(for: level)
                            navigateToScenario = false
                            shouldDismissSheet = false
                        },
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
        let isUnlocked = progressManager.isLevelUnlocked(level)

        ZStack {
            if isUnlocked {
                Button {
                    selectedLevel = level
                    showScenarioSheet = true
                    shouldDismissSheet = false
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
