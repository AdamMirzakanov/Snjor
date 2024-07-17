//
//  SessionIdentifiable.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

protocol SessionIdentifiable { }

extension SessionIdentifiable {
  static var sessionID: String {
    return String(describing: self)
  }
}
