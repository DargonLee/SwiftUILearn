//
//  PhotoModel.swift
//  DownloadImages
//
//  Created by Harlan on 2025/10/11.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
