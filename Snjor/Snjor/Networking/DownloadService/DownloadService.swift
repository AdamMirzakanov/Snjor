//
//  DownloadService.swift
//  Snjor
//
//  Created by Адам on 02.07.2024.
//

import Foundation

final class DownloadService {
  // MARK: - Private Properties
  var sessions: [String: URLSession] = [:]

  // MARK: - Internal Methods
  func configureSession(
    delegate: URLSessionDelegate?,
    id: String
  ) {
    let configuration = URLSessionConfiguration.background(withIdentifier: id)
    let session = URLSession(
      configuration: configuration,
      delegate: delegate,
      delegateQueue: nil
    )
    sessions[id] = session
  }

  func startDownload<T: Downloadable>(_ item: T, sessionID: String) {
    guard
      let downloadURL = item.downloadURL,
      let session = sessions[sessionID]
    else {
      return
    }
    let downloadTask = session.downloadTask(with: downloadURL)
    downloadTask.resume()
  }

  func invalidateSession(withID id: String) {
    sessions[id]?.invalidateAndCancel()
    sessions[id] = nil
  }
}
