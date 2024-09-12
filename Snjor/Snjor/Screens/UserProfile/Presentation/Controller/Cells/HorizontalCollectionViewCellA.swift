//
//  HorizontalCollectionViewCellA.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

final class HorizontalCollectionViewCellA:
  UICollectionViewCell,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {
  
  let verticalCollectionViewA: UICollectionView
  
  override init(frame: CGRect) {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    verticalCollectionViewA = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    super.init(frame: frame)
    
    verticalCollectionViewA.delegate = self
    verticalCollectionViewA.dataSource = self
    verticalCollectionViewA.register(
      UICollectionViewCell.self,
      forCellWithReuseIdentifier: "verticalCellA"
    )
    contentView.addSubview(verticalCollectionViewA)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    verticalCollectionViewA.frame = contentView.bounds
  }
  
  func configure() {
    verticalCollectionViewA.reloadData()
  }
  
  // UICollectionViewDataSource
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 10
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "verticalCellA",
      for: indexPath
    )
    cell.backgroundColor = .systemBrown // Макет ячеек для типа A
    return cell
  }
  
  // UICollectionViewDelegateFlowLayout
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: collectionView.frame.width - 20, height: 100)
  }
}

