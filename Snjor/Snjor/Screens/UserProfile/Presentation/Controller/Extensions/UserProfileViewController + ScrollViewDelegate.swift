//
//  UserProfileViewController + ScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerConst

extension UserProfileViewController {
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let contentOffsetX = scrollView.contentOffset.x
    let scrollViewWidth = scrollView.frame.width  
    let progress = contentOffsetX / scrollViewWidth
    let indicatorWidth = scrollViewWidth / Const.indicatorWidthDivision
    let position = progress * indicatorWidth
    rootView.indicatorView.frame.origin.x = position
    rootView.indicatorView.frame.size.width = indicatorWidth
    rootView.updateLabelBasedOnVisibleCell(viewModel: userProfileViewModel) 
  }
}
