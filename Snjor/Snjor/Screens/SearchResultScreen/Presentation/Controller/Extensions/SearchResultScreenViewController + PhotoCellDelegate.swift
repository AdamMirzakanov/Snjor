//
//  SearchResultScreenViewController + PhotoCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

extension SearchResultScreenViewController: SearchResultPhotoCellDelegate {
  func downloadTapped(_ cell: SearchResultPhotoCell) {
    if let indexPath = rootView.photosCollectionView.indexPath(for: cell) {
      let photo = photosViewModel.getPhoto(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}
