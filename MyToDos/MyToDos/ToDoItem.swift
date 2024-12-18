//
//  ToDoItem.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/10.
//

import Foundation
import SwiftData
import UIKit

@Model
final class ToDoItem {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompledted: Bool
    
    // 使用 @Attribute(.externalStorage) 可以优化大文件存储
    @Attribute(.externalStorage)
    var imageData: Data?
    
    @Relationship(inverse: \Category.items)
    var category: Category?
    
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
    
    var uiImage: UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
}

extension ToDoItem {
    static var dummy: ToDoItem {
        .init(
            title: "Item1",
            timestamp: .now,
            isCritical: true
        )
    }
}
