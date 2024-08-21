//
//  SearchResultPhotosViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import Foundation

struct SearchResultPhotosViewModelItem {
  private(set) var photo: Photo
  
  var photoURL: URL? {
    photo.regularURL
  }
}
