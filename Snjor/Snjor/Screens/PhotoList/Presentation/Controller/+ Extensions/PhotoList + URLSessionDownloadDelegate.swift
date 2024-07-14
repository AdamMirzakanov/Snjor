//
//  PhotoList + URLSessionDownloadDelegate.swift
//  Snjor
//
//  Created by Адам on 14.07.2024.
//

import Foundation
import Photos

extension PhotoListCollectionViewController: URLSessionDownloadDelegate {
  // MARK: - URL Session Download Delegate
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
      self.presentAlert(
        message: "\(error.localizedDescription)",
        title: AppLocalized.error
      )
    }
  }

  // MARK: - Private Methods
  private func saveImageToGallery(at url: URL) {
    PHPhotoLibrary.requestAuthorization { status in
      guard status == .authorized else { return }
      PHPhotoLibrary.shared().performChanges {
        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
      } completionHandler: { success, error in
        if success {
          print(#function, "Successfully saved image to gallery.")
          self.hideSpinner()
        } else if let error = error {
          self.presentAlert(
            message: "\(error.localizedDescription)",
            title: AppLocalized.error
          )
        }
      }
    }
  }

  private func localFilePath(for url: URL) -> URL {
    let component = url.lastPathComponent
    var destinationURL = documentsPath.appendingPathComponent(component)
    if destinationURL.pathExtension.isEmpty {
      destinationURL = destinationURL.appendingPathExtension(.jpegExtension)
    }
    return destinationURL
  }

  private func hideSpinner() {
    DispatchQueue.main.async{
      self.hideSpinner(from: self.spinnerVisualEffectView)
    }
  }
}
