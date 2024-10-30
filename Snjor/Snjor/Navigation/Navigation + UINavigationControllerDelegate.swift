//
//  Navigation + UINavigationControllerDelegate.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

extension Navigation: UINavigationControllerDelegate {
  
  /// Метод вызывается, когда навигационный контроллер завершает показ нового вью-контроллера.
  ///
  /// - Parameters:
  ///   - navigationController: Навигационный контроллер, в котором произошло событие.
  ///   - viewController: Вью-контроллер, который был показан.
  ///   - animated: Флаг, указывающий, происходил ли переход с анимацией.
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    // Проверяем, существует ли координатор перехода и
    // есть ли вью-контроллер, с которого произошел переход.
    guard
      let controller = navigationController
        .transitionCoordinator?
        .viewController(forKey: .from),
      // Убеждаемся, что данный контроллер больше не находится в стеке навигации.
      !navigationController
        .viewControllers
        .contains(controller)
    else {
      return
    }
    
    // Выполняем замыкание, если оно существует, и удаляем его из словаря.
    guard let completion = backCompletions[controller] else { return }
    completion()
    backCompletions.removeValue(forKey: controller)
  }
}
