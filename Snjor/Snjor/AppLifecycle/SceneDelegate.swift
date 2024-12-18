//
//  SceneDelegate.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

final class SceneDelegate: UIResponder {
  // MARK: Internal Properties
  var window: UIWindow?
  
  // MARK: Private Properties
  private var appCoordinator: AppCoordinator?
  private var appFactory: (any AppFactoryProtocol)?
}

// MARK: - UIWindowSceneDelegate
extension SceneDelegate: UIWindowSceneDelegate {
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    sceneInit(scene)
  }
}

// MARK: - Config Window
private extension SceneDelegate {
  func sceneInit(_ scene: UIScene) {
    configWindow(with: scene)
    initializeAppCoordinator()
    startAppCoordinator()
  }
  
  func configWindow(with scene: UIScene) {
    guard let windowScene = scene as? UIWindowScene else { return }
    window = UIWindow(windowScene: windowScene)
  }
  
  func initializeAppCoordinator() {
    appFactory = AppFactory()
    let navigationController = UINavigationController()
    let navigation = Navigation(rootViewController: navigationController)
    appCoordinator = AppCoordinator(
      navigation: navigation,
      window: window,
      factory: appFactory
    )
  }
  
  func startAppCoordinator() {
    appCoordinator?.start()
  }
}
