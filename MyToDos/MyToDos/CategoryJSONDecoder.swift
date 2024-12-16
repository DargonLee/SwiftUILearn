//
//  CategoryJSONDecoder.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/16.
//

import Foundation

struct CategoryResponse: Decodable {
    let title: String
}

struct CategoryJSONDecoder {
    static func decode(from fileName: String) -> [CategoryResponse] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
        }
        
        let categorys = try? JSONDecoder().decode([CategoryResponse].self, from: data)
        return categorys ?? []
    }
}
