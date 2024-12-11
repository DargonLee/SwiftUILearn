//
//  ToDoItem.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/10.
//

import Foundation
import SwiftData

@Model
final class ToDoItem {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompledted: Bool
    
    init(
        title: String = "",
        timestamp: Date = .now,
        isCritical: Bool = false,
        isCompledted: Bool = false
    ) {
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isCompledted = isCompledted
    }
}
