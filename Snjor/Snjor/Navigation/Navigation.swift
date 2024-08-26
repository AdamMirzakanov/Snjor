//
//  Navigation.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

final class Navigation: NSObject {
  // MARK: - Internal Properties
  var rootViewController: UINavigationController
  var dismissNavigation: (() -> Void)?
  var backCompletions: [UIViewController: () -> Void] = [:]

  // MARK: - Initializers
  init(rootViewController: UINavigationController) {
    self.rootViewController = rootViewController
    super.init()
    rootViewController.presentationController?.delegate = self
    rootViewController.delegate = self
    print(rootViewController, "🔶")
  }
}
