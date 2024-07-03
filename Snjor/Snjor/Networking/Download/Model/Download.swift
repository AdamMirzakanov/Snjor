//
//  Download.swift
//  Snjor
//
//  Created by Адам on 02.07.2024.
//

import Foundation

class Download {
  // MARK: - Public Properties
  var item: any Downloadable
  var isDownloading = false
  var progress: Float = 0
  var resumeData: Data?
  var task: URLSessionDownloadTask?

  // MARK: - Initializers
  init(item: any Downloadable) {
    self.item = item
  }
}
