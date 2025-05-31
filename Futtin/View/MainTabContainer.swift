import SwiftUI

struct MainTabContainer: View {
    @StateObject var progressManager = ScenarioProgressViewModel()

    @StateObject private var progressVM = ProgressViewModel()
    @StateObject private var scenarioVM = ScenarioViewModel() // ✅ أضف هذا

    var body: some View {
        NavigationStack {
            TextSenarioView(progressVM: progressVM, scenarioVM: scenarioVM) // ✅ مرره هنا
        }
        .ignoresSafeArea()
    }
}
