//
//  SearchResultPhotoCell + PhotoCellMainViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.10.2024.
//

extension SearchResultPhotoCell: PhotoCellMainViewDelegate {
  func downloadTapped() {
    guard let delegate = delegate else { return }
    delegate.downloadTapped(self)
  }
}
