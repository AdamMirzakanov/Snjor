//
//  SearchResultPhotoCell + MainPhotoCellViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.10.2024.
//

extension SearchResultPhotoCell: MainPhotoCellViewDelegate {
  func downloadTapped() {
    guard let delegate = delegate else { return }
    delegate.downloadTapped(self)
  }
}
