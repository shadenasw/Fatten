//
//  SuccessBanner.swift
//  Qiyam
//
//  Created by Lana Alyahya on 11/05/2025.
//


import SwiftUI

struct SuccessBanner: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .foregroundColor(.green)
                .frame(width: 30, height: 30)

            VStack(alignment: .trailing, spacing: 2) {
                Text("أحسنت !")
                    .bold()
                    .foregroundColor(.black)

                Text("قاطعت في اللحظة المناسبة")
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
        .transition(.move(edge: .top).combined(with: .opacity))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}
