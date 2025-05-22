import SwiftUI

struct TextSenarioView: View {
    @State private var selectedScenario: TextScenarios? = nil
    @ObservedObject var progressVM: ProgressViewModel

    var currentTab: BottomNavTab
    var onTabSelected: (BottomNavTab) -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                // 🔹 الخلفية
                Color("Background").ignoresSafeArea()

                // 🔹 الصورة والمحتوى
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

                                // ✅ أزرار المراحل
                                ForEach(1...10, id: \.self) { level in
                                    let x = level % 2 == 0 ? imageWidth * 0.3 : imageWidth * 0.7
                                    let y = imageHeight * (0.18 + 0.07 * Double(10 - level))
                                    levelButton(level: level, x: x, y: y)
                                }
                                .padding(.bottom, 70)
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
                VStack {
                    Spacer()
                    // 🔹 شريط التنقل السفلي ثابت دائمًا فوق كل شيء
                    BottomNavBar(
                        currentTab: currentTab,
                        progressVM: progressVM,
                        onTabSelected: onTabSelected
                    )
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                    .background(Color("TabBar"))
                    .zIndex(1)

            
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // ✅ يخلي البار يثبت تمامًا


                // 🔹 شريط التنقل السفلي مثبت دائمًا فوق كل شيء
              
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
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
        }

    }

    @ViewBuilder
    func levelButton(level: Int, x: CGFloat, y: CGFloat) -> some View {
        let isUnlocked = progressVM.totalPoints >= (level - 1) * 10

        ZStack {
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
        .id(level == 1 ? "level1" : nil)
    }

    func getImageHeight(forWidth width: CGFloat) -> CGFloat {
        guard let uiImage = UIImage(named: "allLevelsBackground") else { return 0 }
        let aspectRatio = uiImage.size.height / uiImage.size.width
        return width * aspectRatio
    }
}
