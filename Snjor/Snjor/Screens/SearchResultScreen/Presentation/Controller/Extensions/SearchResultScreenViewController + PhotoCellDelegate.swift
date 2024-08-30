//
//  SearchResultScreenViewController + PhotoCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

extension SearchResultScreenViewController: PhotoCellDelegate {
  func downloadTapped(_ cell: PhotoCell) {
    if let indexPath = rootView.photosCollectionView.indexPath(for: cell) {
      let photo = photosViewModel.getPhoto(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}
