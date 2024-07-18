//
//  PhotoListCell + PhotoListCellViewDelegate.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

// MARK: - PhotoListCellViewDelegate
extension PhotoListCell: PhotoListCellViewDelegate {
  func downloadTapped() {
    guard let delegate = delegate else { return }
    delegate.downloadTapped(self)
  }
}
