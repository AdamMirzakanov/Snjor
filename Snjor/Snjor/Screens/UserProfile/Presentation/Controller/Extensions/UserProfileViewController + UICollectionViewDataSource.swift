//
//  UserProfileViewController + UICollectionViewDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerConst

extension UserProfileViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return Const.itemsCount
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    switch indexPath.item {
    case Const.firstCell:
      guard
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: FirstCell.reuseID,
          for: indexPath
        ) as? FirstCell
      else {
        return UICollectionViewCell()
      }
      cell.configure(with: userLikedPhotosViewModel)
      return cell
    case Const.secondCell:
      guard
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: SecondCell.reuseID,
          for: indexPath
        ) as? SecondCell
      else {
        return UICollectionViewCell()
      }
      cell.configure(with: userPhotosViewModel)
      return cell
    default:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "horizontalCellC",
        for: indexPath
      ) as! ThirdCell
      cell.configure()
      return cell
    }
  }
}
