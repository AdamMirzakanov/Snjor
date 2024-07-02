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

  func cancelDownload(_ photo: Photo) {
    guard 
      let download = activeDownloads[photo.urls[.full]!]
    else {
      return
    }
    download.task?.cancel()
    activeDownloads[photo.urls[.full]!] = nil
  }

  func pauseDownload(_ photo: Photo) {
    guard
      let download = activeDownloads[photo.urls[.full]!],
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

  func resumeDownload(_ photo: Photo) {
    guard 
      let download = activeDownloads[photo.urls[.full]!]
    else {
      return
    }
    if let resumeData = download.resumeData {
      download.task = downloadsSession.downloadTask(withResumeData: resumeData)
    } else {
      download.task = downloadsSession.downloadTask(with: download.photo.urls[.full]!)
    }
    download.task?.resume()
    download.isDownloading = true
  }

  func startDownload(_ photo: Photo) {
    let download = Download(photo: photo)
    download.task = downloadsSession.downloadTask(with: photo.urls[.full]!)
    download.task?.resume()
    download.isDownloading = true
    activeDownloads[download.photo.urls[.full]!] = download
  }
}
