//
//  DownloadService.swift
//  Snjor
//
//  Created by Адам on 02.07.2024.
//

import Foundation

class DownloadService {
  var activeDownloads: [URL: Download] = [:]
  var downloadsSession: URLSession!

  func cancelDownload<T: Downloadable>(_ item: T) {
    guard let downloadURL = item.downloadURL else { return }
    guard let download = activeDownloads[downloadURL] else { return }
    download.task?.cancel()
    activeDownloads[downloadURL] = nil
  }

  func pauseDownload<T: Downloadable>(_ item: T) {
    guard
      let downloadURL = item.downloadURL,
      let download = activeDownloads[downloadURL],
      download.isDownloading
    else {
      return
    }
    download.task?.cancel(
      byProducingResumeData: { data in
        download.resumeData = data
      }
    )
    download.isDownloading = false
  }

  func resumeDownload<T: Downloadable>(_ item: T) {
    guard let downloadURL = item.downloadURL else { return }
    guard let download = activeDownloads[downloadURL] else { return }
    if let resumeData = download.resumeData {
      download.task = downloadsSession.downloadTask(withResumeData: resumeData)
    } else {
      download.task = downloadsSession.downloadTask(with: downloadURL)
    }
    download.task?.resume()
    download.isDownloading = true
  }

  func startDownload<T: Downloadable>(_ item: T) {
    let download = Download(item: item)
    guard let downloadURL = item.downloadURL else { return }
    download.task = downloadsSession.downloadTask(with: downloadURL)
    download.task?.resume()
    download.isDownloading = true
    activeDownloads[downloadURL] = download
  }
}
