//
//  08Alert.swift
//  SwiftUILearn
//
//  Created by Harlans on 2024/12/3.
//
import SwiftUI


struct AlertExample: View {
    // MARK: - Alert States
    @State private var showBasicAlert = false
    @State private var showConfirmationAlert = false
    @State private var showErrorAlert = false
    @State private var showCustomAlert = false
    
    // MARK: - Error Handling
    @State private var errorMessage: String?
    
    var body: some View {
        List {
            // 1. 基础 Alert
            Button("显示基础提示") {
                showBasicAlert = true
            }
            .alert("提示", isPresented: $showBasicAlert) {
                Button("确定") {}
            } message: {
                Text("这是一个基础提示")
            }
            
            // 2. 确认 Alert
            Button("显示确认提示") {
                showConfirmationAlert = true
            }
            .alert("确认删除", isPresented: $showConfirmationAlert) {
                Button("取消", role: .cancel) {}
                Button("删除", role: .destructive) {
                    // 执行删除操作
                }
            } message: {
                Text("确定要删除这条记录吗？此操作不可撤销。")
            }
            
            // 3. 错误 Alert
            Button("显示错误提示") {
                errorMessage = "网络连接失败，请稍后重试"
                showErrorAlert = true
            }
            .alert("错误", isPresented: $showErrorAlert) {
                Button("确定") {
                    errorMessage = nil
                }
                Button("重试") {
                    // 重试操作
                }
            } message: {
                Text(errorMessage ?? "未知错误")
            }
            
            // 4. 自定义操作 Alert
            Button("显示自定义提示") {
                showCustomAlert = true
            }
            .alert("选择操作", isPresented: $showCustomAlert) {
                Button("复制") {
                    // 复制操作
                }
                Button("分享") {
                    // 分享操作
                }
                Button("取消", role: .cancel) {}
            }
        }
    }
}

struct AlertExample2: View {
    @State private var showToast = false
    @State private var toastMessage = ""

    var body: some View {
        VStack {
            Button("Show Toast") {
                toastMessage = "This is a toast message"
                showToast.toggle()
            }
        }
        .alert(isPresented: $showToast) {
            Alert(
                title: Text(""),
                message: Text(toastMessage),
                dismissButton: .cancel()
            )
        }
        // 添加一些自定义样式来实现 Toast 的效果
        .alert(isPresented: $showToast) {
            Alert(
                title: Text("")
                    .font(.caption)
                    .foregroundColor(.white),
                message: Text(toastMessage)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(12) as? Text,
                dismissButton: .cancel()
            )
        }
    }
}

// MARK: - Preview
#Preview {
//    AlertExample()
    AlertExample2()
}
