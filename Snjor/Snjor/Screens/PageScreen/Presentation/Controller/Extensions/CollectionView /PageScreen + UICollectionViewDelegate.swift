//
//  PageScreen + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

extension PageScreenViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard
      let page = viewControllerForTopic(at: indexPath.item, delegate: coordinator),
      let cell = collectionView.cellForItem(at: indexPath)
    else {
      return
    }
    setPage(page: page)
    rootView.topicsCollectionView.updateIndicatorPosition(for: cell)
  }
  
  private func setPage(page: UIViewController) {
    rootView.pageViewController.setViewControllers(
      [page],
      direction: .forward,
      animated: true
    )
  }
}
