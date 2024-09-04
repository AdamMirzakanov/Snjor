//
//  CascadeLayout.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

class CascadeLayout: UICollectionViewLayout {
  
  // MARK: Internal Properties
  var contentHeight: CGFloat = .zero
  var numberOfColumns: Int = .zero
  var isSingleColumn: Bool { numberOfColumns == .zero }
  var topInset: CGFloat = CascadeLayoutConst.topInset
  var headerHeight: CGFloat = CascadeLayoutConst.headerHeight
  var columnSpacing = CascadeLayoutConst.columnSpacing
  
  var itemSpacing: CGFloat {
    let zero = CGFloat.zero
    return isSingleColumn ? zero : columnSpacing
  }
  
  var columnWidth: CGFloat {
    let contentWidth = collectionViewContentSize.width
    let numberOfColumns = CGFloat(numberOfColumns)
    if isSingleColumn == true {
      return collectionViewContentSize.width
    }
    let columnWidth = (contentWidth - (numberOfColumns - 1) * itemSpacing) / numberOfColumns
    return columnWidth
  }
  
  // MARK: Private Properties
  private weak var delegate: (any CascadeLayoutDelegate)?
  private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
  private var frames: [CGRect] = []
  private var pagingViewAttributes: UICollectionViewLayoutAttributes?
  
  // MARK: Override Properties
  override var collectionViewContentSize: CGSize {
    guard let collectionView = collectionView else {
      return CGSize.zero
    }
    let width = collectionView.frame.width
    return CGSize(
      width: width,
      height: contentHeight
    )
  }
  
  // MARK: Initializers
  init(with delegate: CascadeLayoutDelegate?) {
    self.delegate = delegate
    super.init()
    setUpDefaultOfColumns()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: Override Methods
  override func layoutAttributesForElements(
    in rect: CGRect
  ) -> [UICollectionViewLayoutAttributes]? {
    var attributes: [UICollectionViewLayoutAttributes] = []
    var firstFrameIndex: Int = .zero
    var framesCount: Int = frames.count
    
    for index in .zero ..< framesCount where rect.intersects(frames[index]) {
      firstFrameIndex = index
      break
    }
    
    for index in (
      .zero ..< frames.count
    ).reversed() where rect.intersects(frames[index]) {
      framesCount = min((index + 1), layoutAttributes.count)
      break
    }
    
    for index in firstFrameIndex ..< framesCount {
      let attr = layoutAttributes[index]
      attributes.append(attr)
    }
    
    if let pagingViewAttributes = pagingViewAttributes,
       pagingViewAttributes.frame.intersects(rect) {
      attributes.append(pagingViewAttributes)
    }
    return attributes
  }
  
  override func layoutAttributesForItem(
    at indexPath: IndexPath
  ) -> UICollectionViewLayoutAttributes? {
    return layoutAttributes[indexPath.item]
  }
  
  func originForColumn(
    _ columnIndex: Int,
    collectionView: UICollectionView?,
    columnHeights: [CGFloat]
  ) -> CGPoint {
    let pointX = isSingleColumn ? .zero : CGFloat(columnIndex) * (columnWidth + itemSpacing)
    let pointY = columnHeights[columnIndex]
    return CGPoint(x: pointX, y: pointY)
  }
  
  override func shouldInvalidateLayout(
    forBoundsChange newBounds: CGRect
  ) -> Bool {
    guard let bounds = collectionView?.bounds else { return false }
    return bounds.width != newBounds.width
  }
  
  override func prepare() {
    super.prepare()
    reset()
    
    guard
      let collectionView = collectionView,
      let delegate = delegate,
      self.numberOfColumns > .zero
    else {
      return
    }
    
    let itemSpacing = self.itemSpacing
    let numberOfColumns = self.numberOfColumns
    let columnWidth = self.columnWidth
    
    // начало коллекции
    var columnHeights = [CGFloat](
      repeating: topInset,
      count: numberOfColumns
    )
    var numberOfItems: Int = .zero
    
    func indexOfNextColumn() -> Int {
      guard let minHeight = columnHeights.min() else {
        let zeroColumnHeight: Int = .zero
        return zeroColumnHeight
      }
      return columnHeights.firstIndex { $0 == minHeight } ?? .zero
    }
    
    (.zero ..< collectionView.numberOfSections).forEach {
      numberOfItems += collectionView.numberOfItems(inSection: $0)
    }
    
    for index in .zero ..< numberOfItems {
      let indexPath = IndexPath(item: index, section: .zero)
      let photoSize = delegate.cascadeLayout(self, sizeForItemAt: indexPath)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      let columnIndex = indexOfNextColumn()
      let origin = originForColumn(
        columnIndex,
        collectionView: collectionView,
        columnHeights: columnHeights
      )
      let newSize = self.scaledSizeForColumnWidth(from: photoSize, with: columnWidth)
      columnHeights[columnIndex] = origin.y + newSize.height + itemSpacing
      attributes.frame = CGRect(origin: origin, size: newSize)
      layoutAttributes.append(attributes)
      frames.append(attributes.frame)
    }
    contentHeight = columnHeights.max() ?? .zero
    contentHeight += itemSpacing
  }
  
  // MARK: SupplementaryView
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
    return attributes
  }
  
  // MARK: Private Methods
  func setUpDefaultOfColumns() {
    let iPad = CascadeLayoutConst.iPadColumns
    let iPhone = CascadeLayoutConst.iPhoneColumns
    let userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
    let device = userInterfaceIdiom == .pad ? iPad : iPhone
    numberOfColumns = device
  }
  
  private func reset() {
    pagingViewAttributes = nil
    layoutAttributes.removeAll()
    frames.removeAll()
    contentHeight = .zero
  }
  
  // MARK: Utilities
  private func scaledSizeForColumnWidth(
    from originalSize: CGSize,
    with columnWidth: CGFloat
  ) -> CGSize {
    let height = originalSize.height * columnWidth / originalSize.width
    return CGSize(width: floor(columnWidth), height: floor(height))
  }
}
