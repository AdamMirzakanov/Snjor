//
//  Album.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import Foundation

struct Album: Decodable, Hashable {
  let id: String
  let title: String
  let previewPhotos: [AlbumPreviewPhoto]?
  let totalPhotos: Int
  let tags: [Tag]?
  let description: String?
}

// MARK: - ViewModelItemRepresentable
extension Album: ViewModelItemRepresentable {
  var regularURL: URL? {
    return self.previewPhotos?[.zero].urls.regular
  }
}

// MARK: - Downloadable
extension Album: Downloadable {
  var downloadURL: URL? {
    return self.previewPhotos?[.zero].urls.full
  }
}
