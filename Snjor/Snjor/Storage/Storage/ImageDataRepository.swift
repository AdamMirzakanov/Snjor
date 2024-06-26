//
//  ImageDataRepository.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

protocol ImageDataRepositoryProtocol {
    func fetchData(url: URL?) async -> Data?
    func getFromCache(url: URL?) -> Data?
}

struct ImageDataRepository: ImageDataRepositoryProtocol {

  private(set) var remoteDataService: any ImageDataRequestable
  private(set) var localDataCache: any LocalDataImageServiceProtocol

  func fetchData(url: URL?) async -> Data? {
    guard let url = url else { return nil }
    let data = await remoteDataService.request(url: url)
    localDataCache.save(key: url, data: data)
    return data
  }

  func getFromCache(url: URL?) -> Data? {
    guard let url = url else { return nil }
    let data = localDataCache.get(key: url)
    return data
  }
}
