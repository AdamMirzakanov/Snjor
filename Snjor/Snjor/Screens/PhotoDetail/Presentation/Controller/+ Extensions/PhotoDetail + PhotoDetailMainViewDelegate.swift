//
//  PhotoDetail + PhotoDetailMainViewDelegate.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

extension PhotoDetailViewController: PhotoDetailRootViewDelegate {
  func didTapDownloadButton() {
    downloadService.startDownload(
      viewModel.photo!,
      sessionID: Self.sessionID
    )
  }
}
