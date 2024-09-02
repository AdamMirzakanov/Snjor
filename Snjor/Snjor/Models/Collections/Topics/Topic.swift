//
//  Topic.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import Foundation

struct Topic: Decodable, Hashable {
  
  // MARK: - Internal Properties
  let id: String
  let title: String
  let description: String
  let coverPhoto: TopicCoverPhoto
}

// MARK: - Extension
extension Topic: ViewModelItemRepresentable {
  var regularURL: URL? {
    return self.coverPhoto.urls.regular
  }
}

extension Topic: Downloadable {
  var downloadURL: URL? {
    return self.coverPhoto.urls.full
  }
}
