//
//  HTTPResponseStatus.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

enum HTTPResponseStatus {
  static let success = 200...299
  static let clientError = 400...499
  static let serverError = 500...599
}
