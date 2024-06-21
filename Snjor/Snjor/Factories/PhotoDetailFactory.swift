//
//  PhotoDetailFactory.swift
//  Snjor
//
//  Created by Адам on 20.06.2024.
//

import UIKit
import Combine

protocol PhotoDetailFactoryProtocol {
  func makeModule() -> UIViewController
}

struct PhotoDetailFactory: PhotoDetailFactoryProtocol {

  func makeModule() -> UIViewController {
    let state = PassthroughSubject<StateController, Never>()
    let apiClient = NetworkService()
    let photoDetailRepository = PhotoDetailRepository(apiClient: apiClient)
    let loadPhotoDetailUseCase = LoadPhotoDetailUseCase(
      photoDetailRepository: photoDetailRepository
    )
    let module = PhotoDetailViewController()
    return module
  }
}
