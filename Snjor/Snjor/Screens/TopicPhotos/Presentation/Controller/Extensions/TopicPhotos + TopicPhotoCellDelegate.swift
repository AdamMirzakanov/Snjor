//
//  TopicPhotos + TopicPhotoCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

extension TopicPhotosViewController: TopicPhotoCellDelegate {
  func downloadTapped(_ cell: TopicPhotoCell) {
    if let indexPath = rootView.topicPhotosCollectionView.indexPath(for: cell) {
      let photo = viewModel.getPhoto(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}
