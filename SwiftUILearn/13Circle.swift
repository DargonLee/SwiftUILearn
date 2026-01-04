//
//  13Circle.swift
//  SwiftUILearn
//
//  Created by Harlan on 2025/11/5.
//

import SwiftUI

struct _3Circle: View {
    @State private var isScaled = false
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Circle()
                    .fill(.blue.gradient)
                    .frame(width: 200, height: 200)
                Circle()
                    .stroke(.red, lineWidth: 20)
                    .frame(width: 200, height: 200)
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .overlay {
                        Circle()
                            .stroke(.red, lineWidth: 15)
                    }
                    .frame(width: 200, height: 200)
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [.yellow, .orange, .red],
                            center: .center,
                            startRadius: 1,
                            endRadius: 50
                        )
                    )
                    .frame(width: 200, height: 200)
                ZStack {
                    Circle()
                        .stroke(.green, lineWidth: 25)
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(.blue, lineWidth: 25)
                        .rotationEffect(.degrees(-90))
                }
                .frame(width: 200, height: 200)
                Circle()
                    .fill(.purple)
                    .scaleEffect(isScaled ? 1.5 : 1.0)
                    .animation(.easeInOut(duration: 0.5), value: isScaled)
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        withAnimation {
                            isScaled.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isScaled = false
                            }
                        }
                    }
                Circle()
                    .fill(.pink)
                    .scaleOnTap(scale: 1.5, duration: 0.3)
                    .frame(width: 100, height: 100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ScaleOnTapModifier: ViewModifier {
    @State private var isScaled = false
    let scale: CGFloat
    let duration: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isScaled ? scale : 1.0)
            .animation(.easeInOut(duration: duration), value: isScaled)
            .onTapGesture {
                Task {
                    withAnimation(.easeInOut(duration: duration)) {
                        isScaled = true
                    }
                    
                    try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                    
                    withAnimation(.easeInOut(duration: duration)) {
                        isScaled = false
                    }
                }
            }
    }
}

extension View {
    func scaleOnTap(scale: CGFloat = 1.5, duration: Double = 0.3) -> some View {
        self.modifier(ScaleOnTapModifier(scale: scale, duration: duration))
    }
}

#Preview {
    _3Circle()
}
