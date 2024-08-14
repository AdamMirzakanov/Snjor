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
extension Topic {
  var coverPhotoURL: URL? {
    return self.coverPhoto.urls.regular
  }
}
