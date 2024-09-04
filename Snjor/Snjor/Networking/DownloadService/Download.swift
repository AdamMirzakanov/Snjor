//
//  Download.swift
//  Snjor
//
//  Created by Адам on 02.07.2024.
//

import Foundation

final class Download {
  // MARK: Internal Properties
  var item: any Downloadable
  var task: URLSessionDownloadTask?

  // MARK: Initializers
  init(item: any Downloadable) {
    self.item = item
  }
}
