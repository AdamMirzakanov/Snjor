//
//  PhotoList + PhotoListCellDelegate.swift
//  Snjor
//
//  Created by Адам on 14.07.2024.
//

extension PhotoListCollectionViewController: PhotoListCellDelegate {
  func downloadTapped(_ cell: PhotoListCell) {
    if let indexPath = collectionView.indexPath(for: cell) {
      let photo = viewModel.getPhoto(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}
