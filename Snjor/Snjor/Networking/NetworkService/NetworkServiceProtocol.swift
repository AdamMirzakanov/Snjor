//
//  NetworkServiceProtocol.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// Протокол, определяющий функциональность для выполнения сетевых запросов.
protocol NetworkServiceProtocol {
  /// Выполняет асинхронный запрос к API и возвращает декодированный ответ.
  ///
  /// Этот метод использует переданный объект `URLRequest` для выполнения запроса,
  /// а затем декодирует полученные данные в указанный тип `T`, который должен
  /// соответствовать протоколу `Decodable`.
  ///
  /// - Parameter request: Настроенный объект `URLRequest`, представляющий запрос к API.
  /// - Parameter type: Тип данных, в который будет декодирован ответ API.
  /// - Throws:
  ///   - `APIError` в случае ошибки сети или получения некорректного ответа.
  ///   - `DecodingError` в случае ошибки декодирования данных в указанный тип.
  /// - Returns: Декодированные данные типа `T`, полученные от API.
  func request<T: Decodable>(
    request: URLRequest,
    type: T.Type
  ) async throws -> T
}
