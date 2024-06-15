//
//  Requestable.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

protocol Requestable {
  func request<T>(
    request: URLRequest,
    type: T.Type
  ) async throws -> T
  where T: Decodable
}
