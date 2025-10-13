//
//  DownloadImagesView.swift
//  DownloadImages
//
//  Created by Harlan on 2025/10/11.
//

import SwiftUI

struct DownloadingImageView: View {
    @State private var loader: ImageDownloadingViewModel
    
    init(url: String) {
        _loader = State(wrappedValue: ImageDownloadingViewModel(url: url))
    }
    
    var body: some View {
        ZStack {
            switch loader.downloadState {
            case .failed:
                Image(systemName: "xmark.octagon")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .clipShape(Circle())
            case .downloaded:
                Image(uiImage: loader.image ?? UIImage())
                    .resizable()
                    .clipShape(Circle())
            case .downloading:
                ProgressView()
            }
        }
    }
}
// PerformanceService
// SocialService
// CommonService
// CrashTrackerService
// LoggerService
struct DownloadImagesRow: View {
    let photo: PhotoModel
    
    var body: some View {
        HStack {
            DownloadingImageView(url: photo.url)
                .frame(width: 65, height: 65)
            VStack(alignment: .leading) {
                Text(photo.title)
                    .font(.headline)
                Text(photo.url)
                    .foregroundColor(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct DownloadImagesView: View {
    @State private var viewModel = DownloadImagesViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.photos) { photo in
                DownloadImagesRow(photo: photo)
            }
        }
    }
}

#Preview {
    DownloadImagesView()
}
