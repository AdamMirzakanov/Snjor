//
//  SearchResultAlbumsViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

import Foundation

struct SearchResultAlbumsViewModelItem {
  private(set) var album: Album
  
  var coverPhoto: URL? {
    album.regularURL
  }
}
