//
//  PhotoListCollectionViewController.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit
import Photos

protocol PhotoListViewControllerDelegate: AnyObject {
  func didSelect(id: Photo)
}

class PhotoListCollectionViewController: UICollectionViewController {
  // MARK: - Private Properties
  private(set) var viewModel: any PhotoListViewModelProtocol
  private(set) weak var delegate: (any PhotoListViewControllerDelegate)?
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  // MARK: - Initializers
  init(
    viewModel: any PhotoListViewModelProtocol,
    delegate: any PhotoListViewControllerDelegate,
    layout: UICollectionViewLayout
  ) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(collectionViewLayout: layout)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = .snjor

    viewModel.createDataSource(for: collectionView, delegate: self)
    viewModel.viewDidLoad()
    viewModel.onPhotosChange = { [weak self] photos in
      self?.updateCollectionView(with: photos)
    }
    viewModel.downloadService.configureSession(delegate: self)
  }

  private func updateCollectionView(with photos: [Photo]) {
    viewModel.applySnapshot()
  }
}

extension PhotoListCollectionViewController: PhotoCellDelegate {
  func cancelTapped(_ cell: PhotoCell) {
    //
  }
  
  func downloadTapped(_ cell: PhotoCell) {
    print(#function)
    if let indexPath = collectionView.indexPath(for: cell) {
      let photo = viewModel.getPhotoID(at: indexPath.item)
      viewModel.downloadService.startDownload(photo)
    }
  }
  
  func pauseTapped(_ cell: PhotoCell) {
    //
  }
  
  func resumeTapped(_ cell: PhotoCell) {
    //
  }
  
  
}


extension PhotoListCollectionViewController: URLSessionDownloadDelegate {
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
      download?.item.downloaded = true
    } catch let error {
      self.presentAlert(
        message: "\(error.localizedDescription)",
        title: AppLocalized.error
      )
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
  
  // сохранить изображение в галерею
  private func saveImageToGallery(at url: URL) {
    PHPhotoLibrary.requestAuthorization { status in
      guard status == .authorized else { return }
      PHPhotoLibrary.shared().performChanges {
        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
      } completionHandler: { success, error in
        if success {
          print(#function, "Successfully saved image to gallery.")
          // анимация возврата когда фото сохранилось в галерее
          DispatchQueue.main.async{

          }
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

//  private func hideSpinner() {
//
//    DispatchQueue.main.async {
//      self.hideSpinner(from: self.mainView.downloadBarButtonBlurView)
//
//    }
//  }
  
 
}
