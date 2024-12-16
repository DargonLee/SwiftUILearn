//
//  ToDoItemRowView.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/16.
//

import SwiftUI

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