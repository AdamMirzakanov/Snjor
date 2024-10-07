//
//  AlbumPhotos + TopicPhotoCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

extension AlbumPhotosViewController: AlbumPhotoCellDelegate {
  func downloadTapped(_ cell: AlbumPhotoCell) {
    if let indexPath = rootView.albumPhotosCollectionView.indexPath(for: cell) {
      let photo = viewModel.getItem(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}
