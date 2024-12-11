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
    @State private var toDoEdit: ToDoItem?
    @Query(
        sort: \ToDoItem.timestamp,
        order: .reverse
    ) private var items: [ToDoItem]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    ToDoItemRow(item: item) { item in
                        toDoEdit = item
                    }
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showCreate.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $showCreate) {
                CreateToDoView()
            }
            .sheet(item: $toDoEdit) {
                toDoEdit = nil
            } content: { item in
                UpdateToDoView(item: item)
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
