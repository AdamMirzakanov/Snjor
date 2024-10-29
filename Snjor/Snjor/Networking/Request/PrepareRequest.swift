//
//  PrepareRequest.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// Перечисление `PrepareRequest` содержит статические методы для подготовки URL-запросов к API.
///
/// - Note: Методы в этом перечислении создают запросы для
/// различных конечных точек API, используя заданные параметры и пути.
/// Все методы выбрасывают ошибку `APIError.URLError`, если не удается создать URL.
enum PrepareRequest {

  // MARK: Private Properties
  /// Возвращает HTTP-метод для запросов.
  ///
  /// Используется для указания, что метод HTTP для запроса будет "GET".
  private static var getHTTP: HTTPMethod { .get }
  
  /// Возвращает схему API.
  ///
  /// Используется для получения схемы (например, "http" или "https") для формирования URL.
  private static var scheme: API { .https }
  
  /// Возвращает хост API.
  ///
  /// Используется для получения хоста, на который будут отправлены запросы.
  private static var host: API { .host }
  
  // MARK: Internal Methods
  /// Подготавливает запрос для получения заголовков тем.
  ///
  /// - Parameters:
  ///   - path: Строка, представляющая базовый путь для запроса.
  static func prepareTopicsTitleAPIRequest(
    path: String
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path) else {
      throw APIError.URLError
    }
    let request = prepareURLRequest(url: url)
    return request
  }
  
  /// Подготавливает запрос для получения фотографий Топика.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - idPathSegment: Строка, представляющая подкатолог идентификатора топика.
  ///   - pohtosPathSegment: Строка, представляющая подкаталог для фотографий.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  static func prepareTopicPhotosAPIRequest(
    path: String,
    idPathSegment: String,
    photosPathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let topicsIdURL = url.appending(path: idPathSegment)
    let topicsPhotosURL = topicsIdURL.appending(path: photosPathSegment)
    let request = prepareURLRequest(url: topicsPhotosURL)
    return request
  }
  
  /// Подготавливает запрос для получения фотографий Альбома.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - idPathSegment: Строка, представляющая подкатолог идентификатора альбома.
  ///   - pohtosPathSegment: Строка, представляющая подкаталог для фотографий альбома.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  static func prepareAlbumPhotosAPIRequest(
    path: String,
    idPathSegment: String,
    phtosPathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let albumIdURL = url.appending(path: idPathSegment)
    let albumPhotosURL = albumIdURL.appending(path: phtosPathSegment)
    let request = prepareURLRequest(url: albumPhotosURL)
    return request
  }
 
  /// Подготавливает запрос для получения фотографии а так же информации о фотографии.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - idPathSegment: Строка, представляющая подкатолог идентификатора фотографии,
  ///   информацию о которой нужно получить.
  ///
  /// - Note: Сюда нужно совершить отдельный запрос так как фотография получаемая
  ///   в ячейке содержит ограниченную информацию о фотографии.
  static func preparePhotoInfoAPIRequest(
    path: String,
    idPathSegment: String
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path) else {
      throw APIError.URLError
    }
    let photoInfoURL = url.appending(component: idPathSegment)
    let request = prepareURLRequest(url: photoInfoURL)
    return request
  }
  
  /// Подготавливает запрос для получения профиля пользователя.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - usernamePathSegment: Строка, представляющая подкаталог, представляющий имя пользователя.
  static func prepareUserProfileAPIRequest(
    path: String,
    usernamePathSegment: String
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path) else {
      throw APIError.URLError
    }
    let profileURL = url.appending(component: usernamePathSegment)
    let request = prepareURLRequest(url: profileURL)
    return request
  }
  
  /// Подготавливает запрос для получения фотографий которые лайкал пользователь.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - usernamePathSegment: Строка, представляющая подкаталог, представляющий имя пользователя.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  static func prepareUserLikedPhotosAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let profileURL = url.appending(component: usernamePathSegment)
    let likedURL = profileURL.appending(component: Const.likesPathComponent)
    let request = prepareURLRequest(url: likedURL)
    return request
  }
  
  /// Подготавливает запрос для получения случайной фотографии из числа фотографий пользователя.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  /// - Note: Запрашиается вертикальная фотография.
  static func prepareRandomUserPhotoAPIRequest(
    path: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let randomURL = url.appending(component: Const.randomPathComponent)
    let request = prepareURLRequest(url: randomURL)
    return request
  }
  
  /// Подготавливает запрос для получения фотографий которые загрузил пользователь.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - usernamePathSegment: Строка, представляющая подкаталог, представляющий имя пользователя.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  static func prepareUserPhotosAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let profileURL = url.appending(component: usernamePathSegment)
    let photosURL = profileURL.appending(component: Const.photosPathComponent)
    let request = prepareURLRequest(url: photosURL)
    return request
  }
  
  /// Подготавливает запрос для получения альбомов которые создал пользователь.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - usernamePathSegment: Строка, представляющая подкаталог, представляющий имя пользователя.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  static func prepareUserAlbumsAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let profileURL = url.appending(component: usernamePathSegment)
    let collectionsURL = profileURL.appending(component: Const.collectionsPathComponent)
    let request = prepareURLRequest(url: collectionsURL)
    return request
  }
  
  /// Подготавливает общий запрос к API.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - parameters: Параметры, которые будут добавлены к URL запроса.
  /// - Note: Этот метод может быть использован для получения фотографий,
  /// альбомов, пользователей, а также для выполнения поисковых запросов по этим категориям.
  static func prepareAPIRequest(
    path: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let request = prepareURLRequest(url: url)
    return request
  }
  
  // MARK: Private Methods
  /// Подготавливает объект `URLRequest` для заданного URL.
  ///
  /// - Parameters:
  ///   - url: URL для которого будет создан запрос.
  /// - Returns: Настроенный объект `URLRequest` с заголовками и HTTP-методом.
  /// - Note: Этот метод устанавливает стандартные заголовки и метод запроса,
  /// которые могут быть изменены в зависимости от требований API.
  private static func prepareURLRequest(url: URL) -> URLRequest {
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
  private static func prepareURL(
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
  private static func prepareURLComponents(
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
  private static func prepareQueryItems(
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
  private static func prepareHeaders() -> Parameters {
    var headers: Parameters = [:]
    headers[Const.headerKey] = Const.сlientID + Authorization.accessKey
    return headers
  }
}

// MARK: - Const
fileprivate typealias Const = PrepareRequestConst

fileprivate enum PrepareRequestConst {
  static let headerKey = "Authorization"
  static let сlientID = "Client-ID" + .spacer
  static let photosPathComponent = "photos"
  static let likesPathComponent = "likes"
  static let randomPathComponent = "random"
  static let collectionsPathComponent = "collections"
}
