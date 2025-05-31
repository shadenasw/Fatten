//
//  ConfettiView.swift
//  Futtin
//
//  Created by Lana Alyahya on 31/05/2025.
//


import SwiftUI

struct ConfettiView: View {
    @State private var isAnimating = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<20) { i in
                    Circle()
                        .fill(randomColor())
                        .frame(width: 8, height: 8)
                        .position(x: CGFloat.random(in: 0...geo.size.width),
                                  y: isAnimating ? geo.size.height + 20 : -20)
                        .animation(
                            Animation.linear(duration: Double.random(in: 1.5...2.5))
                                .repeatForever(autoreverses: false)
                                .delay(Double.random(in: 0...0.5)),
                            value: isAnimating
                        )
                }
            }
            .onAppear {
                isAnimating = true
            }
        }
    }

    func randomColor() -> Color {
        let colors: [Color] = [.red, .blue, .green, .yellow, .pink, .purple, .orange]
        return colors.randomElement() ?? .white
    }
}
