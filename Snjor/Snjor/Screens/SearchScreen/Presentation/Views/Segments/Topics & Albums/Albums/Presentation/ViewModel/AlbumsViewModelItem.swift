//
//  AlbumsViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import Foundation

struct AlbumsViewModelItem {
  private(set) var album: Album
  
  var coverPhoto: URL? {
    album.regularURL
  }
}

