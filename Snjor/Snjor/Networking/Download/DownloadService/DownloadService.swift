//
//  DownloadService.swift
//  Snjor
//
//  Created by Адам on 02.07.2024.
//

import Foundation

final class DownloadService {
 private var downloadsSession: URLSession?

  func configureSession(delegate: URLSessionDelegate) {
    let configuration = URLSessionConfiguration.background(withIdentifier: .downloadsSessionID)
    downloadsSession = URLSession(
      configuration: configuration,
      delegate: delegate,
      delegateQueue: nil
    )
  }

  func startDownload<T: Downloadable>(_ item: T) {
    let download = Download(item: item)
    guard let downloadURL = item.downloadURL,
          let downloadsSession = downloadsSession else {
      return
    }
    download.task = downloadsSession.downloadTask(with: downloadURL)
    download.task?.resume()
  }
}
