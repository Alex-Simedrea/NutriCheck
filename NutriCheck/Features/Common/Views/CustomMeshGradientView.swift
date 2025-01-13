//
//  CustomMeshGradientView.swift
//  NutriCheck
//
//  Created by Alexandru Simedrea on 15.12.2024.
//


import SwiftUI

struct CustomMeshGradientView: View {
    @State var t: Float = 0.0
    @State var timer: Timer?

    var body: some View {
        MeshGradient(width: 3, height: 3, points: [
            .init(0, 0), .init(0.5, 0), .init(1, 0),
            [sinInRange(-0.8...(-0.2), offset: 0.439, timeScale: 0.342, t: t), sinInRange(0.3...0.7, offset: 3.42, timeScale: 0.984, t: t)],
            [sinInRange(0.1...0.8, offset: 0.239, timeScale: 0.084, t: t), sinInRange(0.2...0.8, offset: 5.21, timeScale: 0.242, t: t)],
            [sinInRange(1.0...1.5, offset: 0.939, timeScale: 0.084, t: t), sinInRange(0.4...0.8, offset: 0.25, timeScale: 0.642, t: t)],
            .init(0, 1), .init(0.5, 1), .init(1, 1)
        ], colors: [
            Color(hex: "#5b8bcc"), // Blue
            Color(hex: "#5b8bcc"), // Blue
            Color(hex: "#af65d5"), // Purple
            Color(hex: "#cc5f59"), // Red
            Color(hex: "#d2a95c"), // Gold
            Color(hex: "#5b8bcc"), // Blue
            Color(hex: "#5b8bcc"), // Blue
        ])
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                t += 0.02
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
        .background(Color(hex: "#af65d5"))
    }

    func sinInRange(_ range: ClosedRange<Float>, offset: Float, timeScale: Float, t: Float) -> Float {
        let amplitude = (range.upperBound - range.lowerBound) / 2
        let midPoint = (range.upperBound + range.lowerBound) / 2
        return midPoint + amplitude * sin(timeScale * t + offset)
    }
}

#Preview {
    CustomMeshGradientView()
}
