//
//  CachingAPIResponse.swift
//  MyToDos
//
//  Created by Harlans on 2024/12/16.
//

import SwiftUI
import SwiftData

@Model
final class PostModel: Codable, Identifiable {
    @Attribute(.unique)
    var id = UUID()
    var title: String
    var url: String
    var albumId: Int
    var thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case albumId
        case thumbnailUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albumId = try container.decode(Int.self, forKey: .albumId)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(albumId, forKey: .albumId)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
        try container.encode(thumbnailUrl, forKey: .thumbnailUrl)
    }
}

struct PostsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var posts: [PostModel]
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var hasFetched = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("正在加载...")
                } else if let errorMessage = errorMessage {
                    Text("加载失败: \(errorMessage)")
                    Button("重试") {
                        Task { await fetchPhotosSafely() }
                    }
                } else {
                    List {
                        ForEach(posts, id: \.id) { post in
                            PostRowView(post: post)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Posts")
            .task {
                if !hasFetched {
                    hasFetched = true
                    await fetchPhotosSafely()
                }
            }
        }
    }
}

#Preview {
    PostsView()
        .modelContainer(for: PostModel.self)
}

struct PostRowView: View {
    let post: PostModel
    
    var body: some View {
        VStack(alignment: .leading) {
            loadImage()
                .frame(maxWidth: .infinity)
                .frame(height: 300)
            
            Text(post.title)
                .font(.caption)
                .bold()
                .padding(.horizontal)
                .padding(.top)
        }
        .padding(.bottom)
    }
    
    // 异步加载图片
    @ViewBuilder
    private func loadImage() -> some View {
        AsyncImage(url: URL(string: post.thumbnailUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipped()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}

extension PostsView {
    func fetchPhotosSafely() async {
        do {
            try await fetchPhotos()
        } catch {
            errorMessage = error.localizedDescription
            print("Failed to fetch photos: \(error.localizedDescription)")
        }
    }
    
    func fetchPhotos() async throws {
        isLoading = true
        defer { isLoading = false }
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let photos = try JSONDecoder().decode([PostModel].self, from: data)
        photos.forEach { modelContext.insert($0) }
    }
}
