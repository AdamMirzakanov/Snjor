//
//  Download.swift
//  Snjor
//
//  Created by Адам on 02.07.2024.
//

import Foundation

class Download {
  // MARK: - Public Properties
  var isDownloading = false
  var progress: Float = 0
  var resumeData: Data?
  var task: URLSessionDownloadTask?
  var photo: Photo

  // MARK: - Initializers
  init(photo: Photo) {
    self.photo = photo
  }
}
