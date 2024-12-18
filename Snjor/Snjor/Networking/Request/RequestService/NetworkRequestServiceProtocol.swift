//
//  NetworkRequestServiceProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import Foundation

protocol NetworkRequestServiceProtocol: AnyObject {
  /// Подготавливает запрос для получения заголовков топиков.
  ///
  /// - Parameters:
  ///   - path: Строка, представляющая базовый путь для запроса.
  func prepareTopicsTitleAPIRequest(
    path: String
  ) throws -> URLRequest
  
  /// Подготавливает запрос для получения фотографий Топика.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - idPathSegment: Строка, представляющая подкатолог идентификатора топика.
  ///   - pohtosPathSegment: Строка, представляющая подкаталог для фотографий.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  func prepareTopicPhotosAPIRequest(
    path: String,
    idPathSegment: String,
    photosPathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest
  
  /// Подготавливает запрос для получения фотографий Альбома.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - idPathSegment: Строка, представляющая подкатолог идентификатора альбома.
  ///   - pohtosPathSegment: Строка, представляющая подкаталог для фотографий альбома.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  func prepareAlbumPhotosAPIRequest(
    path: String,
    idPathSegment: String,
    phtosPathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest
  
  /// Подготавливает запрос для получения фотографии а так же информации о фотографии.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - idPathSegment: Строка, представляющая подкатолог идентификатора фотографии,
  ///   информацию о которой нужно получить.
  ///
  /// - Note: Сюда нужно совершить отдельный запрос так как фотография получаемая
  ///   в ячейке содержит ограниченную информацию о фотографии.
  func preparePhotoInfoAPIRequest(
    path: String,
    idPathSegment: String
  ) throws -> URLRequest
  
  /// Подготавливает запрос для получения профиля пользователя.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - usernamePathSegment: Строка, представляющая подкаталог, представляющий имя пользователя.
  func prepareUserProfileAPIRequest(
    path: String,
    usernamePathSegment: String
  ) throws -> URLRequest
  
  /// Подготавливает запрос для получения фотографий которые лайкал пользователь.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - usernamePathSegment: Строка, представляющая подкаталог, представляющий имя пользователя.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  func prepareUserLikedPhotosAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest
  
  /// Подготавливает запрос для получения случайной фотографии из числа фотографий пользователя.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  /// - Note: Запрашиается вертикальная фотография.
  func prepareRandomUserPhotoAPIRequest(
    path: String,
    parameters: Parameters
  ) throws -> URLRequest
  
  /// Подготавливает запрос для получения фотографий которые загрузил пользователь.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - usernamePathSegment: Строка, представляющая подкаталог, представляющий имя пользователя.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  func prepareUserPhotosAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest
  
  /// Подготавливает запрос для получения альбомов которые создал пользователь.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - usernamePathSegment: Строка, представляющая подкаталог, представляющий имя пользователя.
  ///   - parameters: Параметры запроса, которые будут добавлены к URL.
  func prepareUserAlbumsAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest
  
  /// Подготавливает общий запрос к API.
  ///
  /// - Parameters:
  ///   - path: Базовый путь для формирования запроса.
  ///   - parameters: Параметры, которые будут добавлены к URL запроса.
  /// - Note: Этот метод может быть использован для получения фотографий,
  /// альбомов, пользователей, а также для выполнения поисковых запросов по этим категориям.
  func prepareAPIRequest(
    path: String,
    parameters: Parameters
  ) throws -> URLRequest
}
