//
//  CreateView.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/10.
//

import SwiftUI
import SwiftData

struct CreateToDoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    @State private var item = ToDoItem()
    @State private var category: Category?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("To do title") {
                    TextField("Name", text: $item.title)
                    DatePicker("Choose a date", selection: $item.timestamp)
                    Toggle("Important?", isOn: $item.isCritical)
                }
                Section {
                    Picker("", selection: $category) {
                        ForEach(categories) { category in
                            Text(category.title).tag(category)
                        }
                        Text("None").tag(nil as Category?)
                    }
                    .labelsHidden()
                    .pickerStyle(.inline)
                }
                Section {
                    Button("Create") {
                        save()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Create ToDo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

extension CreateToDoView {
    func save() {
        modelContext.insert(item)
        item.category = category
        category?.items.append(item)
    }
}

#Preview {
    CreateToDoView()
        .modelContainer(for: ToDoItem.self)
}
