//
//  PageScreenTopicPhotos + UIScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit

extension PageScreenPhotosViewController {

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.showCustomTabBar()
    }
  }

  func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool
  ) {
    if !decelerate {
      DispatchQueue.main.asyncAfter(
        deadline: .now() + .tabBarShowDelay
      ) {
        if let tabBar = self.tabBarController as? MainTabBarController {
          tabBar.showCustomTabBar()
        }
      }
    }
  }
}
