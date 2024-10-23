//
//  UserProfileCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class UserProfileCollectionView: MainCollectionView {
  private let layoutFactory = UserProfileCollectionViewLayoutFactory()
  
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
    flowlayout.scrollDirection = .horizontal
    let screenWidth = UIScreen.main.bounds.width
    flowlayout.itemSize = CGSize(
      width: screenWidth,
      height: Const.heightUserProfileCollectionView
    )
    flowlayout.minimumLineSpacing = .zero
    flowlayout.minimumInteritemSpacing = .zero
    isPagingEnabled = true
    collectionViewLayout = flowlayout
  }
}
