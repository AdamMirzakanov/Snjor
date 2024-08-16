//
//  PageScreenTopicPhotos + UIScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit

extension PageScreenTopicPhotosViewController {
  // MARK: - UIScrollViewDelegate
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
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        if let tabBar = self.tabBarController as? MainTabBarController {
          tabBar.showCustomTabBar()
        }
      }
    }
  }
}
