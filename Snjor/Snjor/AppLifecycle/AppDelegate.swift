//
//  AppDelegate.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var backgroundSessionCompletionHandler: (() -> Void)?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return true
  }

  // MARK: - UISceneSession Lifecycle
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role
    )
  }

  func application(
    _ application: UIApplication,
    didDiscardSceneSessions sceneSessions: Set<UISceneSession>
  ) {
  }

  func application(
    _ application: UIApplication,
    handleEventsForBackgroundURLSession handleEventsForBackgroundURLSessionidentifier: String,
    completionHandler: @escaping () -> Void
  ) {
    backgroundSessionCompletionHandler = completionHandler
  }

}
