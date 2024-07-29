//
//  TopicsPage + UICollectionViewDelegateFlowLayout.swift
//  Snjor
//
//  Created by Adam on 26.07.2024.
//

import UIKit

extension TopicsPageViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let itemIndex = indexPath.item
    let topicsPageViewModelItem = viewModel.getTopicsPageViewModelItem(at: itemIndex)
    let width = topicsPageViewModelItem.topicTitle.size(
      withAttributes:
        [
          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
        ]
    ).width + 11
    return CGSize(
      width: width,
      height: collectionView.bounds.height
    )
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
  }
}
