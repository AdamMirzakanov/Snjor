//
//  TopicPhotoListViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 28.07.2024.
//

import Foundation

struct TopicPhotoListViewModelItem {
  private(set) var photo: Photo
  
  var photoURL: URL? {
    photo.regularURL
  }
}
