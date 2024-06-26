//
//  ImageDataUseCase.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

protocol ImageDataUseCaseProtocol {
  func getData(url: URL?) async -> Data?
  func getDataFromCache(url: URL?) -> Data?
}

struct ImageDataUseCase: ImageDataUseCaseProtocol {

  private(set) var imageDataRepository: any ImageDataRepositoryProtocol

  func getData(url: URL?) async -> Data? {
    let data = await imageDataRepository.fetchData(url: url)
    return data
  }

  func getDataFromCache(url: URL?) -> Data? {
    let data = imageDataRepository.getFromCache(url: url)
    return data
  }
}
