import SwiftUI

struct MainTabContainer: View {
    @State private var currentTab: BottomNavTab = .map
    @StateObject private var progressVM = ProgressViewModel()
    @State private var showTabBar: Bool = true

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch currentTab {
                case .map:
                    TextSenarioView(
                        progressVM: progressVM,
                        showTabBar: $showTabBar,
                        currentTab: currentTab,
                        onTabSelected: { tab in currentTab = tab }
                       
                    )
                case .award:
                    ProgressViewScreen(
                        progressVM: progressVM,
                        showTabBar: $showTabBar,
                        currentTab: currentTab,
                        onTabSelected: { tab in currentTab = tab }
                    )

               
                case .customize:
                    ActiveListeningView(
                        progressVM: progressVM,
                        currentTab: currentTab,
                        onTabSelected: { tab in currentTab = tab },
                        showTabBar: $showTabBar
                    )

                }
            }
            .ignoresSafeArea()

            if showTabBar {
                BottomNavBar(
                    currentTab: currentTab,
                    progressVM: progressVM,
                    onTabSelected: { tab in
                        withAnimation(.easeInOut) {
                            currentTab = tab
                        }
                    }
                )
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(Color("TabBar"))
                .zIndex(1)
            }
        }
    }
}
