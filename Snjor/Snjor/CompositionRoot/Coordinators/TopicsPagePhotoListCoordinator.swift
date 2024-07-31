////
////  TopicsPagePhotoListCoordinator.swift
////  Snjor
////
////  Created by Адам Мирзаканов on 23.07.2024.
////
//
//final class TopicsPagePhotoListCoordinator: Coordinatable {
//  // MARK: - Internal Properties
//  var navigation: any Navigable
//  var childCoordinators: [any Coordinatable] = []
//  
//  // MARK: - Private Properties
//  private let factory: any TopicsPhotoListFactoryProtocol
//  
//  // MARK: - Initializers
//  init(
//    factory: any TopicsPagePhotoListFactoryProtocol,
//    navigation: any Navigable
//  ) {
//    self.factory = factory
//    self.navigation = navigation
//  }
//
//  // MARK: - Internal Methods
//  func start() {
//    let controller = factory.makeModule(delegate: self)
//    navigation.pushViewController(controller, animated: true)
//  }
//}
//
//extension TopicsPagePhotoListCoordinator: TopicPhotoListViewControllerDelegate {
//  func didSelect(_ photo: Photo) {
//    print("GGGGGGG")
//    //получить координатора следующего экрана
//    
//    //добавить координатор следуюещго экрана в дочерние
////    addAndStartChildCoordinator(coordinator)
//  }
//}
//
//extension TopicsPagePhotoListCoordinator: ParentCoordinator { }
