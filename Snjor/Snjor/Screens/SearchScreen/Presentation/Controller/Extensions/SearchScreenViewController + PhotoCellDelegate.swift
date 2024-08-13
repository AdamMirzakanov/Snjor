//
//  SearchScreenViewController + PhotoCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

extension SearchScreenViewController: PhotoCellDelegate {
  func downloadTapped(_ cell: PhotoCell) {
    if let indexPath = rootView.photosCollectionView.indexPath(for: cell) {
      let photo = photosViewModel.getPhoto(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}
