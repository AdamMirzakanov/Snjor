//
//  AlbumPhotosCascadeLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 26.07.2024.
//

import UIKit

fileprivate typealias Const = CascadeLayoutConst

final class AlbumPhotosCascadeLayout: CascadeLayout {
  
  private var headerAttributes: [UICollectionViewLayoutAttributes] = []
  
  override var topInset: CGFloat {
    return .zero // Const.topInset
  }
  
  // MARK: Override Methods
  ///
  override func layoutAttributesForElements(
    in rect: CGRect
  ) -> [UICollectionViewLayoutAttributes]? {
    for attr in headerAttributes where rect.intersects(attr.frame) {
      attributes.append(attr)
    }
    return super.layoutAttributesForElements(in: rect)
  }
  
  ///
  override func layoutAttributesForSupplementaryView(
    ofKind elementKind: String,
    at indexPath: IndexPath
  ) -> UICollectionViewLayoutAttributes? {
    guard elementKind == UICollectionView.elementKindSectionHeader else {
      return nil
    }
    let attributes = UICollectionViewLayoutAttributes(
      forSupplementaryViewOfKind: elementKind,
      with: indexPath
    )
    attributes.frame = CGRect(
      x: .zero,
      y: .zero,
      width: collectionView?.frame.width ?? .zero,
      height: .zero // CascadeLayoutConst.headerHeight
    )
    return attributes
  }
  
  ///
  override func prepare() {
    super.prepare()
    guard let collectionView = collectionView else { return }
    for section in .zero ..< collectionView.numberOfSections {
      let headerIndexPath = IndexPath(item: .zero, section: section)
      let headerAttr = layoutAttributesForSupplementaryView(
        ofKind: UICollectionView.elementKindSectionHeader,
        at: headerIndexPath
      )
      if let headerAttr = headerAttr {
        headerAttributes.append(headerAttr)
      }
    }
  }
  
  override func reset() {
    super.reset()
    headerAttributes.removeAll()
  }
}
