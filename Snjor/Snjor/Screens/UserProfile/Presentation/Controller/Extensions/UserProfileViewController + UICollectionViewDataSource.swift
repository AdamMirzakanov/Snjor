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
        withReuseIdentifier: "horizontalCellA",
        for: indexPath
      ) as! HorizontalCollectionViewCellA
      cell.configure()
      return cell
    case 1:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "horizontalCellB",
        for: indexPath
      ) as! HorizontalCollectionViewCellB
      cell.configure()
      return cell
    default:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "horizontalCellC",
        for: indexPath
      ) as! HorizontalCollectionViewCellC
      cell.configure()
      return cell
    }
  }
 
}
