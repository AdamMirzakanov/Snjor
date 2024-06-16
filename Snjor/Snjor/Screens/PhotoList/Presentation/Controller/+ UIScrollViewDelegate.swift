//
//  + UIScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

extension PhotoListCollectionViewController {
  // MARK: - Private Methods
  private func animateTabBarToPosition(_ yPosition: CGFloat) {
    UIView.animate(withDuration: 0.3) {
      self.tabBarController?.tabBar.frame.origin.y = yPosition
    }
  }

  // MARK: - UIScrollViewDelegate
  override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
    return .bottom
  }

  override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    animateTabBarToPosition(UIScreen.main.bounds.height)
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    animateTabBarToPosition(UIScreen.main.bounds.height - (tabBarController?.tabBar.frame.height ?? CGFloat.zero))
  }

  override func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool
  ) {
    if !decelerate {
      animateTabBarToPosition(UIScreen.main.bounds.height - (tabBarController?.tabBar.frame.height ?? CGFloat.zero))
    }
  }
}
