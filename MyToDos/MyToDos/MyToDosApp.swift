//
//  MyToDosApp.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/10.
//

import SwiftUI
import SwiftData

@main
struct MyToDosApp: App {
    let container: ModelContainer
    init() {
        do {
            container = try ToDoItemContainer.container()
        } catch {
            fatalError("初始化 ModelContainer 失败: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
