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
    let width = calculateItemWidth(for: itemIndex)
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
    return UIEdgeInsets(
      top: .zero,
      left: 10,
      bottom: .zero,
      right: 10
    )
  }
  
  // MARK: -  Private Methods
  private func calculateItemWidth(for index: Int) -> CGFloat {
    let topicsPageViewModelItem = viewModel.getTopicsPageViewModelItem(at: index)
    let width = topicsPageViewModelItem.topicTitle.size(
      withAttributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
      ]
    ).width + 11
    return width
  }
}
