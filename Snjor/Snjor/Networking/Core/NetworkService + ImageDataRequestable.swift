//
//  NetworkService + ImageDataRequestable.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

extension NetworkService: ImageDataRequestable {
  func request(url: URL?) async -> Data? {
    guard let url = url else {
      return nil
    }
    do {
      let (data: data, request: request) = try await session.data(from: url)
      return (data: data, request: request).data
    } catch {
      return nil
    }
  }
}
