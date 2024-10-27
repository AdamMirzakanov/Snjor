//
//  APIError.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// Перечисление, представляющее возможные ошибки, возникающие при взаимодействии с API.
enum APIError: Error {
  static var statusCode: Int = .zero
  
  /// Ошибка, связанная с некорректным запросом клиента (например, неверные данные или параметры).
  case clientError
  /// Ошибка, возникающая на стороне сервера (например, сбой в обработке запроса).
  case serverError
  /// Неопределённая ошибка, не попадающая в другие категории.
  case unknownError
  /// Ошибка, связанная с некорректным URL или проблемами при выполнении сетевого запроса.
  case URLError
  /// Ошибка, возникающая при декодировании полученных данных (например, несоответствие формата данных).
  case decodingError
  /// Ошибка, возникающая при неверной обработке ответа или отсутствии валидного ответа от сервера.
  case responseError
}

// MARK: - LocalizedError
extension APIError: LocalizedError {
  /// Локализованная строка с описанием ошибки в зависимости от её типа.
  var errorDescription: String? {
    switch self {
    case .clientError:
      return NSLocalizedString("Content Not Available", comment: .empty)
    case .serverError:
      return NSLocalizedString("Server Issue", comment: .empty)
    case .unknownError:
      return NSLocalizedString("Unknown Error", comment: .empty)
    case .URLError:
      return NSLocalizedString("URL Error", comment: .empty)
    case .decodingError:
      return NSLocalizedString("Decoding Error", comment: .empty)
    case .responseError:
      return NSLocalizedString("Response Error", comment: .empty)
    }
  }
}
