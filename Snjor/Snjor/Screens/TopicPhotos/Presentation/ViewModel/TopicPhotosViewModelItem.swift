//
//  TopicPhotosViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import Foundation

struct TopicPhotosViewModelItem {
  private(set) var photo: Photo
  
  var photoURL: URL? {
    photo.regularURL
  }
}
