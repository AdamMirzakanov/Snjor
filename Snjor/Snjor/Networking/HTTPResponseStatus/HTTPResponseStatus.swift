//
//  HTTPResponseStatus.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

/// Перечисление представляет собой набор диапазонов кодов состояния HTTP-ответов.
enum HTTPResponseStatus {
  /// Диапазон кодов состояния успешных ответов.
  static let success = 200...299
  /// Диапазон кодов состояния ошибок клиента.
  static let clientError = 400...499
  /// Диапазон кодов состояния ошибок сервера.
  static let serverError = 500...599
}
