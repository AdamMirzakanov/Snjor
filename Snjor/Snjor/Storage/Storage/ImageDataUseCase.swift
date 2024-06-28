//
//  ImageDataUseCase.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

protocol ImageDataUseCaseProtocol {
  func getData(url: URL?, id: String) async -> Data?
  func getDataFromCache(id: String?) -> Data?
}

struct ImageDataUseCase: ImageDataUseCaseProtocol {

  private(set) var imageDataRepository: any ImageDataRepositoryProtocol

  func getData(url: URL?, id: String) async -> Data? {
    let data = await imageDataRepository.fetchData(url: url, id: id)
    return data
  }

  // 3
  func getDataFromCache(id: String?) -> Data? {
    let data = imageDataRepository.getFromCache(id: id)
    return data
  }
}
