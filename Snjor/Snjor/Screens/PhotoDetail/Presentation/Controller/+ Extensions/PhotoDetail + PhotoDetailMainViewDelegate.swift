//
//  PhotoDetail + PhotoDetailMainViewDelegate.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

extension PhotoDetailViewController: PhotoDetailMainViewDelegate {
  func didTapDownloadButton() {
    downloadService.startDownload(
      viewModel.photo!,
      sessionID: Self.sessionID
    )
  }
}
