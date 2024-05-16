//
//  Navigation + Navigable.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

extension Navigation: Navigable {
  // MARK: - Protocol Computed Properties
  var navigationBar: UINavigationBar {
    rootViewController.navigationBar
  }

  var viewControllers: [UIViewController] {
    get {
      rootViewController.viewControllers
    }
    set {
      rootViewController.viewControllers = newValue
    }
  }

  // MARK: - Protocol Methods
  func present(
    _ viewController: UIViewController,
    animated: Bool
  ) {
    rootViewController.present(viewController, animated: animated)
  }

  func pushViewController(
    _ viewControllerToPresent: UIViewController,
    animated: Bool,
    backCompletion: (() -> Void)?
  ) {
    if let backCompletion = backCompletion {
      backCompletions[viewControllerToPresent] = backCompletion
    }

    rootViewController.pushViewController(
      viewControllerToPresent,
      animated: animated
    )
  }

  func dismiss(animated: Bool) {
    rootViewController.dismiss(animated: animated)
  }
}

