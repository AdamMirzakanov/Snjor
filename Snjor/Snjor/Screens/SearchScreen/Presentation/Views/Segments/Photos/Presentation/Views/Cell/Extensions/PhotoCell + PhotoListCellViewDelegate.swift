//
//  SearchScreenPhotoCell + PhotoCellMainViewDelegate.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

// MARK: - PhotoCellViewDelegate
extension SearchScreenPhotoCell: PhotoCellMainViewDelegate {
  func downloadTapped() {
    guard let delegate = delegate else { return }
    delegate.downloadTapped(self)
  }
}
