//
//  PhotoDetail + PhotoDetailMainViewDelegate.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

extension PhotoDetailViewController: PhotoDetailRootViewDelegate {
  func didTapDownloadButton() {
    let photoDetailViewModelItem = viewModel.getPhotoDetailViewModelItem()
    guard let photoDetailViewModelItem = photoDetailViewModelItem else { return }
    downloadService.startDownload(
      photoDetailViewModelItem.photo,
      sessionID: Self.sessionID
    )
  }
  
  func didTapAvatar() {
    let photoDetailViewModelItem = viewModel.getPhotoDetailViewModelItem()
    guard let photoDetailViewModelItem = photoDetailViewModelItem else { return }
    let photo = photoDetailViewModelItem.photo
    let user = photo.user
    delegate?.didRequestProfileScreen(user)
  }
}
