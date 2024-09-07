//
//  TopicsAndAlbumsSection.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.08.2024.
//

enum TopicsAndAlbumsSection: Hashable {
  case topics
  case albums(String)
}

extension String {
  static let albumsSectionName = "Albums"
}
