//
//  ImageDataRepository.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

protocol ImageDataRepositoryProtocol {
    func fetchData(url: URL?, id: String) async -> Data?
    func getFromCache(id: String?) -> Data?
}

struct ImageDataRepository: ImageDataRepositoryProtocol {

  private(set) var remoteDataService: any ImageDataRequestable
  private(set) var localDataCache: any LocalDataImageServiceProtocol

  /// изначально я сохранялся по url
  /// однако адреса изображений в ячейке и на экране деталей, 
  /// а так-же хэши изображений отличны из-за спецификации api
  func fetchData(url: URL?, id: String) async -> Data? {
    guard let url = url else { return nil }
    let data = await remoteDataService.request(url: url)
    localDataCache.save(key: id, data: data)
    return data
  }

  // 2
  func getFromCache(id: String?) -> Data? {
    guard let id = id else { return nil }
    return localDataCache.get(key: id)
  }
}
