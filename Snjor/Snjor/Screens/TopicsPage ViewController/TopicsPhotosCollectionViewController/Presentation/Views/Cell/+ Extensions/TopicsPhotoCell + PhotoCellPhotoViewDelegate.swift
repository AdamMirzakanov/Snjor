//
//  TopicsPhotoCell + PhotoCellPhotoViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

// MARK: - PhotoCellViewDelegate
extension TopicsPhotoCell: PhotoCellPhotoViewDelegate {
  func downloadTapped() {
    guard let delegate = delegate else { return }
    delegate.downloadTapped(self)
  }
}
