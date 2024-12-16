//
//  CreateCategoryView.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/11.
//

import SwiftUI
import SwiftData


@Model
class Category {
    @Attribute(.unique)
    var title: String
    
    var items: [ToDoItem] = []
    
    init(title: String = "") {
        self.title = title
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

struct CreateCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var title: String = ""
    @Query private var categories: [Category]
    
    var body: some View {
        Form {
            Section("Category Title") {
                TextField("Enter title here", text: $title)
                Button("Add Category") {
                    withAnimation {
                        modelContext.insert(Category(title: title))
                    }
                    title = ""
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .disabled(title.isEmpty)
            }
            
            Section("Categories") {
                ForEach(categories) { category in
                    Text(category.title)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    modelContext.delete(category)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    CreateCategoryView()
}
