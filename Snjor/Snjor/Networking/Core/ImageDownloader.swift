//
//  ImageDownloader.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

class ImageDownloader {
  // MARK: - Private Properties
  private var imageDataTask: URLSessionDataTask?
  private let cache = ImageCache.cache

  // MARK: - Internal Methods
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

    imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
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

      // Decode the JPEG image in a background thread
      DispatchQueue.global(qos: .userInteractive).async {
        let decodedImage = image.preloadedImage()
        DispatchQueue.main.async {
          completion(decodedImage, false)
        }
      }
    }
    imageDataTask?.resume()
  }

  func cancel() {
    imageDataTask?.cancel()
  }
}
