//
//  06MarkdownUI.swift
//  SwiftUILearn
//
//  Created by Harlans on 2024/11/25.
//

import SwiftUI
import MarkdownUI

// 1. 首先创建一个用于代码块的视图组件
struct CodeBlockView: View {
    let code: String
    @State private var isCopied = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(code)
                        .font(.system(.body, design: .monospaced))
                        .padding()
                }
                
                Button(action: {
                    UIPasteboard.general.string = code
                    isCopied = true
                    
                    // 2秒后重置复制状态
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isCopied = false
                    }
                }) {
                    Image(systemName: isCopied ? "checkmark.circle.fill" : "doc.on.doc")
                        .foregroundColor(isCopied ? .green : .blue)
                }
                .padding(.trailing)
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

// 2. 创建一个用于打字机效果的视图组件
struct TypingTextView: View {
    let fullText: String
    @State private var displayedText: String = ""
    @State private var contentHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            Markdown(displayedText)
                .markdownTheme(.gitHub) // 使用预设主题
                .background(
                    GeometryReader { geo -> Color in
                        DispatchQueue.main.async {
                            contentHeight = geo.size.height
                        }
                        return Color.clear
                    }
                )
        }
        .frame(height: contentHeight)
        .onAppear {
            animateText()
        }
    }
    
    private func animateText() {
        var currentIndex = 0
        let characters = Array(fullText)
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if currentIndex < characters.count {
                displayedText += String(characters[currentIndex])
                currentIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

// 3. 主视图
struct MarkdownContentView: View {
    let markdownText = """
    # 这是一个标题
    这是一段普通文本，包含**粗体**和*斜体*。
    
    下面是一段代码：
    ```swift
    func hello() {
        print("Hello, World!")
    }
    ```
    
    - 列表项 1
    - 列表项 2
    """
    
    @State private var isTypingComplete = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TypingTextView(fullText: markdownText)
                    .padding()
                
                // 示例代码块
                CodeBlockView(code: """
                func hello() {
                    print("Hello, World!")
                }
                """)
                .padding()
            }
        }
    }
}

// 4. 预览
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownContentView()
    }
}

// 5. 自定义 Markdown 解析器（用于分离代码块和普通文本）
class MarkdownParser {
    static func parseComponents(from text: String) -> [(type: String, content: String)] {
        // 这里需要实现 Markdown 解析逻辑
        // 返回解析后的组件数组，每个组件包含类型（普通文本/代码块）和内容
        // 这是一个简化示例
        return [(type: "text", content: text)]
    }
}

extension Theme {
    static var custom: Theme {
        Theme()
            .code {
                FontFamilyVariant(.monospaced)
                BackgroundColor(.secondary.opacity(0.1))
            }
            // 添加更多自定义样式
    }
}

