//
//  CoverPhoto.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.08.2024.
//

import Foundation

struct PreviewPhoto: Decodable, Hashable {
  
  // MARK: - Internal Properties
  let slug: String
  let blurHash: String?
  let urls: PhotoUrls
}

struct PhotoUrls: Decodable, Hashable {
    let raw: URL
    let full: URL
    let thumb: URL
    let smallS3: URL
    let regular: URL
    let small: URL
}
