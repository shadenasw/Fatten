//
//  TimeoutBanner.swift
//  Qiyam
//
//  Created by Lana Alyahya on 12/05/2025.
//

import SwiftUI
struct TimeoutBanner: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "clock")
                .font(.system(size: 22))
                .foregroundColor(.white)
                .padding()
                .background(Color.gray)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text("لم تتفاعل!")
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("أعِد الاستماع وحاول مرة أخرى")
                    .foregroundColor(.black)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(18)
        .padding(.top, 60)
        .padding(.horizontal)
    }
}
