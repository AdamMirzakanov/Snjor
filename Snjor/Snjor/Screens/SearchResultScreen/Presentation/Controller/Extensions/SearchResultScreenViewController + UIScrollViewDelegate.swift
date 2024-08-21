//
//  SearchResultScreenViewController + UIScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

extension SearchResultScreenViewController {
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

