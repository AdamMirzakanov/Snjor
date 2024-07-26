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
  let photo: Photo

  func makeModule() -> UIViewController {
    let state = PassthroughSubject<StateController, Never>()
    let networkService = NetworkService()
    let repository = LoadPhotoDetailRepository(
      networkService: networkService
    )
    let loadUseCase = LoadPhotoDetailUseCase(
      repository: repository,
      photo: photo
    )
    let viewModel = PhotoDetailViewModel(
      state: state,
      loadUseCase: loadUseCase
    )
    viewModel.photo = photo
    let module = PhotoDetailViewController(viewModel: viewModel)
    return module
  }
}
