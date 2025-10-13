//
//  DownloadImagesViewModel.swift
//  DownloadImages
//
//  Created by Harlan on 2025/10/11.
//

import Foundation
import UIKit
import Combine

@Observable
class ImageDownloadingViewModel {
    enum DownloadState {
        case downloading, downloaded, failed
    }
    var downloadState: DownloadState = .downloading
    var image: UIImage? = nil
    var cancellables = Set<AnyCancellable>()
    let urlString: String
    
    init(url: String) {
        urlString = url
        downloadImage()
    }
    
    func downloadImage() {
        guard let url = URL(string: urlString) else {
            downloadState = .failed
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ UIImage(data: $0.data) })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.downloadState = .downloaded
                case .failure(let error):
                    self?.downloadState = .failed
                    print("Error downloading data: \(error)")
                }
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}

@Observable
class DownloadImagesViewModel {
    var photos: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService = PhotoModelDataService.instance
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photos
            .sink { [weak self] returnedPhotos in
                self?.photos = returnedPhotos
            }
            .store(in: &cancellables)
    }
}

