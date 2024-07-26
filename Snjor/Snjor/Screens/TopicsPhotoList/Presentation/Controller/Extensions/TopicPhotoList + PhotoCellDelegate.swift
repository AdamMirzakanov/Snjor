//
//  TopicPhotoList + PhotoCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

extension TopicPhotoListCollectionViewController: PhotoCellDelegate {
  func downloadTapped(_ cell: PhotoCell) {
    if let indexPath = collectionView.indexPath(for: cell) {
      let photo = viewModel.getPhoto(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}
