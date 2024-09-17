//
//  ThirdCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

class ThirdCell:
  UICollectionViewCell,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {
  
  let verticalCollectionViewC: UICollectionView
  
  override init(frame: CGRect) {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 5
    layout.minimumInteritemSpacing = 5
    verticalCollectionViewC = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    super.init(frame: frame)
    
    verticalCollectionViewC.delegate = self
    verticalCollectionViewC.dataSource = self
    verticalCollectionViewC.register(
      UICollectionViewCell.self,
      forCellWithReuseIdentifier: "verticalCellC"
    )
    contentView.addSubview(verticalCollectionViewC)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    verticalCollectionViewC.frame = contentView.bounds
  }
  
  func configure() {
    verticalCollectionViewC.reloadData()
  }
  
  // UICollectionViewDataSource
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 15
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "verticalCellC",
      for: indexPath
    )
    cell.backgroundColor = .systemBrown // Макет ячеек для типа C
    return cell
  }
  
  // UICollectionViewDelegateFlowLayout
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(
      width: collectionView.frame.width,
      height: 200
    )
  }
}

