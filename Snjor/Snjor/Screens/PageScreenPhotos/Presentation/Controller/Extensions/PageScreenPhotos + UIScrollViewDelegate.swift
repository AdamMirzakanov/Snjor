//
//  PageScreenTopicPhotos + UIScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit

extension PageScreenPhotosViewController {
  override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
    return .bottom
  }

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
        deadline: .now() + .deadline
      ) {
        if let tabBar = self.tabBarController as? MainTabBarController {
          tabBar.showCustomTabBar()
        }
      }
    }
  }
}

private extension Double {
  static let deadline = 0.3
}
