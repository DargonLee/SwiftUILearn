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
    @State private var selectedSort: SortOption = .title
    
    @Query(
        sort: \ToDoItem.timestamp,
        order: .reverse
    ) private var items: [ToDoItem]
    
    private var filteredItems: [ToDoItem] {
        if search.isEmpty {
            return items.sort(on: selectedSort)
        }
        let fileters = items.compactMap { item in
            let titleQuery = item.title.range(of: search, options: .caseInsensitive) != nil
            return titleQuery ? item : nil
        }
        return fileters.sort(on: selectedSort)
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
            .animation(.easeIn, value: filteredItems)
            .searchable(text: $search, prompt: "Search for a to do or a category")
            .overlay {
                if !search.isEmpty && filteredItems.isEmpty {
                    ContentUnavailableView.search
                }else if search.isEmpty && filteredItems.isEmpty {
                    ContentUnavailableView("Empty list", systemImage: "list.bullet")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu {
                        Picker("", selection:$selectedSort) {
                            ForEach(SortOption.allCases, id: \.rawValue) { option in
                                Label(option.rawValue.capitalized, systemImage: option.systemImage).tag(option)
                            }
                        }
                        .labelsHidden()
                    } label: {
                        Image(systemName: "ellipsis")
                            .symbolVariant(.circle)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showCatory.toggle()
                    }, label: {
                        Label("Add Catory", systemImage: "folder.badge.plus")
                    })
                }
                
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    showCreate.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.trailing, .bottom], 16)
                .background(.clear)
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

private extension [ToDoItem] {
    func sort(on option: SortOption) -> [ToDoItem] {
        switch option {
        case .title:
            return sorted { $0.title < $1.title }
        case .date:
            return sorted { $0.timestamp < $1.timestamp }
        case .category:
            return sorted { $0.category?.title ?? "" < $1.category?.title ?? "" }
        }
    }
}

#Preview {
    ContentView()
}
