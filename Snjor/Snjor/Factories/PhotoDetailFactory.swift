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
  let id: String
  let apiClient = NetworkService()
  let appContainer: any AppContainerProtocol

  func makeModule() -> UIViewController {
    let state = PassthroughSubject<StateController, Never>()

    let photoDetailRepository = PhotoDetailRepository(apiClient: appContainer.apiClient)
    let loadPhotoDetailUseCase = LoadPhotoDetailUseCase(
      photoDetailRepository: photoDetailRepository,
      id: id
    )
    let viewModel = PhotoDetailViewModel(
      state: state,
      loadPhotoDetailUseCase: loadPhotoDetailUseCase, 
      dataImageUseCase: appContainer.getDataImageUseCase()
    )
    // 🟢
//    viewModel.photo?.id = id
    let module = PhotoDetailViewController(viewModel: viewModel)
    return module
  }
}
