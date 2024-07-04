//
//  PhotoDetailViewController + URLSessionDownloadDelegate.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import Foundation

// MARK: - URL Session Download Delegate
extension PhotoDetailViewController: URLSessionDownloadDelegate {
  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL
  ) {

    guard let sourceURL = downloadTask.originalRequest?.url
    else {
      return
    }

    let download = viewModel.downloadService.activeDownloads[sourceURL]
    viewModel.downloadService.activeDownloads[sourceURL] = nil

    let destinationURL = viewModel.localFilePath(for: sourceURL)
    print(destinationURL)

    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)

    do {
      try fileManager.copyItem(at: location, to: destinationURL)
      viewModel.saveImageToGallery(at: destinationURL)
    } catch let error {
      print("Could not copy file to disk: \(error.localizedDescription)")
    }
  }

  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didWriteData bytesWritten: Int64,
    totalBytesWritten: Int64,
    totalBytesExpectedToWrite: Int64
  ) {
    guard
      let url = downloadTask.originalRequest?.url,
      let download = viewModel.downloadService.activeDownloads[url]
    else {
      return
    }

    download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)

    let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
  }
}
