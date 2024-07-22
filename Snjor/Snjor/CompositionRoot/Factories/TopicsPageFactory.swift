//
//  TopicsPageFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit
import Combine

protocol TopicsPageFactoryProtocol {
  func makeTabBarItem(navigation: any Navigable)
  func makeModule() -> UIViewController
}

struct TopicsPageFactory: TopicsPageFactoryProtocol {
  
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
    let apiClient = NetworkService()
    let topicsPageRepository = TopicsPageRepository(apiClient: apiClient)
    let loadTopicsPageUseCase = LoadTopicsPageUseCase(
      topicsPageRepository: topicsPageRepository
    )
    let viewModel = TopicsPageViewModel(
      state: state,
      loadTopicsPageUseCase: loadTopicsPageUseCase
    )
    let module = TopicsPageViewController(viewModel: viewModel)
    return module
  }
}

// MARK: - TabBarItemFactory
extension TopicsPageFactory: TabBarItemFactory { }
