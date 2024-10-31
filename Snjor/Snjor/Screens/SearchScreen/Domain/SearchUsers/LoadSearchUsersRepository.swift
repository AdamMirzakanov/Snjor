//
//  LoadSearchUsersRepository.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

import Foundation

// MARK: - Protocol
/// Протокол для репозитория, отвечающего за загрузку списка юзеров по поисковому запросу.
protocol LoadSearchUsersRepositoryProtocol {
  
  /// Асинхронная функция, выполняющая загрузку списка юзеров по поисковому запросу.
  /// - Parameter request: Объект типа `URLRequest`,
  ///  содержащий параметры и информацию для запроса.
  /// - Returns: Возвращает массив объектов типа `[SearchUsers]`.
  /// - Throws: При выполнении сетевого запроса может быть выброшена ошибка.
  func fetchSearchUsers(request: URLRequest) async throws -> SearchUsers
}

// MARK: - Struct
struct LoadSearchUsersRepository: LoadSearchUsersRepositoryProtocol {
  
  /// Сервис сети, который выполняет запросы.
  let networkService: any Requestable
  
  func fetchSearchUsers(request: URLRequest) async throws -> SearchUsers {
    return try await networkService.request(
      request: request,
      type: SearchUsers.self
    )
  }
}
