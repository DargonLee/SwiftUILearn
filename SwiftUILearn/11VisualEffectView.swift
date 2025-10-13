//
//  11VisualEffectView.swift
//  SwiftUILearn
//
//  Created by Harlan on 2025/10/13.
//

import SwiftUI

struct _1VisualEffectView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<100) { index in
                    Rectangle()
                        .fill(index % 2 == 0 ? Color.blue : Color.green)
                        .frame(height: 100)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .visualEffect { content, geometry in
                            content
                                .offset(x: geometry.frame(in: .global).minY * 0.05)
//                                .blur(radius: geometry.size.width > 200 ? 10 : 0)
//                                .saturation(geometry.size.width > 200 ? 0 : 1)
                        }
                }
            }
        }
//        Text("Hello, World!sfasdfasdfasdfsdfasdfasdfasdfasdfsdaf")
//            .padding()
//            .background(.red)
//            .visualEffect { content, geometry in
//                content
//                    .grayscale(geometry.size.width > 200 ? 1 : 0)
//            }
    }
}

#Preview {
    _1VisualEffectView()
}
