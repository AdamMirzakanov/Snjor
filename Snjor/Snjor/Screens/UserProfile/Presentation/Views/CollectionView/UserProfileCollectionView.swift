//
//  UserProfileCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

final class UserProfileCollectionView: MainCollectionView {
  
  override func cellRegister() {
    register(
      FirstCell.self,
      forCellWithReuseIdentifier: FirstCell.reuseID
    )
    register(
      SecondCell.self,
      forCellWithReuseIdentifier: SecondCell.reuseID
    )
    register(
      ThirdCell.self,
      forCellWithReuseIdentifier: "horizontalCellC"
    )
  }
  
  override func configureLayout() {
    flowlayout.scrollDirection = .horizontal
    isPagingEnabled = true
    showsHorizontalScrollIndicator = false
  }
}
