//
//  ImageDownloader.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

/// Класс `ImageDownloader` отвечает за загрузку изображений из интернета
/// с использованием `URLSession` и кэшированием загруженных данных.
final class ImageDownloader {
  
  // MARK: Private Properties
  /// Задача `URLSessionDataTask`, представляющая текущий процесс загрузки изображения.
  ///
  /// Используется для отслеживания и управления загрузкой изображения.
  /// Если задача активна, ее можно отменить вызовом метода `cancel()`.
  private var imageDataTask: URLSessionDataTask?
  
  /// Экземпляр кэша изображений, предоставляемый `ImageCacheService`.
  ///
  /// Используется для хранения и извлечения ранее загруженных изображений,
  /// что позволяет ускорить доступ к ним и уменьшить количество сетевых запросов.
  private let cache = ImageCacheService.cache
  
  // MARK: Internal Methods
  /// Метод для загрузки изображения по заданному URL и передачи результата в
  /// замыкание по завершении загрузки.
  ///
  /// - Параметры:
  ///   - `url`: URL-адрес, по которому будет загружаться изображение.
  ///   - `completion`: Замыкание, которое будет вызвано по завершении загрузки.
  ///     Принимает два параметра: загруженное изображение (или `nil`, если
  ///     загрузка не удалась) и булевый флаг, указывающий, было ли изображение
  ///     получено из кэша.
  ///
  /// - Логика работы:
  ///   1. Создается объект `URLRequest` для указанного URL.
  ///   2. Проверяется наличие кэшированного ответа для данного запроса.
  ///      Если кэш существует, изображение извлекается из него и передается в
  ///      замыкание с флагом `true`.
  ///   3. Если кэша нет, создается задача `URLSessionDataTask` для загрузки
  ///      изображения с указанного URL.
  ///   4. Внутри задачи проверяются данные, ответ и наличие ошибок. Если данные
  ///      валидны, они кэшируются для последующего использования.
  ///   5. Изображение декодируется в фоновом потоке, после чего результат
  ///      передается в основную очередь через замыкание, чтобы обновить UI.
  func downloadPhoto(
    with url: URL,
    completion: @escaping ((UIImage?, Bool) -> Void)
  ) {
    let urlRequest = URLRequest(url: url)
    
    if let cachedResponse = cache.cachedResponse(for: urlRequest),
       let image = UIImage(data: cachedResponse.data) {
      completion(image, true)
      return
    }
    
    imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (
      data, response, error
    ) in
      guard let self = self else { return }
      self.imageDataTask = nil
      
      guard
        let data = data,
        let response = response,
        let image = UIImage(data: data),
        error == nil
      else {
        return
      }
      
      let urlRequest = URLRequest(url: url)
      let cachedResponse = CachedURLResponse(
        response: response,
        data: data
      )
      self.cache.storeCachedResponse(
        cachedResponse,
        for: urlRequest
      )
      
      // Декодировать изображение в фоновом потоке
      DispatchQueue.global(qos: .userInteractive).async {
        let decodedImage = image.preloadedImage()
        DispatchQueue.main.async {
          completion(decodedImage, false)
        }
      }
    }
    imageDataTask?.resume()
  }
  
  /// Метод для отмены текущей задачи загрузки изображения.
  func cancel() {
    imageDataTask?.cancel()
  }
}
