//
//  01Alignment.swift
//  SwiftUILearn
//
//  Created by Harlans on 2024/11/21.
//

import SwiftUI

struct AlignmentGuideDemo: View {
    var body: some View {
        VStack(alignment: .leading) {
            rectangle

            rectangle
                .alignmentGuide(.leading, computeValue: {  viewDimensions in
                    print("Width: \(viewDimensions.width)")
                    print("Height: \(viewDimensions.height)")
                                       
                    let defaultLeading = viewDimensions[.leading]
                    let newLeading = defaultLeading + 30
                    return newLeading
                })
            
            Button("Hello world"){}
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
        }
        .border(.pink)
    }
    
    var rectangle: some View {
        Rectangle()
            .fill(.blue.gradient)
            .frame(width: 100, height: 100)
    }
}

/// 自定义垂直对齐
extension VerticalAlignment {
    private enum Custom : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.bottom]
        }
    }
    
    static let custom = VerticalAlignment(Custom.self)
}

#Preview {
    AlignmentGuideDemo()
}
