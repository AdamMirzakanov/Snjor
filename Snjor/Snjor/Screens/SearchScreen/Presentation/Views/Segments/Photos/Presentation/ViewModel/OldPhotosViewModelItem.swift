//
//  OldPhotosViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 30.07.2024.
//

import Foundation

struct OldPhotosViewModelItem {
  private(set) var photo: Photo
  
  var photoURL: URL? {
    photo.regularURL
  }
}
