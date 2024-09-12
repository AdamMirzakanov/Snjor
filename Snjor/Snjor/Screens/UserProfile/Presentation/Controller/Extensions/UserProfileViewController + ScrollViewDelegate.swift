//
//  UserProfileViewController + ScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

extension UserProfileViewController {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let contentOffsetX = scrollView.contentOffset.x
    let scrollViewWidth = scrollView.frame.width
    let progress = contentOffsetX / scrollViewWidth
    let indicatorWidth = scrollViewWidth / 3
    
    // Обновляем положение и ширину индикатора
    rootView.indicatorView.frame.origin.x = progress * indicatorWidth
    rootView.indicatorView.frame.size.width = indicatorWidth
  }
}
