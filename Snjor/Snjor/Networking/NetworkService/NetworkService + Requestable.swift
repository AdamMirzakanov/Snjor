//
//  NetworkService + Requestable.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

extension NetworkService: Requestable {
  // MARK: - Internal Methods
  func request<T>(
    request: URLRequest,
    type: T.Type
  ) async throws -> T
  where T: Decodable {
    return try await makeRequest(request: request)
  }

  // MARK: - Private Methods
  private func makeRequest<T>(
    request: URLRequest
  ) async throws -> T
  where T: Decodable {
    let request = try await session.data(for: request)
    return try validateResponse(request: request)
  }

  private func validateResponse<T>(
    request: (data: Data, httpResponse: URLResponse)
  ) throws -> T
  where T: Decodable {
    guard let httpResponse = request.httpResponse as? HTTPURLResponse else {
      throw APIError.responseError
    }

    switch httpResponse.statusCode {
    case HTTPResponseStatus.success:
      print(#function, "code:", httpResponse.statusCode)
      return try decodeResponse(data: request.data)
    case HTTPResponseStatus.clientError:
      print(#function, "code:", httpResponse.statusCode)
      throw APIError.clientError
    case HTTPResponseStatus.serverError:
      print(#function, "code:", httpResponse.statusCode)
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
      print(#function, APIError.decodingError)
      throw APIError.decodingError
    }
    
//    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
//          let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
//          let jsonString = String(data: jsonData, encoding: .utf8) {
//           print("🟢 \(jsonString) 🔴")
//       } else {
//           print("Error serializing JSON")
//       }
    return model
  }
}
