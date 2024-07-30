//
//  PhotoListCell + PhotoCellPhotoViewDelegate.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

// MARK: - PhotoCellViewDelegate
extension PhotoListCell: PhotoListCellMainViewDelegate {
  func downloadTapped() {
    guard let delegate = delegate else { return }
    delegate.downloadTapped(self)
  }
}
