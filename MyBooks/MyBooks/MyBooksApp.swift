//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Harlans on 2024/12/8.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
    let container: ModelContainer
    init() {
        // 告诉 SwiftData 需要持久化哪些模型类型
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyBooks", schema: schema)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))

    }
    
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self)
    }
}
