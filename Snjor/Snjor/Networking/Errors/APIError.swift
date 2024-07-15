//
//  APIError.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

enum APIError: Error {
  case clientError
  case serverError
  case unknownError
  case URLError
  case decodingError
  case responseError
}

// MARK: - LocalizedError
extension APIError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .clientError:
      return NSLocalizedString("Client Error", comment: .empty)
    case .serverError:
      return NSLocalizedString("Server Error", comment: .empty)
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
