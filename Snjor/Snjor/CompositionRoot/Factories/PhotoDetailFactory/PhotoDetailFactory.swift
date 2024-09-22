//
//  PhotoDetailFactory.swift
//  Snjor
//
//  Created by Адам on 20.06.2024.
//

import UIKit
import Combine

struct PhotoDetailFactory: PhotoDetailFactoryProtocol {
  // MARK: Internal Properties
  let photo: Photo

  // MARK: Internal Methods
  func makeController(
    delegate: any PhotoDetailViewControllerDelegate
  ) -> UIViewController {
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
    return PhotoDetailViewController(
      viewModel: viewModel, 
      delegate: delegate
    )
  }
  
  func makeSearchResultScreenCoordinator(
    currentScopeIndex: Int,
    with searchTerm: String,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = SearchResultScreenFactory(
      currentScopeIndex: currentScopeIndex,
      with: searchTerm
    )
    return SearchResultScreenCoordinator(
      factory: factory,
      navigation: navigation,
      parentCoordinator: parentCoordinator
    )
  }
  
  func makeUserProfileCoordinator(
    user: User,
    navigation: any Navigable,
    parentCoordinator: any ParentCoordinator
  ) -> any Coordinatable {
    let factory = UserProfileFactory(user: user)
    return UserProfileCoordinator(
      factory: factory,
      navigation: navigation,
      parentCoordinator: parentCoordinator
    )
  }
}
