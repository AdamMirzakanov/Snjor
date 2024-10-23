//
//  AlbumTagsCollectionView + UICollectionViewDelegateFlowLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

import UIKit

fileprivate typealias Const = TagsCollectionViewConst

extension AlbumTagsCollectionView: UICollectionViewDelegateFlowLayout {
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
      left: Const.tagsInsets,
      bottom: .zero,
      right: Const.tagsInsets
    )
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return Const.tagsInsets
  }
  
  // MARK: Private Methods
  private func calculateItemWidth(for index: Int) -> CGFloat {
    let tag = tags[index]
    let width = tag.title.size(
      withAttributes: [
        NSAttributedString
          .Key
          .font: UIFont.systemFont(
            ofSize: Const.attributedStringFontSize
          )
      ]
    ).width + Const.tagsWidthPadding
    return width
  }
}
