//
//  09AlignmentGuide.swift
//  SwiftUILearn
//
//  Created by Harlan on 2025/10/13.
//

import SwiftUI

struct _9AlignmentGuide: View {
    var body: some View {
        VStack(alignment: .leading) {
            rectangle
                .alignmentGuide(.leading) { d in
                    let defaultLeading = d[.leading]
                    let newLeading = defaultLeading + 30 // 加30 往左又多移动30像素
                    return newLeading
                }
            rectangle

        }
        .border(.red)
    }
    
    var rectangle: some View {
        Rectangle()
            .fill(.blue.gradient)
            .frame(width: 100, height: 100)
    }
}

#Preview {
    _9AlignmentGuide()
}
