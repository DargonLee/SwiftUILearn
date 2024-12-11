//
//  CreateView.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/10.
//

import SwiftUI

struct CreateToDoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var item = ToDoItem()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $item.title)
                DatePicker("Choose a date", selection: $item.timestamp)
                Toggle("Important?", isOn: $item.isCritical)
                Button("Create") {
                    withAnimation {
                        modelContext.insert(item)
                    }
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
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

#Preview {
    CreateToDoView()
        .modelContainer(for: ToDoItem.self)
}
