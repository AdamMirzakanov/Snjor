//
//  Album.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import Foundation

struct Album: Decodable, Hashable {
  
  // MARK: - Internal Properties
  let id: String
  let title: String
  let previewPhotos: [AlbumPreviewPhoto]
  let totalPhotos: Int
  let tags: [Tag]?
}

// MARK: - Extension
extension Album: ViewModelItemRepresentable {
  var regularURL: URL? {
    return self.previewPhotos[.zero].urls.regular
  }
}

extension Album: Downloadable {
  var downloadURL: URL? {
    return self.previewPhotos[.zero].urls.full
  }
}
