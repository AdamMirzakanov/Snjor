//
//  AppContainer.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

protocol AppContainerProtocol {
  var apiClient: any Requestable & ImageDataRequestable { get }
  var localDataService: any LocalDataImageServiceProtocol { get }
  func getDataImageUseCase() -> any ImageDataUseCaseProtocol
}

struct AppContainer: AppContainerProtocol {

  // MARK: - Public Properties
  var apiClient: any Requestable & ImageDataRequestable = NetworkService()
  var localDataService: any LocalDataImageServiceProtocol = LocalDataImageService()

  // MARK: - Public  Methods
  func getDataImageUseCase() -> any ImageDataUseCaseProtocol {
    let imageDataRepository = ImageDataRepository(
      remoteDataService: apiClient,
      localDataCache: localDataService
    )
    return ImageDataUseCase(imageDataRepository: imageDataRepository)
  }
}
