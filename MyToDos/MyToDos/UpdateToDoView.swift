//
//  UpdateToDoView.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/10.
//

import SwiftUI
import SwiftData

struct UpdateToDoView: View {
    @Environment(\.dismiss) private var dismiss
    @Query private var categorys: [Category]
    @Bindable var item: ToDoItem
    @State private var category: Category?
    var body: some View {
        Form {
            TextField("Name", text: $item.title)
            DatePicker("Choose a date", selection: $item.timestamp)
            Toggle("Important?", isOn: $item.isCritical)
            Picker("", selection: $category) {
                ForEach(categorys) { category in
                    Text(category.title).tag(category)
                }
                Text("None").tag(nil as Category?)
            }
            Button("Update") {
                item.category = category
                dismiss()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Update ToDo")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            category = item.category
        }
    }
}
