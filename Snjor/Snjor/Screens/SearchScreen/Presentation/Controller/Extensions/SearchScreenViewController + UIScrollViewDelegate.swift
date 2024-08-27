//
//  SearchScreenViewController + UIScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.08.2024.
//

import UIKit

extension SearchScreenViewController {
  override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
    return .bottom
  }
  
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
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
        guard let self = self else { return }
        self.showCustomTabBar()
      }
    }
  }
}
