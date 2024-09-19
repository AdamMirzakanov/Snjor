//
//  UserProfileCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

final class UserProfileCollectionView: MainCollectionView {
  private let layoutFactory = UserProfileLayoutFactory()
  
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
      forCellWithReuseIdentifier: ThirdCell.reuseID
    )
  }
  
  override func configureLayout() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let screenWidth = UIScreen.main.bounds.width
    layout.itemSize = CGSize(
      width: screenWidth,
      height: UserProfileViewControllerRootViewConst.heightUserProfileCollectionView
    )
    layout.sectionInset = .zero
    layout.minimumLineSpacing = .zero
    layout.minimumInteritemSpacing = .zero
    decelerationRate = .fast
    isPagingEnabled = true
    collectionViewLayout = layout
  }
}
