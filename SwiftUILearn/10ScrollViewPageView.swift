//
//  10ScrollViewPageView.swift
//  SwiftUILearn
//
//  Created by Harlan on 2025/10/13.
//

import SwiftUI

struct _0ScrollViewPageView: View {
    @State var scrollPosition: Int? = nil
    var body: some View {
        VStack {
            Button("Scroll to 50") {
                scrollPosition = (0..<20).randomElement()
            }
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(0..<100) { index in
                        Rectangle()
                            .frame(width: 300, height: 200)
                            .overlay {
                                Text("Item \(index)")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 20)
                            .id(index)
                            .scrollTransition(
                                .interactive.threshold(.visible(0.9))
                            ) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.5)
                                    .offset(y: phase.isIdentity ? 0 : -100)
                            }
                    }
                }
            }
            .scrollTargetLayout()
            .scrollTargetBehavior(
                .viewAligned
            ) // viewAligned: 每个元素对齐到视图的顶部 paging: 分页
            .scrollBounceBehavior(.basedOnSize)
            .scrollPosition(id: $scrollPosition, anchor: .center)
            .animation(.smooth, value: scrollPosition)
        }
        
//        ScrollView {
//            VStack(spacing: 0) {
//                ForEach(0..<100) { index in
//                    Rectangle()
////                        .frame(width: 300, height: 200)
//                        .overlay {
//                            Text("Item \(index)")
//                                .font(.largeTitle)
//                                .bold()
//                                .foregroundColor(.white)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 20)
//                        .containerRelativeFrame(.vertical, alignment: .center)
//                }
//            }
//        }
//        .ignoresSafeArea()
//        .scrollTargetLayout()
//        .scrollTargetBehavior(.paging) // viewAligned: 每个元素对齐到视图的顶部 paging: 分页
//        .scrollBounceBehavior(.always)
    }
}

#Preview {
    _0ScrollViewPageView()
}
