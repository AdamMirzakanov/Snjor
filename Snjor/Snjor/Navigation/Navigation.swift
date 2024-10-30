//
//  Navigation.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

final class Navigation: NSObject {
  // MARK: Navigable Protocol Properties
  var rootViewController: UINavigationController
  
  // MARK: Internal Properties
  /// Замыкание, вызываемое при закрытии текущей навигации.
  var dismissNavigation: (() -> Void)?
  
  /// Словарь для хранения замыканий, которые выполняются при
  /// нажатии кнопки "Назад" для определенных вью-контроллеров.
  var backCompletions: [UIViewController: () -> Void] = [:]

  // MARK: Initializers
  init(rootViewController: UINavigationController) {
    self.rootViewController = rootViewController
    super.init()
    rootViewController.presentationController?.delegate = self
    rootViewController.delegate = self
  }
}
