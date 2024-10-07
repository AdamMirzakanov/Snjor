//
//  TopicPhotos + URLSessionDownloadDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import Foundation
import Photos

extension TopicPhotosViewController: URLSessionDownloadDelegate {
  // MARK:  URL Session Download Delegate
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
          self.hideSpinner()
          print(#function, "🇧🇶 Successfully saved image to gallery.")
        } else if let error = error {
          self.showError(
            error: error.localizedDescription
          )
        }
      }
    }
  }

  private func localFilePath(for url: URL) -> URL {
    let component = url.lastPathComponent
    var destinationURL = documentsPath.appendingPathComponent(component)
    if destinationURL.pathExtension.isEmpty {
      destinationURL = destinationURL.appendingPathExtension(.jpegExt)
    }
    return destinationURL
  }
  
  private func hideSpinner() {
    DispatchQueue.main.async {
      self.rootView.topicPhotosCollectionView.visibleCells
        .compactMap { $0 as? TopicPhotoCell }
        .forEach { cell in
          cell.mainView.spinner.stopAnimating()
          cell.mainView.spinner.isHidden = true
          cell.mainView.downloadButton.isHidden = false
        }
    }
  }
}
