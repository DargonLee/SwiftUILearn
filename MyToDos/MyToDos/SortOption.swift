//
//  SortOption.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/16.
//

import Foundation

enum SortOption: String, CaseIterable {
    case title
    case date
    case category
}

extension SortOption {
    var systemImage: String {
        switch self {
            case .title:
                "textformat.size.larger"
            case .date:
                "calendar"
            case .category:
                "folder"
        }
    }
}
