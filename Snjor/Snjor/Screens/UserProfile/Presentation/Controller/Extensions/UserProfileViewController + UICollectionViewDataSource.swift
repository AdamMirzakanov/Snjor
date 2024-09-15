//
//  UserProfileViewController + UICollectionViewDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

extension UserProfileViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 3 // Количество вкладок
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    switch indexPath.row {
    case 0:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: FirstCell.reuseID,
        for: indexPath
      ) as! FirstCell
      cell.configure(with: userLikedPhotosViewModel.items)
      return cell
    case 1:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "horizontalCellB",
        for: indexPath
      ) as! SecondCell
      cell.configure()
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
