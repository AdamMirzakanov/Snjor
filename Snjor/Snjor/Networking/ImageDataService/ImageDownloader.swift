//
//  ImageDownloader.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

final class ImageDownloader {
  // MARK: Private Properties
  private var imageDataTask: URLSessionDataTask?
  private let cache = ImageCacheService.cache
  
  // MARK: Internal Methods
  func cancel() {
    imageDataTask?.cancel()
  }
  
  func downloadPhoto(
    with url: URL,
    completion: @escaping (UIImage?, Bool) -> Void
  ) {
    let urlRequest = URLRequest(url: url)
    if let cachedImage = getCachedImage(for: urlRequest) {
      completion(cachedImage, true)
      return
    }
    fetchImage(from: url) { [weak self] data, response in
      guard
        let self = self,
        let data = data,
        let response = response,
        let image = UIImage(data: data)
      else {
        completion(nil, false)
        return
      }
      self.cacheImage(data, response: response, for: urlRequest)
      decodeImageInBackground(image, completion: completion)
    }
  }
  
  // MARK: Private Methods
  private func getCachedImage(for request: URLRequest) -> UIImage? {
    if let cachedResponse = cache.cachedResponse(for: request),
       let image = UIImage(data: cachedResponse.data) {
      return image
    }
    return nil
  }
  
  private func fetchImage(
    from url: URL,
    completion: @escaping (Data?, URLResponse?) -> Void
  ) {
    imageDataTask = URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil else {
        completion(nil, nil)
        return
      }
      completion(data, response)
    }
    imageDataTask?.resume()
  }
  
  private func cacheImage(
    _ data: Data,
    response: URLResponse,
    for request: URLRequest
  ) {
    let cachedResponse = CachedURLResponse(response: response, data: data)
    cache.storeCachedResponse(cachedResponse, for: request)
  }

  private func decodeImageInBackground(
    _ image: UIImage,
    completion: @escaping (UIImage?, Bool) -> Void
  ) {
    DispatchQueue.global(qos: .userInteractive).async {
      let decodedImage = image.preloadedImage()
      DispatchQueue.main.async {
        completion(decodedImage, false)
      }
    }
  }
}
