//
//  Navigation + UINavigationControllerDelegate.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

extension Navigation: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    guard
      let controller = navigationController
        .transitionCoordinator?
        .viewController(forKey: .from),
      !navigationController
        .viewControllers
        .contains(controller)
    else {
      return
    }

    guard let completion = backCompletions[controller] else { return }
    completion()
    backCompletions.removeValue(forKey: controller)
  }
}
