//
//  PageScreenTopicPhotos + UIScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit

extension PageScreenPhotosViewController {
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    hideCustomTabBar()
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    showCustomTabBar()
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
        self.showCustomTabBar()
      }
    }
  }
  
  // MARK: Private Methods
  private func hideCustomTabBar() {
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }
  
  private func showCustomTabBar() {
    if let tabBar = self.tabBarController as? MainTabBarController {
      tabBar.showCustomTabBar()
    }
  }
}
