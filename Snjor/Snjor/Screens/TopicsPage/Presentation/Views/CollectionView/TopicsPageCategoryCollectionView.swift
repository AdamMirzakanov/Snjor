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
  private let indicatorView = UIView()
  
  var lineView: UIView = {
    $0.backgroundColor = .white
    $0.alpha = 0.7
    return $0
  }(UIView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    configure()
    indicatorView.backgroundColor = .white
    addSubview(lineView)
    addSubview(indicatorView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateIndicatorPosition(for cell: UICollectionViewCell) {
    let cellFrame = cell.frame
    let indicatorHeight: CGFloat = 2.0
    let newFrame = CGRect(
      x: cellFrame.origin.x,
      y: cellFrame.maxY - indicatorHeight,
      width: cellFrame.width,
      height: indicatorHeight
    )
    
    guard indicatorView.frame != newFrame else { return }
    
    UIView.animate(withDuration: 0.25) {
      self.indicatorView.frame = newFrame
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let indicatorHeight: CGFloat = 0.3
    lineView.frame = CGRect(x: 0, y: bounds.height - indicatorHeight, width: contentSize.width, height: indicatorHeight)
    if let selectedIndexPath = indexPathsForSelectedItems?.first,
       let cell = cellForItem(at: selectedIndexPath) {
      updateIndicatorPosition(for: cell)
    }
  }
  
  
  // MARK: - Private Methods
  private func configure() {
    register()
    flowlayout.scrollDirection = .horizontal
    backgroundColor = .clear
    bounces = false
    showsHorizontalScrollIndicator = false
  }
  
  private func register() {
    register(
      TopicsPageCategoryCell.self,
      forCellWithReuseIdentifier: TopicsPageCategoryCell.reuseID
    )
  }
}


