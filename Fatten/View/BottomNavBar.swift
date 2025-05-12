//
//  BottomNavBar.swift
//  Fatten
//
//  Created by layan alwasaidi on 11/05/2025.
//
import SwiftUI

enum BottomNavTab {
    case map
    case award
    case customize
}

struct BottomNavBar: View {
    var currentTab: BottomNavTab
    @ObservedObject var progressVM: ProgressViewModel  // ✅ أضفناها

    var body: some View {
        VStack {
            Spacer()

            HStack {
                // زر الجوائز
                NavigationLink(destination: ProgressViewScreen(progressVM: progressVM).navigationBarBackButtonHidden(true)) {
                    Image(systemName: "rosette")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(currentTab == .award ? .blue : Color("TextBar"))
                }

                Spacer()

                // زر الخريطة
                NavigationLink(destination: TextSenarioView().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "map")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(currentTab == .map ? .blue : Color("TextBar"))
                }

                Spacer()

                // زر التخصيص
                NavigationLink(destination: ActiveListeningView().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(currentTab == .customize ? .blue : Color("TextBar"))
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)

            .background(Color(.systemGray)) // غماق اللون

            .background(Color("TabBar")) // غماق اللون
            .cornerRadius(0)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
