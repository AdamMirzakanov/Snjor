//
//  Navigable.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

protocol Navigable {
  // MARK: Properties
  var rootViewController: UINavigationController { get }
  var navigationBar: UINavigationBar { get }
  var viewControllers: [UIViewController] { get set }
  var dismissNavigation: (() -> Void)? { get set }

  // MARK: Methods
  func present(
    _ viewController: UIViewController,
    animated: Bool
  )

  func pushViewController(
    _ viewControllerToPresent: UIViewController,
    animated: Bool,
    backCompletion: (() -> Void)?
  )

  func dismiss(animated: Bool)
}

// MARK: - Default method implementation
extension Navigable {
  func pushViewController(
    _ viewControllerToPresent: UIViewController,
    animated: Bool
  ) {
    pushViewController(
      viewControllerToPresent,
      animated: animated,
      backCompletion: nil
    )
  }
}
