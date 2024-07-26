//
//  TopicsPage + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

extension TopicsPageViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard
      let viewController = viewControllerForTopic(at: indexPath.item)
    else {
      return
    }
    rootView.pageViewController.setViewControllers(
      [viewController],
      direction: .forward,
      animated: true,
      completion: nil
    )
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let topic = viewModel.topics[indexPath.item]
    let width = topic.title.size(
      withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]).width + 20
    return CGSize(width: width, height: collectionView.bounds.height)
  }
}
