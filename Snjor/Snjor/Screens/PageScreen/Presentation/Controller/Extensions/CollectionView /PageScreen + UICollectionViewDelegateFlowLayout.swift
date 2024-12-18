//
//  PageScreen + UICollectionViewDelegateFlowLayout.swift
//  Snjor
//
//  Created by Adam on 26.07.2024.
//

import UIKit

fileprivate typealias Const = PageScreenViewControllerConst

extension PageScreenViewController: UICollectionViewDelegateFlowLayout {
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
      left: Const.middleValue,
      bottom: .zero,
      right: Const.middleValue
    )
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return Const.middleValue
  }
  
  // MARK: Private Methods
  private func calculateItemWidth(for index: Int) -> CGFloat {
    let topicsPageViewModelItem = viewModel.getViewModelItem(at: index)
    let width = topicsPageViewModelItem.itemTitle.size(
      withAttributes: [
        NSAttributedString.Key.font: UIFont.systemFont(
          ofSize: Const.middleValue
        )
      ]
    ).width + Const.middleValue
    return width
  }
}
