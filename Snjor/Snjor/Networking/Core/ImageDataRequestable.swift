//
//  ImageDataRequestable.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

protocol ImageDataRequestable {
  func request(url: URL?) async -> Data?
}
