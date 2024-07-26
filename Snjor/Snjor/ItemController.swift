////
////  ItemController.swift
////  Snjor
////
////  Created by Адам Мирзаканов on 23.07.2024.
////
//
//import Foundation
//
//final class ItemController {
//  
//  // Request это тип реализующий протокол APIRequest
//  // так как он реализует этот протокол он имеет доступ к свойствам
//  // этого протокола которые он же сам и реализовал
//  // таким образом в этот метод будут переданы реализации свойств и
//  // методов этого протокола типом Request
//  func sendRequest<Request: APIRequest>(
//    _ request: Request,
//    completion: @escaping (Result<Request.Response, NetworkError>
//    ) -> Void) {
//    do {
//      let task = try URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
//        
//        // если произойдет ошибка перед выполнением задачи
//        if let urlError = error as? URLError {
//          let networkError = self.mapURLErrorToNetworkError(urlError)
//          completion(.failure(networkError))
//          print("Failure:", networkError)
//          return
//        }
//        
//        guard
//          let data = data,
//          let response = response as? HTTPURLResponse
//        else {
//          return completion(.failure(.expectedDataNotFound))}
//        
//        let statusCode = response.statusCode
//        
//        // ошибки определенные в этом блоке сработают если они произойдут во время выполнения задачи
//        switch statusCode {
//        case let statusCode where StatusCodes.successCodes.contains(statusCode):
//          
//          // декодирование данных
//          do {
//            let decodedResponse = try request.decodeResponse(data: data)
//            completion(.success(decodedResponse))
//            print("Success:", statusCode)
//          } catch {
//            completion(.failure(.decodingFailed))
//            print("ОШИБКА ДЕКОДИРОВАНИЯ!:", statusCode)
//          }
//          
//        case let statusCode where StatusCodes.localErrorCodes.contains(statusCode):
//          completion(.failure(.localError))
//          print("Failure:", statusCode)
//        case let statusCode where StatusCodes.serverErrorCodes.contains(statusCode):
//          completion(.failure(.serviceUnavailable))
//          print("Failure:", statusCode)
//        default:
//          completion(.failure(.otherError(statusCode: statusCode)))
//          print("Failure:", statusCode)
//        }
//      }
//      task.resume()
//    } catch {
//      completion(.failure(.missingURL))
//      print("Missing URL")
//    }
//  }
//  
//  private func mapURLErrorToNetworkError(_ error: URLError) -> NetworkError {
//    switch error.code {
//    case .notConnectedToInternet:
//      return .localError
//    case .badServerResponse:
//      return .serviceUnavailable
//    case .timedOut:
//      return .timeOutError
//    default:
//      return .otherError(statusCode: error.errorCode)
//    }
//  }
//}
//
//enum NetworkError: Error {
//  case localError
//  case serviceUnavailable
//  case timeOutError
//  case expectedDataNotFound
//  case decodingFailed
//  case otherError(statusCode: Int)
//  case missingURL
//  
//  var errorDescription: String {
//    switch self {
//    case .localError:                 "Local error occurred. Please check your input and retry."
//    case .serviceUnavailable:         "Error on the server side. We apologize for the inconvenience. Please try again later."
//    case .timeOutError:               "The request has timed out. Please check your internet connection and try again."
//    case .expectedDataNotFound:       "No data was returned from the server. Please retry the request later."
//    case .decodingFailed:             "We could not decode the response."
//    case .missingURL:                 "Missing URL."
//    case .otherError(let statusCode): "An unexpected error occurred with status code \(statusCode)."
//      
//    }
//  }
//}
//
//struct StatusCodes {
//  static let successCodes = 200...299
//  static let localErrorCodes = 400...499
//  static let serverErrorCodes = 500...599
//}
