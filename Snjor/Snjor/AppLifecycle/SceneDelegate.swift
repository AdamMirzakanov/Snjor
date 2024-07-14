//
//  SceneDelegate.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  // MARK: - Internal Properties
  var window: UIWindow?

  // MARK: - Private Properties
  private var appCoordinator: AppCoordinator?
  private var appFactory: (any AppFactoryProtocol)?

  // MARK: - Internal Methods
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    appFactory = AppFactory()
    let navigationController = UINavigationController()
    let navigation = Navigation(rootViewController: navigationController)

    appCoordinator = AppCoordinator(
      navigation: navigation,
      window: window,
      factory: appFactory
    )
    guard let appCoordinator = appCoordinator else { return }
    appCoordinator.start()
  }

  func sceneDidDisconnect(_ scene: UIScene) { }
  func sceneDidBecomeActive(_ scene: UIScene) { }
  func sceneWillResignActive(_ scene: UIScene) { }
  func sceneWillEnterForeground(_ scene: UIScene) { }
  func sceneDidEnterBackground(_ scene: UIScene) { }
}
