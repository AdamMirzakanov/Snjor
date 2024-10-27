//
//  Requestable.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// Протокол, определяющий функциональность для выполнения сетевых запросов.
protocol Requestable {
  /// Выполняет асинхронный сетевой запрос и возвращает декодированные данные.
  ///
  /// - Parameters:
  ///   - request: `URLRequest`, содержащий параметры запроса (URL, метод, заголовки и т. д.).
  ///   - type: Тип данных, который будет декодирован из ответа сервера.
  ///   Этот тип должен соответствовать протоколу `Decodable`.
  func request<T: Decodable>(
    request: URLRequest,
    type: T.Type
  ) async throws -> T
}
