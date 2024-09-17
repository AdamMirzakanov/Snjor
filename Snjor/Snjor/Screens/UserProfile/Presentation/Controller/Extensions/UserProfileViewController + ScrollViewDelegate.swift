//
//  UserProfileViewController + ScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

extension UserProfileViewController {
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let contentOffsetX = scrollView.contentOffset.x
    let scrollViewWidth = scrollView.frame.width
    let progress = contentOffsetX / scrollViewWidth
    let indicatorWidth = scrollViewWidth / 3
    let position = progress * indicatorWidth + 20
    rootView.indicatorView.frame.origin.x = position
    rootView.indicatorView.frame.size.width = indicatorWidth
    rootView.updateLabelBasedOnVisibleCell(viewModel: userProfileViewModel) 
  }
}
