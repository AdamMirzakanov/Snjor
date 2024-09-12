//
//  HorizontalCollectionViewCellB.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

class HorizontalCollectionViewCellB:
  UICollectionViewCell,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {
  
  let verticalCollectionViewB: UICollectionView
  
  override init(frame: CGRect) {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 15
    layout.minimumInteritemSpacing = 15
    verticalCollectionViewB = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    super.init(frame: frame)
    
    verticalCollectionViewB.delegate = self
    verticalCollectionViewB.dataSource = self
    verticalCollectionViewB.register(
      UICollectionViewCell.self,
      forCellWithReuseIdentifier: "verticalCellB"
    )
    contentView.addSubview(verticalCollectionViewB)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    verticalCollectionViewB.frame = contentView.bounds
  }
  
  func configure() {
    verticalCollectionViewB.reloadData()
  }
  
  // UICollectionViewDataSource
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 7
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "verticalCellB",
      for: indexPath
    )
    cell.backgroundColor = .systemBrown // Макет ячеек для типа B
    return cell
  }
  
  // UICollectionViewDelegateFlowLayout
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(
      width: collectionView.frame.width - 30,
      height: 150
    )
  }
}

