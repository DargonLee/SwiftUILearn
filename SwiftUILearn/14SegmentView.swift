//
//  14SegmentView.swift
//  SwiftUILearn
//
//  Created by Harlan on 2025/11/6.
//

import SwiftUI

enum SegmentType: String, CaseIterable, Identifiable {
    case day = "日"
    case week = "周"
    case month = "月"
    
    var id: String { rawValue }
}

struct _4SegmentView: View {
    @State private var selection: SegmentType = .day
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Segment", selection: $selection) {
                ForEach(SegmentType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            
            Text("当前选择：\(selection.rawValue)")
                .font(.title3)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    _4SegmentView()
}
