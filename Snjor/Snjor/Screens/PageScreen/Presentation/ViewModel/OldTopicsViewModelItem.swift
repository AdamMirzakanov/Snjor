//
//  OldTopicsViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 28.07.2024.
//

import Foundation

struct OldTopicsViewModelItem {
  
  private(set) var topic: Topic
  
  var topicTitle: String {
    topic.title
  }
  
  var topicID: String {
    topic.id
  }
  
  var coverPhoto: URL? {
    topic.regularURL
  }
}
