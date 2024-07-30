//
//  PhotoListViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 30.07.2024.
//

import Foundation

struct PhotoListViewModelItem {
  private(set) var photo: Photo
  
  var photoURL: URL? {
    photo.regularURL
  }
}
