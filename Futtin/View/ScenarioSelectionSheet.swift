//
//  ScenarioSelectionSheet.swift
//  Futtin
//
//  Created by shaden  on 29/11/1446 AH.
//
import SwiftUI

struct ScenarioSelectionSheet: View {
    var onSelectText: () -> Void
    var onSelectAudio: () -> Void

    var body: some View {
        VStack(spacing: 4) {
            Text("اختر نوع السيناريو")
                .foregroundColor(.white)
                .font(.title3)
                .bold()
            

            Button(action: onSelectText) {
                ZStack {
                    Image("click")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, minHeight: 80)

                    Text(" سيناريو نصي")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
            }

            Button(action: onSelectAudio) {
                ZStack {
                    Image("click")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, minHeight: 80)

                    Text(" سيناريو صوتي")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
        .background(Color("Sheet")) // ← هذا المكان الصحيح
    }
}
