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

    var body: some View {
        VStack {
            Spacer()

            HStack {
                // زر الجوائز
                NavigationLink(destination: ProgressView().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "rosette")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(currentTab == .award ? .blue : .white)
                }

                Spacer()

                // زر الخريطة
                NavigationLink(destination: TextSenarioView().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "map")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(currentTab == .map ? .blue : .white)
                }

                Spacer()

                // زر التخصيص
                NavigationLink(destination: ActiveListeningView().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(currentTab == .customize ? .blue : .white)
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray)) // غماق اللون
            .cornerRadius(0)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .frame(maxHeight: .infinity, alignment: .bottom) // ✅ لاصق تمامًا بأسفل الشاشة
    }
}
