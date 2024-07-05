//
//  PhotoDetailViewController + URLSessionDownloadDelegate.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit
import Photos

extension PhotoDetailViewController: URLSessionDownloadDelegate {
  // MARK: - URL Session Download Delegate
  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL
  ) {
    guard let sourceURL = downloadTask.originalRequest?.url else { return }
    let download = viewModel.downloadService.activeDownloads[sourceURL]
    viewModel.downloadService.activeDownloads[sourceURL] = nil
    let destinationURL = localFilePath(for: sourceURL)
    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)
    do {
      try fileManager.copyItem(at: location, to: destinationURL)
      saveImageToGallery(at: destinationURL)
    } catch let error {
      self.presentAlert(message: "\(error.localizedDescription)", title: AppLocalized.error)
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

  // MARK: - Private Methods
  private func saveImageToGallery(at url: URL) {
    PHPhotoLibrary.requestAuthorization { status in
      guard status == .authorized else { return }
      PHPhotoLibrary.shared().performChanges {
        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
      } completionHandler: { success, error in
        if success {
          print("Successfully saved image to gallery.")
          self.hideSpinner()
        } else if let error = error {
          self.presentAlert(message: "\(error.localizedDescription)", title: AppLocalized.error)
        }
      }
    }
  }

  private func localFilePath(for url: URL) -> URL {
    var destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
    if destinationURL.pathExtension.isEmpty {
      destinationURL = destinationURL.appendingPathExtension(.jpegExtension)
    }
    return destinationURL
  }

  private func hideSpinner() {

    DispatchQueue.main.async {
      self.hideSpinner(from: self.mainView.downloadBarButton)
      UIView.animate(
        withDuration: UIConst.durationDefault,
        delay: .zero
      ) {
        self.mainView.downloadBarButtonBlurView.frame.origin.x = -UIConst.translationX
        self.mainView.downloadBarButtonBlurView.frame.size.width = UIConst.buttonWidth
        self.mainView.downloadBarButton.frame.size.width = UIConst.buttonWidth
        self.mainView.downloadBarButton.setImage(UIImage(systemName: .downloadBarButtonImage), for: .normal)
        self.mainView.downloadBarButton.setTitle(.jpeg, for: .normal)
        self.mainView.downloadBarButton.isEnabled = true

        self.mainView.pauseBarButtonBlurView.frame.size.width = .zero
        self.mainView.pauseBarButtonBlurView.frame.origin.x = -8
        self.mainView.pauseBarButton.frame = self.mainView.pauseBarButtonBlurView.bounds
      }
    }
  }
}
