//
//  08SwiftData.swift
//  SwiftUILearn
//
//  Created by Harlans on 2024/12/12.
//

import SwiftUI
import SwiftData

// 消息发送者枚举
enum MessageSender: String, CaseIterable, Codable {
    case user
    case ai
}


// Chat 模型
@Model
final class Chat {
    var id: UUID
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Message.chat)
    var messages: [Message] = []

    init() {
        self.id = UUID()
        self.createdAt = Date()
    }
}

// Message 模型
@Model
final class Message {
    var id: UUID
    var content: String
    var timestamp: Date
    var sender: MessageSender
    var chat: Chat?

    init(content: String, sender: MessageSender, chat: Chat? = nil) {
        self.id = UUID()
        self.content = content
        self.timestamp = Date()
        self.sender = sender
        self.chat = chat
    }
}

// 主应用视图
struct SwiftDataContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var chats: [Chat]
    @State private var newMessageText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // 聊天列表
                List {
                    ForEach(chats, id: \.id) { chat in
                        NavigationLink(destination: ChatDetailView(chat: chat)) {
                            VStack(alignment: .leading) {
                                Text("Chat created at: \(chat.createdAt, style: .date)")
                                Text("Messages: \(chat.messages.count)")
                            }
                        }
                    }
                    .onDelete(perform: deleteChats)
                }
                
                // 创建新聊天按钮
                Button("New Chat") {
                    let newChat = Chat()
                    modelContext.insert(newChat)
                }
                .padding()
            }
            .navigationTitle("Chats")
            .toolbar {
                EditButton()
            }
        }
    }
    
    // 删除聊天的方法
    private func deleteChats(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(chats[index])
        }
    }
}

// 聊天详情视图
struct ChatDetailView: View {
    @Bindable var chat: Chat
    @Environment(\.modelContext) private var modelContext
    @State private var newMessageText = ""
    
    var body: some View {
        VStack {
            // 消息列表
            List {
                ForEach(chat.messages, id: \.id) { message in
                    HStack {
                        Text(message.content)
                            .foregroundColor(message.sender == .user ? .blue : .green)
                        Spacer()
                        Text(message.sender == .user ? "User" : "AI")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteMessages)
            }
            
            // 消息输入区域
            HStack {
                TextField("Enter message", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // 发送用户消息按钮
                Button(action: sendUserMessage) {
                    Image(systemName: "paperplane.fill")
                }
                .disabled(newMessageText.isEmpty)
                
                // 自动回复 AI 消息按钮
                Button(action: sendAIMessage) {
                    Image(systemName: "brain")
                }
                .disabled(newMessageText.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Chat Details")
    }
    
    // 发送用户消息
    private func sendUserMessage() {
        let userMessage = Message(content: newMessageText, sender: .user, chat: chat)
        modelContext.insert(userMessage)
        newMessageText = ""
    }
    
    // 模拟 AI 回复
    private func sendAIMessage() {
        let aiResponse = Message(content: "AI: I received '\(newMessageText)'", sender: .ai, chat: chat)
        modelContext.insert(aiResponse)
        newMessageText = ""
    }
    
    // 删除消息的方法
    private func deleteMessages(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(chat.messages[index])
        }
    }
}

// 预览支持
#Preview {
    // 创建预览的容器
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Chat.self, Message.self, configurations: config)
    
    // 创建一个示例聊天
    let chat = Chat()
    let message1 = Message(content: "Hello", sender: .user, chat: chat)
    let message2 = Message(content: "Hi there!", sender: .ai, chat: chat)
    
    // 将消息添加到聊天中
    container.mainContext.insert(chat)
    container.mainContext.insert(message1)
    container.mainContext.insert(message2)
    
    // 返回要预览的视图
    return SwiftDataContentView()
        .modelContainer(container)
}

// 聊天详情视图的预览
#Preview("Chat Detail") {
    // 创建预览的容器
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Chat.self, Message.self, configurations: config)
    
    // 创建一个示例聊天
    let chat = Chat()
    let message1 = Message(content: "用户消息示例", sender: .user, chat: chat)
    let message2 = Message(content: "AI回复示例", sender: .ai, chat: chat)
    
    // 将消息添加到聊天中
    container.mainContext.insert(chat)
    container.mainContext.insert(message1)
    container.mainContext.insert(message2)
    
    // 返回聊天详情视图
    return ChatDetailView(chat: chat)
        .modelContainer(container)
}
