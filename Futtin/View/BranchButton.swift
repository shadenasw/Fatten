//
//  BranchButton.swift
//  Qiyam
//
//  Created by Lana Alyahya on 11/05/2025.
//


import SwiftUI
struct BranchButton: View {
    let title: String
    let action: () -> Void
    let activeBlue = Color.white

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .frame(width: 280, height: 45)
                .background(
                    ZStack {
                        activeBlue

                        RoundedRectangle(cornerRadius: 10)
                            .fill(activeBlue.opacity(0.5))
                            .offset(y: 4)
                            .blur(radius: 1)
                    }
                )
                .cornerRadius(10)
        }
    }
}
