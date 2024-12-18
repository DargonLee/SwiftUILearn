//
//  CreateView.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/10.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CreateToDoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    @State private var item = ToDoItem()
    @State private var category: Category?
    @State private var image: PhotosPickerItem?
    
    
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
                    if let uiImage = item.uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    }
                    
                    PhotosPicker(
                        selection: $image,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Label("Select an image", systemImage: "photo")
                            .symbolVariant(.fill)
                    }
                    
                    if (item.imageData != nil) {
                        Button(role: .destructive) {
                            withAnimation {
                                item.imageData = nil
                                image = nil
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                }
                Section {
                    Button("Create") {
                        save()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.automatic)
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
            .task(id: image) {
                if let data = try? await image?.loadTransferable(type: Data.self) {
                    item.imageData = data
                }
            }
        }
        .presentationDetents([.medium, .large])
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
