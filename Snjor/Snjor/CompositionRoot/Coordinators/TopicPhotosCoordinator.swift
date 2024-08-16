//
//  TopicPhotosCoordinator.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.08.2024.
//

final class TopicPhotosCoordinator: Coordinatable, PageScreenTopicPhotosViewControllerDelegate {
  
  // MARK: - Internal Properties
  var navigation: any Navigable

  // MARK: - Private Properties
  private let factory: any TopicPhotosFactoryProtocol
  private weak var overlordCoordinator: (any ParentCoordinator)?
  
  // MARK: - Initializers
  init(
    factory: any TopicPhotosFactoryProtocol,
    navigation: any Navigable,
    overlordCoordinator: (any ParentCoordinator)?
  ) {
    self.factory = factory
    self.navigation = navigation
    self.overlordCoordinator = overlordCoordinator
  }

  // MARK: - Internal Methods
  func start() {
    let controller = factory.makeModule(delegate: self, layoutType: .multiColumn)
    navigation.pushViewController(controller, animated: true) { [weak self] in
      guard let self = self else { return }
      self.overlordCoordinator?.removeChildCoordinator(self)
    }
    navigation.navigationBar.tintColor = .label
    controller.navigationItem.largeTitleDisplayMode = .never
  }
}

extension TopicPhotosCoordinator {
  func didSelect(_ photo: Photo) {
    print(#function, Self.self)
  }
}
