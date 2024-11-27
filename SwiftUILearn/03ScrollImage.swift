//
//  03ScrollImage.swift
//  SwiftUILearn
//
//  Created by Harlans on 2024/11/26.
//

import SwiftUI

struct ScrollImage: View {
    let image: ImageResource
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 20))
            .scrollTransition { content, phase in
                content
                    .scaleEffect(phase.isIdentity ? 1 : 0.5)
                    .opacity(phase.isIdentity ? 1 : 0.5)
            }
    }
}

struct _3ScrollImage: View {
    let images: [ImageResource] = [
        .flutterApp, .macosProgramming, .naturalLanguageApi
    ]
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(images, id: \.self) { image in
                    ScrollImage(image: image)
                        .frame(width: 200, height:200)
                }
            }
        }
        .padding()
    }
}

#Preview {
    _3ScrollImage()
}
