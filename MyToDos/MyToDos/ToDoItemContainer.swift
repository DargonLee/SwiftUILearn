//
//  ToDoItemContainer.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/16.
//

import Foundation
import SwiftData

actor ToDoItemContainer {
    
    @MainActor
    static func container() throws -> ModelContainer {
        let schema = Schema([ToDoItem.self])
        let configuration = ModelConfiguration()
        do {
            let newContainer = try ModelContainer(
                for: schema,
                configurations: configuration
            )
            initializeDefaultCategorysData(in: newContainer)
            initializeDefaultToDosData(in: newContainer)
            return newContainer
            
        } catch {
            print("创建 ModelContainer 失败: \(error)")
            throw error
        }
    }
    
    @MainActor
    private static func initializeDefaultCategorysData(in container: ModelContainer) {
        let context = container.mainContext
        let descriptor = FetchDescriptor<Category>()
        guard (try? context.fetch(descriptor))?.isEmpty ?? true else {
            return
        }
        
        let categorys = CategoryJSONDecoder.decode(from: "CategoryDefautes")
        if categorys.count > 0 {
            categorys.forEach { item in
                let category = Category(title: item.title)
                context.insert(category)
            }
        }
        
        do {
            try context.save()
        } catch {
            print("保存默认数据失败: \(error)")
        }
    }
    
    @MainActor
    private static func initializeDefaultToDosData(in container: ModelContainer) {
        let context = container.mainContext
        let descriptor = FetchDescriptor<ToDoItem>()
        guard (try? context.fetch(descriptor))?.isEmpty ?? true else {
            return
        }
        
        let todos = ToDoJSONDecoder.decode(from: "DefaultsToDos")
        if todos.count > 0 {
            todos.forEach { item in
                let todo = ToDoItem(title: item.title, isCritical: item.isCritical, isCompledted: item.isCompleted)
                context.insert(todo)
            }
        }
        
        do {
            try context.save()
        } catch {
            print("保存默认数据失败: \(error)")
        }
    }
}

extension Date {
    static func randomDateNextWeek() -> Date? {
        let calendar = Calendar.current
        let now = Date()
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
        let randomDate = calendar.date(byAdding: .day, value: Int.random(in: 1...7), to: startOfWeek)
        return randomDate
    }
}
