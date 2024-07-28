//
//  05ScrollView.swift
//  SwiftUILearn
//
//  Created by Harlans on 2024/7/28.
//

import SwiftUI

struct _51ScrollView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("monday, aug20".uppercased())
                    Text("Your Reading")
                        .font(.title)
                        .fontWeight(.black)
                }
                Spacer()
            }
            .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    Group {
                        CordView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
                        CordView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Gabriel Theodoropoulos")
                        CordView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Lawrence Tan")
                        CordView(image: "natural-language-api", category: "iOS", heading: "What's New in Natural Language API", author: "Sai Kambampati")
                    }.frame(width: 300)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    _51ScrollView()
}


struct _5ScrollView: View {
    var body: some View {
        ScrollView() {
            HStack {
                VStack(alignment: .leading) {
                    Text("monday, aug20".uppercased())
                    Text("Your Reading")
                        .font(.title)
                        .fontWeight(.black)
                }
                Spacer()
            }
            .padding(.leading)
            VStack {
                CordView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
                CordView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Gabriel Theodoropoulos")
                CordView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Lawrence Tan")
                CordView(image: "natural-language-api", category: "iOS", heading: "What's New in Natural Language API", author: "Sai Kambampati")
            }
        }
    }
}

struct CordView: View {
    var image: String
    var category: String
    var heading: String
    var author: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable() // 修饰符使得图像可以根据其父视图的大小进行缩放
                .aspectRatio(contentMode: .fit) // 设置图像的纵横比
            HStack {
                VStack(alignment: .leading) {
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text("Written by \(author)".uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        }
        .padding([.top, .horizontal])
    }
}

#Preview {
    _5ScrollView()
}
