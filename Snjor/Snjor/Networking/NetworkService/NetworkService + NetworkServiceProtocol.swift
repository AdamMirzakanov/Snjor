//
//  NetworkService + NetworkServiceProtocol.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

extension NetworkService: NetworkServiceProtocol {
  
  typealias NetworkResponse = (data: Data, httpResponse: URLResponse)
  
  // MARK: Internal Methods
  func request<T>(
    request: URLRequest,
    type: T.Type
  ) async throws -> T
  where T: Decodable {
    return try await makeRequest(request: request)
  }

  // MARK: Private Methods
  private func makeRequest<T>(
    request: URLRequest
  ) async throws -> T
  where T: Decodable {
    let request = try await session.data(for: request)
    return try validateResponse(request: request)
  }

  private func validateResponse<T>(
    request: NetworkResponse
  ) throws -> T where T: Decodable {
    guard let httpResponse = request.httpResponse as? HTTPURLResponse else {
      throw APIError.responseError
    }

    switch httpResponse.statusCode {
    case HTTPResponseStatus.success:
      return try decodeResponse(data: request.data)
    case HTTPResponseStatus.clientError:
      APIError.statusCode = httpResponse.statusCode
      throw APIError.clientError
    case HTTPResponseStatus.serverError:
      APIError.statusCode = httpResponse.statusCode
      throw APIError.serverError
    default:
      throw APIError.unknownError
    }
  }

  private func decodeResponse<T>(data: Data) throws -> T where T: Decodable {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let model = try? decoder.decode(T.self, from: data)
    guard let model = model else {
      throw APIError.decodingError
    }
    return model
  }
}
