//
//  SearchScreenViewController + UIScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.08.2024.
//

import UIKit

extension SearchScreenViewController {
  
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
}
