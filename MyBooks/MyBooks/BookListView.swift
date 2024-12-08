//
//  ContentView.swift
//  MyBooks
//
//  Created by Harlans on 2024/12/8.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \Book.title) private var books: [Book]
    @State private var createNewBook = false

    var body: some View {
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView("Enter your first book.", systemImage: "book.fill")
                }else {
                    List {
                        ForEach(books) { book in
//                            NavigationLink {
////                                EditBookView(book: book)
//                            } label: {
                                HStack(spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading) {
                                        Text(book.title).font(.title2)
                                        Text(book.author).foregroundStyle(.secondary)
                                        if let rating = book.rating {
                                            HStack {
                                                ForEach(1..<rating, id: \.self) { _ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
//                            }
                            
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let book = books[index]
                                modelContext.delete(book)
                            }
                        }
                    }
                    .listStyle(.plain)
                }

            }
            .navigationTitle("My Books")
            .toolbar {
                Button {
                    createNewBook = true
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    BookListView()
}
