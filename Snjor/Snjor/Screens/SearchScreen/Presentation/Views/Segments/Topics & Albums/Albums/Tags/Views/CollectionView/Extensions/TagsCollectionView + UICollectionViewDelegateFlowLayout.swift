//
//  TagsCollectionView + UICollectionViewDelegateFlowLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

extension TagsCollectionView: UICollectionViewDelegateFlowLayout {
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
      left: TagsCollectionViewConst.tagsInsets,
      bottom: .zero,
      right: TagsCollectionViewConst.tagsInsets
    )
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return TagsCollectionViewConst.tagsInsets
  }
  
  // MARK: Private Methods
  private func calculateItemWidth(for index: Int) -> CGFloat {
    let tag = tags[index]
    let width = tag.title.size(
      withAttributes: [
        NSAttributedString
          .Key
          .font: UIFont.systemFont(ofSize: TagsCollectionViewConst.attributedStringFontSize)
      ]
    ).width + TagsCollectionViewConst.tagsWidthPadding
    return width
  }
}
