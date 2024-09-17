//
//  MainViewController.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

class MainViewController<ViewType: UIView>: UIViewController, UIScrollViewDelegate {
  
  typealias RootView = ViewType
  
  // MARK: Override Properties
  override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
    return .bottom
  }
  
  // MARK: Override Methods
  override func loadView() {
    let customView = RootView()
    view = customView
  }
  
  
  // MARK: - Cкрыть / Отобразить TabBar
  ///Переопределить это свойство в наследниках где панель вкладок никогда не должна отображатсья
  var shouldShowTabBarOnScroll: Bool {
    return true
  }
  
  func hideCustomTabBar() {
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }
  
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
  
  /// Будет переопределен в подклассах где требуется специальное управление скролом.
  @objc dynamic func scrollViewDidScroll(_ scrollView: UIScrollView) { }
}
