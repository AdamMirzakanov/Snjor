//
//  PhotoDetail + URLSessionDownloadDelegate.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit
import Photos

extension PhotoDetailViewController: URLSessionDownloadDelegate {
  // MARK: URL Session Download Delegate
  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL
  ) {
    guard let sourceURL = downloadTask.originalRequest?.url else { return }
    let destinationURL = localFilePath(for: sourceURL)
    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)
    do {
      try fileManager.copyItem(at: location, to: destinationURL)
      saveImageToGallery(at: destinationURL)
    } catch let error {
      self.showError(
        error: error.localizedDescription
      )
    }
  }
  
  // MARK: Private Methods
  private func saveImageToGallery(at url: URL) {
    PHPhotoLibrary.requestAuthorization { status in
      guard status == .authorized else { return }
      PHPhotoLibrary.shared().performChanges {
        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
      } completionHandler: { success, error in
        if success {
          self.hideSpinnerAndReverseAnimateDownloadButton()
        } else if let error = error {
          self.showError(
            error: error.localizedDescription
          )
        }
      }
    }
  }
  
  private func localFilePath(for url: URL) -> URL {
    var destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
    if destinationURL.pathExtension.isEmpty {
      destinationURL = destinationURL.appendingPathExtension(.jpegExt)
    }
    return destinationURL
  }
  
  private func hideSpinnerAndReverseAnimateDownloadButton() {
    DispatchQueue.main.async{
      self.rootView.reverseAnimateDownloadButton()
    }
  }
}
