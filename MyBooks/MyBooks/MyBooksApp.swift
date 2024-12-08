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
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))

    }
    
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self)
    }
}
