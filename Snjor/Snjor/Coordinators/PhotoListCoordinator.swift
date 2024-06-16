//
//  PhotoListCoordinator.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

final class PhotoListCoordinator: Coordinatable {
  // MARK: - Public Properties
  var navigation: any Navigable

  // MARK: - Private Properties
  private let factory: any PhotoListFactoryProtocol

  // MARK: - Initializers
  init(
    factory: any PhotoListFactoryProtocol,
    navigation: any Navigable
  ) {
    self.factory = factory
    self.navigation = navigation
  }

  // MARK: - Public Methods
  func start() {
    let controller = factory.makeModule(delegate: self)
    factory.makeTabBarItem(navigation: navigation)
    navigation.pushViewController(controller, animated: true)
  }
}

// MARK: - PhotosCollectionViewControllerDelegate
extension PhotoListCoordinator: PhotoListViewControllerDelegate {
  func didSelect() {
    // code
  }
}
