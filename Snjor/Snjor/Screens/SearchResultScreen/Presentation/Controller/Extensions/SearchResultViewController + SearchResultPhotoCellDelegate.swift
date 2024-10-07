//
//  SearchResultViewController + SearchResultPhotoCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

extension SearchResultViewController: SearchResultPhotoCellDelegate {
  func downloadTapped(_ cell: SearchResultPhotoCell) {
    if let indexPath = rootView.photosCollectionView.indexPath(for: cell) {
      let photo = photosViewModel.getItem(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}
