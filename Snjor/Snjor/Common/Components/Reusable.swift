//
//  Reusable.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

protocol Reusable { }

extension Reusable {
  static var reuseID: String {
    return String(describing: self)
  }
}
