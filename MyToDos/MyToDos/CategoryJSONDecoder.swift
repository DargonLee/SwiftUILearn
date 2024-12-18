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

struct ToDoResponse: Decodable {
    let title: String
    let isCritical: Bool
    let isCompleted: Bool
    let category: CategoryResponse?
    
    enum CodingKeys: String, CodingKey {
        case title
        case isCritical
        case isCompleted
        case category
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        isCritical = try container.decode(Bool.self, forKey: .isCritical)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        category = try container.decodeIfPresent(CategoryResponse.self, forKey: .category)
    }
}

// MARK: - CategoryJSONDecoder
struct CategoryJSONDecoder {
    static func decode(from fileName: String) -> [CategoryResponse] {
        JSONDecoderHelper.decode(from: fileName, as: [CategoryResponse].self) ?? []
    }
}

// MARK: - ToDoJSONDecoder
struct ToDoJSONDecoder {
    static func decode(from fileName: String) -> [ToDoResponse] {
        JSONDecoderHelper.decode(from: fileName, as: [ToDoResponse].self) ?? []
    }
}


struct JSONDecoderHelper {
    static func decode<T: Decodable>(from fileName: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("❌ Error: Unable to find file named \(fileName).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("❌ Decoding error: \(error.localizedDescription)")
            return nil
        }
    }
}
