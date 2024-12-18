//
//  NetworkRequestService.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// Класс `NetworkRequestService` содержит статические методы для подготовки URL-запросов к API.
///
/// - Note: Методы в этом перечислении создают запросы для
/// различных конечных точек API, используя заданные параметры и пути.
/// Все методы выбрасывают ошибку `APIError.URLError`, если не удается создать URL.
final class NetworkRequestService {
  // MARK: Private Properties
  /// Возвращает HTTP-метод для запросов.
  ///
  /// Используется для указания, что метод HTTP для запроса будет "GET".
  private var getHTTP: HTTPMethod { .get }
  
  /// Возвращает схему API.
  ///
  /// Используется для получения схемы (например, "http" или "https") для формирования URL.
  private var scheme: API { .https }
  
  /// Возвращает хост API.
  ///
  /// Используется для получения хоста, на который будут отправлены запросы.
  private var host: API { .host }
  
  // MARK: Internal Methods
  /// Подготавливает объект `URLRequest` для заданного URL.
  ///
  /// - Parameters:
  ///   - url: URL для которого будет создан запрос.
  /// - Returns: Настроенный объект `URLRequest` с заголовками и HTTP-методом.
  /// - Note: Этот метод устанавливает стандартные заголовки и метод запроса,
  /// которые могут быть изменены в зависимости от требований API.
  func prepareURLRequest(url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = prepareHeaders()
    request.httpMethod = getHTTP.rawValue
    return request
  }
  
  /// Подготавливает объект `URL` на основе заданного пути и параметров.
  ///
  /// - Parameters:
  ///   - path: Строка, представляющая базовый путь для формирования URL.
  ///   - parameters: Опциональные параметры, которые будут добавлены к URL (по умолчанию `nil`).
  /// - Returns: Опциональный объект `URL`, сформированный из заданного пути и параметров,
  /// или `nil`, если не удалось создать URL.
  /// - Note: Метод использует вспомогательную функцию `prepareURLComponents`
  /// для формирования компонентов URL.
  func prepareURL(
    from path: String,
    parameters: Parameters? = nil
  ) -> URL? {
    if let parameters = parameters {
      let components = prepareURLComponents(from: path, parameters: parameters)
      return components.url
    } else {
      let components = prepareURLComponents(from: path)
      return components.url
    }
  }
  
  /// Подготавливает объект `URLComponents` на основе заданного пути и опциональных параметров.
  ///
  /// - Parameters:
  ///   - path: Строка, представляющая путь для формирования URL.
  ///   - parameters: Опциональные параметры, которые будут добавлены в
  ///   качестве `query items` (по умолчанию `nil`).
  /// - Returns: Объект `URLComponents`, содержащий схему, хост, путь и, при наличии, параметры запроса.
  /// - Note: Метод использует вспомогательную функцию `prepareQueryItems`
  /// для преобразования параметров в формат `query items.
  func prepareURLComponents(
    from path: String,
    parameters: Parameters? = nil
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = scheme.rawValue
    components.host = host.rawValue
    components.path = path
    if let parameters = parameters {
      components.queryItems = prepareQueryItems(parameters: parameters)
    }
    return components
  }
  
  /// Подготавливает массив `URLQueryItem` на основе заданных параметров.
  ///
  /// - Parameters:
  ///   - parameters: Словарь параметров, где ключи
  ///   представляют имена параметров, а значения — их значения.
  ///   - Returns: Массив объектов `URLQueryItem`, соответствующих заданным параметрам.
  ///   - Note: Метод используется для преобразования параметров в формат,
  /// подходящий для добавления в URL в качестве query items.
  func prepareQueryItems(
    parameters: Parameters
  ) -> [URLQueryItem] {
    parameters.map { URLQueryItem(
      name: $0.key,
      value: $0.value)
    }
  }
  
  /// Подготавливает заголовки для HTTP-запроса.
  ///
  /// - Returns: Словарь `Parameters`, содержащий заголовки для запроса,
  /// включая авторизационные данные.
  /// - Note: Метод устанавливает ключи заголовков, используя константы для ключа и
  /// идентификатора клиента, а также добавляет токен доступа для авторизации.
  func prepareHeaders() -> Parameters {
    var headers: Parameters = [:]
    headers[Const.headerKey] = Const.сlientID + Authorization.accessKey
    return headers
  }
}

// MARK: - Const
fileprivate typealias Const = PrepareRequestConst

enum PrepareRequestConst {
  static let headerKey = "Authorization"
  static let сlientID = "Client-ID" + .spacer
  static let photosPathComponent = "photos"
  static let likesPathComponent = "likes"
  static let randomPathComponent = "random"
  static let collectionsPathComponent = "collections"
}
