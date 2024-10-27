//
//  MainViewController.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

class MainViewController<ViewType: UIView>: UIViewController, UIScrollViewDelegate {
  
  typealias RootView = ViewType
  
  // MARK: Override Methods
  override func loadView() {
    let customView = RootView()
    view = customView
  }
  
  // MARK: - Internal Methods
  /// Свойство `shouldShowTabBarOnScroll`, которое можно переопределить в подклассах,
  /// где требуется указать, что панель вкладок никогда не должна отображаться при прокрутке.
  /// Возвращаемое значение по умолчанию — `true`, что означает, что в базовой реализации
  /// панель вкладок отображается. Подклассы могут изменить это значение на `false`,
  /// чтобы скрывать панель вкладок при прокрутке.
  var shouldShowTabBarOnScroll: Bool {
    return true
  }
  
  /// Метод `hideCustomTabBar`, который скрывает пользовательскую панель вкладок.
  /// Он проверяет, является ли `tabBarController` экземпляром `MainTabBarController`
  /// и вызывает метод `hideCustomTabBar()` этого контроллера, если проверка успешна.
  /// Это позволяет управлять видимостью пользовательской панели вкладок из текущего контекста.
  func hideCustomTabBar() {
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }
  
  /// Метод `showCustomTabBar`, который отображает пользовательскую панель вкладок.
  /// Проверяет, является ли `tabBarController` экземпляром `MainTabBarController`,
  /// и вызывает метод `showCustomTabBar()` этого контроллера, если проверка успешна.
  /// Это позволяет управлять видимостью пользовательской панели вкладок из текущего контекста.
  func showCustomTabBar() {
    if let tabBar = self.tabBarController as? MainTabBarController {
      tabBar.showCustomTabBar()
    }
  }
  
  // MARK: UIScrollViewDelegate
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    if shouldShowTabBarOnScroll {
      hideCustomTabBar()
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if shouldShowTabBarOnScroll {
      showCustomTabBar()
    }
  }
  
  func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool
  ) {
    if !decelerate {
      DispatchQueue.main.asyncAfter(
        deadline: .now() + .tabBarShowDelay
      ) { [weak self] in
        guard let self = self else { return }
        if shouldShowTabBarOnScroll {
          self.showCustomTabBar()
        }
      }
    }
  }
  
  /// Метод `scrollViewDidScroll`, который будет переопределен в подклассах,
  /// где требуется специальное управление поведением при прокрутке.
  /// Метод вызывается при изменении положения содержимого в `UIScrollView`.
  ///
  /// Помечен модификаторами `@objc` и `dynamic` для обеспечения
  /// динамического переопределения в расширениях.
  @objc dynamic func scrollViewDidScroll(_ scrollView: UIScrollView) { }
}
