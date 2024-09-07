//
//  SceneDelegate.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  // MARK: Internal Properties
  var window: UIWindow?
  
  // MARK: Private Properties
  private var appCoordinator: AppCoordinator?
  private var appFactory: (any AppFactoryProtocol)?
  
  // MARK: Internal Methods
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = getWindowScene(from: scene) else {
      return
    }
    configureWindow(with: windowScene)
    initializeAppCoordinator()
    startAppCoordinator()
  }
  
  // MARK: Private Methods
  private func getWindowScene(from scene: UIScene) -> UIWindowScene? {
    return scene as? UIWindowScene
  }
  
  private func configureWindow(with windowScene: UIWindowScene) {
    window = UIWindow(windowScene: windowScene)
  }
  
  private func initializeAppCoordinator() {
    appFactory = AppFactory()
    let navigationController = UINavigationController()
    let navigation = Navigation(rootViewController: navigationController)
    appCoordinator = AppCoordinator(
      navigation: navigation,
      window: window,
      factory: appFactory
    )
  }
  
  private func startAppCoordinator() {
    appCoordinator?.start()
  }
}
