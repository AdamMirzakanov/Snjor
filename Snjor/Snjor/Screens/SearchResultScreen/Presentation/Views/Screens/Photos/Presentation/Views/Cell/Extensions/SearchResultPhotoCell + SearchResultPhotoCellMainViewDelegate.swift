//
//  SearchResultPhotoCell + SearchResultPhotoCellMainViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

extension SearchResultPhotoCell: SearchResultPhotoCellMainViewDelegate {
  func downloadTapped() {
    guard let delegate = delegate else { return }
    delegate.downloadTapped(self)
  }
}
