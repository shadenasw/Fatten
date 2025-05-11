//
//  FailBanner.swift
//  Qiyam
//
//  Created by Lana Alyahya on 11/05/2025.
//


import SwiftUI

struct FailBanner: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "xmark.octagon.fill")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 30, height: 30)

            VStack(alignment: .trailing, spacing: 2) {
                Text("قاطعت بدري 😅")
                    .bold()
                    .foregroundColor(.black)

                Text("حاول تركّز أكثر في المرة الجاية.")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.7))
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(20)
        .padding(.top, 50)
        .padding(.horizontal, 20)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}
