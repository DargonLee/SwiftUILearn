//
//  ContentView.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/10.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showCreate = false
    @State private var showCatory = false
    @State private var toDoEdit: ToDoItem?
    @State private var search = ""
    
    @Query(
        sort: \ToDoItem.timestamp,
        order: .reverse
    ) private var items: [ToDoItem]
    
    private var filteredItems: [ToDoItem] {
        if search.isEmpty {
            return items
        }
        let fileters = items.compactMap { item in
            let titleQuery = item.title.range(of: search, options: .caseInsensitive) != nil
            return titleQuery ? item : nil
        }
        return fileters
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredItems) { item in
                    ToDoItemRow(item: item) { item in
                        toDoEdit = item
                    }
                }
            }
            .navigationTitle("To Do List")
            .searchable(text: $search, prompt: "Search for a to do or a category")
            .overlay {
                if !search.isEmpty && filteredItems.isEmpty {
                    ContentUnavailableView.search
                }else if search.isEmpty && filteredItems.isEmpty {
                    ContentUnavailableView("No To do list", systemImage: "list.bullet")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showCreate.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showCatory.toggle()
                    }, label: {
                        Label("Add Catory", systemImage: "folder.badge.plus")
                    })
                }
            }
            .sheet(isPresented: $showCreate) {
                CreateToDoView()
            }
            .sheet(isPresented: $showCatory) {
                CreateCategoryView()
            }
            .sheet(item: $toDoEdit) {
                toDoEdit = nil
            } content: { item in
                UpdateToDoView(item: item)
                    .presentationDetents([.medium])
            }

        }
    }
}

struct ToDoItemRow: View {
    @Environment(\.modelContext) private var modelContext
    let item: ToDoItem
    let editItemAction: (ToDoItem) -> Void
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if item.isCritical {
                    Image(systemName: "exclamationmark.3")
                        .symbolVariant(.fill)
                }
                
                Text(item.title)
                    .font(.title)
                    .bold()
                
                Text(item.timestamp, style: .date)
                    .font(.callout)
                
                if let category = item.category {
                    Text(category.title)
                        .font(.callout)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    item.isCompledted.toggle()
                }
            } label: {
                Image(systemName: "checkmark")
                    .symbolVariant(.circle.fill)
                    .foregroundColor(item.isCritical ? .green : .gray)
                    .font(.largeTitle)
            }
            .buttonStyle(.plain)
        }
        .swipeActions {
            Button(role: .destructive) {
                withAnimation {
                    modelContext.delete(item)
                }
            } label: {
                Label("Delete", systemImage: "trash")
                    .symbolVariant(.fill)
            }
            
            Button {
                editItemAction(item)
            } label: {
                Label("Edit", systemImage: "pencil")
                    .symbolVariant(.fill)
            }
            .tint(.orange)
        }
    }
}

#Preview {
    ContentView()
}
