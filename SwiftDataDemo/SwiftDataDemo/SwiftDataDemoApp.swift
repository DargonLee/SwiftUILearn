//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Harlans on 2024/12/12.
//

import SwiftUI

@main
struct SwiftDataDemoApp: App {
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Chat.self, Message.self])
    }
}
