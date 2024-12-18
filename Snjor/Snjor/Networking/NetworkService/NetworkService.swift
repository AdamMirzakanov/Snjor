//
//  NetworkService.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// Служба сети, которая отвечает за выполнение запросов.
struct NetworkService {
  // MARK: Internal Properties
  let session: URLSession

  // MARK: Initializers
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
}
