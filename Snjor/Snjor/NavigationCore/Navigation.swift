//
//  Navigation.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

final class Navigation {
  // MARK: - Protocol Properties
  var rootViewController: UINavigationController
  var dismissNavigation: (() -> Void)?

  // MARK: - Public Properties
  var backCompletions: [UIViewController: () -> Void] = [:]

  // MARK: - Initializers
  init(rootViewController: UINavigationController) {
    self.rootViewController = rootViewController
  }
}
