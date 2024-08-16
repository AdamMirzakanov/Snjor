//
//  TopicsPageFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit
import Combine

struct TopicsPageFactory: TopicsPageFactoryProtocol {
  
  // MARK: - Internal Methods
  func makeTabBarItem(navigation: any Navigable) {
    makeTabBarItem(
      navigation: navigation,
      title: ".photoListTitle",
      systemImageName: ".photoListItemImage",
      selectedSystemImageName: ".photoListSelectedItemImage"
    )
  }
  
  func makeModule() -> UIViewController {
    let state = PassthroughSubject<StateController, Never>()
    let networkService = NetworkService()
    let repository = LoadTopicsPageRepository(
      networkService: networkService
    )
    let loadUseCase = LoadTopicsUseCase(
      repository: repository
    )
    let viewModel = TopicsViewModel(
      state: state,
      loadUseCase: loadUseCase
    )
    let module = PageScreenViewController(viewModel: viewModel)
    return module
  }
}

// MARK: - TabBarItemFactory
extension TopicsPageFactory: TabBarItemFactory { }
