//
//  Downloadable.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import Foundation

/// Протокол, который определяет свойство, предоставляющее URL для загрузки.
protocol Downloadable {
  /// `URL`, по которому можно загрузить ресурс.
  var downloadURL: URL? { get }
}
