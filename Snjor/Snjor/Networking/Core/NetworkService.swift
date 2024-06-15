//
//  NetworkService.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

struct NetworkService {
  // MARK: - Public Properties
  let session: URLSession

  // MARK: - Initializers
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
}
