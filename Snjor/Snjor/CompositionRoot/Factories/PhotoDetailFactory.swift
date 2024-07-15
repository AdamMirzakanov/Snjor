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
    let apiClient = NetworkService()
    let photoDetailRepository = PhotoDetailRepository(apiClient: apiClient)
    let loadPhotoDetailUseCase = LoadPhotoDetailUseCase(
      photoDetailRepository: photoDetailRepository,
      photo: photo
    )
    let viewModel = PhotoDetailViewModel(
      state: state,
      loadPhotoDetailUseCase: loadPhotoDetailUseCase
    )
    viewModel.photo = photo
    let module = PhotoDetailViewController(viewModel: viewModel)
    return module
  }
}
