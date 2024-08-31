//
//  SearchScreenViewController + SearchScreenPhotoCellDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

extension SearchScreenViewController: SearchScreenPhotoCellDelegate {
  func downloadTapped(_ cell: SearchScreenPhotoCell) {
    if let indexPath = rootView.photosCollectionView.indexPath(for: cell) {
      let photo = photosViewModel.getPhoto(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}
