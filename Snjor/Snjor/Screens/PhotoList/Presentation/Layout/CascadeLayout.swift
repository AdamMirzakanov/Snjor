//
//  CascadeLayout.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol CascadeLayoutDelegate: AnyObject {
  func cascadeLayout(
    _ layout: CascadeLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize
}

final class CascadeLayout: UICollectionViewLayout {
  // MARK: - Private Properties
  private weak var delegate: CascadeLayoutDelegate?
  private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
  private var frames: [CGRect] = []
  private var pagingViewAttributes: UICollectionViewLayoutAttributes?
  private var contentHeight: CGFloat = .zero
  private var numberOfColumns: Int = .zero
  private var isSingleColumn: Bool { numberOfColumns == .zero }

  private var itemSpacing: CGFloat {
    let zero = CGFloat.zero
    let columnSpacing = CascadeLayoutConst.columnSpacing
    return isSingleColumn ? zero : columnSpacing
  }

  private var columnWidth: CGFloat {
    let contentWidth = collectionViewContentSize.width
    let numberOfColumns = CGFloat(numberOfColumns)
    if isSingleColumn == true {
      return collectionViewContentSize.width
    }
    let columnWidth = (contentWidth - (numberOfColumns - 1) * itemSpacing) / numberOfColumns
    return columnWidth
  }

  // MARK: - Override Properties
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

  // MARK: - Initializers
  init(with delegate: CascadeLayoutDelegate?) {
    self.delegate = delegate
    super.init()
    setUpDefaultOfColumns()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - Override Methods
  override func layoutAttributesForElements(
    in rect: CGRect
  ) -> [UICollectionViewLayoutAttributes]? {
    var attributes: [UICollectionViewLayoutAttributes] = []
    var firstFrameIndex: Int = 0
    var framesCount: Int = frames.count

    for index in 0 ..< framesCount where rect.intersects(frames[index]) {
      firstFrameIndex = index
      break
    }

    for index in (0 ..< frames.count).reversed() where rect.intersects(frames[index]) {
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
      self.numberOfColumns > 0
    else {
      return
    }

    let itemSpacing = self.itemSpacing
    let numberOfColumns = self.numberOfColumns
    let isSingleColumn = self.isSingleColumn
    let columnWidth = self.columnWidth
    let topInset: CGFloat = .zero
    var columnHeights = [CGFloat](repeating: topInset, count: numberOfColumns)
    var numberOfItems: Int = .zero

    func originForColumn(_ columnIndex: Int) -> CGPoint {
      let pointX = isSingleColumn ? .zero : CGFloat(columnIndex) * (columnWidth + itemSpacing)
      let pointY = columnHeights[columnIndex]
      return CGPoint(x: pointX, y: pointY)
    }

    func indexOfNextColumn() -> Int {
      guard let minHeight = columnHeights.min() else {
        let zeroColumnHeight: Int = .zero
        return zeroColumnHeight
      }
      return columnHeights.firstIndex { $0 == minHeight } ?? .zero
    }

    (0 ..< collectionView.numberOfSections).forEach {
      numberOfItems += collectionView.numberOfItems(inSection: $0)
    }

    for index in 0 ..< numberOfItems {
      let indexPath = IndexPath(item: index, section: 0)
      let photoSize = delegate.cascadeLayout(self, sizeForItemAt: indexPath)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      let columnIndex = indexOfNextColumn()
      let origin = originForColumn(columnIndex)
      let newSize = self.scaledSizeForColumnWidth(from: photoSize, with: columnWidth)
      columnHeights[columnIndex] = origin.y + newSize.height + itemSpacing
      attributes.frame = CGRect(origin: origin, size: newSize)
      layoutAttributes.append(attributes)
      frames.append(attributes.frame)
    }
    contentHeight = columnHeights.max() ?? .zero
    contentHeight += itemSpacing
  }

  // MARK: - Private Methods
  private func setUpDefaultOfColumns() {
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

  // MARK: - Utilities
  private func scaledSizeForColumnWidth(
    from originalSize: CGSize,
    with columnWidth: CGFloat
  ) -> CGSize {
    let height = originalSize.height * columnWidth / originalSize.width
    return CGSize(width: floor(columnWidth), height: floor(height))
  }
}
