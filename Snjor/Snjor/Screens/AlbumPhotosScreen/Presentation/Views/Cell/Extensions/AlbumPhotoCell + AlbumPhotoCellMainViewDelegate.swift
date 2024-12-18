//
//  AlbumPhotoCell + AlbumPhotoCellMainViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

extension AlbumPhotoCell: MainPhotoCellViewDelegate {
  func downloadTapped() {
    guard let delegate = delegate else { return }
    delegate.downloadTapped(self)
  }
}
