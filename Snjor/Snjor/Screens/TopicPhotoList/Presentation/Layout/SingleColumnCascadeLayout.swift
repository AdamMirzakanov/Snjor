//
//  SingleColumnCascadeLayout.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 26.07.2024.
//

import UIKit

final class SingleColumnCascadeLayout: CascadeLayout {
//  override var collectionViewContentSize: CGSize {
//    
//    guard let collectionView = collectionView else {
//      return CGSize.zero
//    }
//    var width = collectionView
//      .frame
//      .width
//    
//    let leading =  collectionView
//      .directionalLayoutMargins
//      .leading
//    
//    let trailing = collectionView
//      .directionalLayoutMargins
//      .trailing
//    
//    if isSingleColumn == false {
//      width -= (leading + trailing)
//    }
//    
//    return CGSize(
//      width: width,
//      height: contentHeight
//    )
//  }
  
//  override func originForColumn(
//    _ columnIndex: Int,
//    collectionView: UICollectionView?,
//    columnHeights: [CGFloat]
//  ) -> CGPoint {
//    guard let collectionView = collectionView else { return .zero }
//    let pointX = isSingleColumn ? 0 : collectionView.directionalLayoutMargins.leading + CGFloat(columnIndex) * (columnWidth + itemSpacing)
//    
//    let pointY = columnHeights[columnIndex]
//    return CGPoint(x: pointX, y: pointY)
//  }
  
  override func setUpDefaultOfColumns() {
    numberOfColumns = CascadeLayoutConst.singleColumns
    columnSpacing = CascadeLayoutConst.columnSpacing
  }
}
