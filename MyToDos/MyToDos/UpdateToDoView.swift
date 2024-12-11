//
//  UpdateToDoView.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/10.
//

import SwiftUI

struct UpdateToDoView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var item: ToDoItem
    var body: some View {
        Form {
            TextField("Name", text: $item.title)
            DatePicker("Choose a date", selection: $item.timestamp)
            Toggle("Important?", isOn: $item.isCritical)
            Button("Update") {
                dismiss()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .buttonStyle(.borderedProminent)
        }
    }
}
