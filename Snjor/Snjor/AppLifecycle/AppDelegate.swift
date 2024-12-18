//
//  AppDelegate.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

@main
final class AppDelegate: UIResponder { }

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(
      name: AppDelegateConst.defaultConfiguration,
      sessionRole: connectingSceneSession.role
    )
  }
  
  func application(
    _ application: UIApplication,
    didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}

// MARK: - Constants
private enum AppDelegateConst {
  static let defaultConfiguration: String = "Default Configuration"
}
