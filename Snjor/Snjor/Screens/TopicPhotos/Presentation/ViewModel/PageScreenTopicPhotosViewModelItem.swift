//
//  PageScreenTopicPhotosViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 28.07.2024.
//

import Foundation

struct PageScreenTopicPhotosViewModelItem {
  private(set) var photo: Photo
  
  var photoURL: URL? {
    photo.regularURL
  }
}
