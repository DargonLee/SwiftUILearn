//
//  Category.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/18.
//

import SwiftData

@Model
class Category: Codable {
    @Attribute(.unique)
    var title: String
    
    var items: [ToDoItem]?
    
    init(title: String = "") {
        self.title = title
    }
    
    enum CodingKeys: String, CodingKey {
        case title
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
    }
}

extension Category {
    static var defaults: [Category] {
        [
            .init(title: "Personal"),
            .init(title: "Work"),
            .init(title: "Study"),
        ]
    }
}
