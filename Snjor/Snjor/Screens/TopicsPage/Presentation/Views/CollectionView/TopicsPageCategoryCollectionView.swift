//
//  TopicsPageCategoryCollectionView.swift
//  Snjor
//
//  Created by Adam on 27.07.2024.
//

import UIKit

final class TopicsPageCategoryCollectionView: UICollectionView {
  
  // MARK: - Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: - Views
  private let lineView: UIView = {
    $0.backgroundColor = .white
    $0.alpha = 0.7
    return $0
  }(UIView())
  
  private let indicatorView: UIView = {
    $0.backgroundColor = .white
    return $0
  }(UIView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    configureLayout()
    addSubviews()
    cellRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Override Methods
  override func layoutSubviews() {
    super.layoutSubviews()
    updateLineViewAndIndicatorPosition()
  }

  // MARK: - Internal Methods
  func updateIndicatorPosition(for cell: UICollectionViewCell) {
    let cellFrame = cell.frame
    let indicatorHeight: CGFloat = traitCollection.displayScale * 0.7
    let xPosition = cellFrame.origin.x
    let yPosition = cellFrame.maxY - indicatorHeight
    let newFrame = CGRect(
      x: xPosition,
      y: yPosition,
      width: cellFrame.width,
      height: indicatorHeight
    )
    guard indicatorView.frame != newFrame else { return }
    animateCellIndicator(indicatorView: indicatorView, newFrame: newFrame)
  }
  
  // MARK: - Private Methods
  private func addSubviews() {
    addSubview(lineView)
    addSubview(indicatorView)
  }
  
  private func configureLayout() {
    flowlayout.scrollDirection = .horizontal
    backgroundColor = .clear
    bounces = false
    showsHorizontalScrollIndicator = false
  }
  
  private func cellRegister() {
    register(
      TopicsPageCategoryCell.self,
      forCellWithReuseIdentifier: TopicsPageCategoryCell.reuseID
    )
  }
  
  private func animateCellIndicator(indicatorView: UIView, newFrame: CGRect) {
    UIView.animate(withDuration: 0.15) {
      self.indicatorView.frame = newFrame
    }
  }
  
  private func updateLineViewAndIndicatorPosition() {
    let indicatorHeight: CGFloat = 1 / traitCollection.displayScale
    lineView.frame = CGRect(
      x: .zero,
      y: bounds.height - indicatorHeight,
      width: contentSize.width,
      height: indicatorHeight
    )
    guard
      let selectedIndexPath = indexPathsForSelectedItems?.first,
      let cell = cellForItem(at: selectedIndexPath)
    else {
      return
    }
    updateIndicatorPosition(for: cell)
  }
}
