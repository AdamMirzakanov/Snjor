//
//  DownloadService.swift
//  Snjor
//
//  Created by Адам on 02.07.2024.
//

import Foundation

/// Класс, предоставляющий функционал для загрузки данных в фоновом режиме.
final class DownloadService {
  // MARK: Private Properties
  var sessions: [String: URLSession] = [:]
  
  // MARK: Internal Methods
  /// Создает и настраивает фоновую сессию с заданным делегатом и идентификатором.
  ///
  /// - Parameters:
  ///   - delegate: Делегат, реализующий протокол `URLSessionDelegate`, для управления событиями сессии.
  ///   - id: Уникальный идентификатор сессии, используемый для её создания и хранения.
  ///
  /// - Note: Метод создает фоновую сессию с указанным идентификатором и сохраняет её в словаре `sessions`, чтобы можно было отслеживать и управлять сессиями.
  func configureSession(
    delegate: URLSessionDelegate?,
    id: String
  ) {
    let configuration = URLSessionConfiguration.background(withIdentifier: id)
    let session = URLSession(
      configuration: configuration,
      delegate: delegate,
      delegateQueue: nil
    )
    sessions[id] = session
  }
  
  /// Запускает загрузку ресурса, используя заданную сессию и элемент, соответствующий протоколу `Downloadable`.
  ///
  /// - Parameters:
  ///   - item: Элемент, соответствующий протоколу `Downloadable`, предоставляющий URL для загрузки.
  ///   - sessionID: Идентификатор сессии, в которой будет выполняться загрузка.
  ///
  /// - Note: Метод проверяет наличие корректного URL и сессии с заданным идентификатором. Если одно из условий не выполняется, метод завершает выполнение без действий. Если все условия выполнены, создается и запускается задача загрузки (`downloadTask`).
  func startDownload<T: Downloadable>(_ item: T, sessionID: String) {
    guard
      let downloadURL = item.downloadURL,
      let session = sessions[sessionID]
    else {
      return
    }
    let downloadTask = session.downloadTask(with: downloadURL)
    downloadTask.resume()
  }
  
  /// Инвалидирует и отменяет сессию, идентифицируемую заданным идентификатором, и удаляет её из списка сессий.
  ///
  /// - Parameter id: Идентификатор сессии, которую нужно аннулировать.
  ///
  /// - Note: Метод проверяет наличие сессии с заданным идентификатором и, если такая сессия существует, вызывает метод `invalidateAndCancel` для её аннулирования и очистки. После этого сессия удаляется из словаря `sessions`.
  func invalidateSession(withID id: String) {
    sessions[id]?.invalidateAndCancel()
    sessions[id] = nil
  }
}
