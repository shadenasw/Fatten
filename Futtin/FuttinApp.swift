

import SwiftUI

@main
struct FuttinApp: App {
    @StateObject private var progressVM = ProgressViewModel()
    @StateObject private var scenarioVM = ScenarioViewModel()

    var body: some Scene {
        WindowGroup {
            TextSenarioView(progressVM: progressVM, scenarioVM: scenarioVM)
        }
    }
}
