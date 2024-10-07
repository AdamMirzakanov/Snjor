//
//  FirstCell + UICollectionViewDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.09.2024.
//

import UIKit

extension FirstCell: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return likedPhotos.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: UserLikedPhotoCell.reuseID,
      for: indexPath
    ) as! UserLikedPhotoCell
    let photoViewModelItem = BaseViewModelItem(
      item: likedPhotos[indexPath.item]
    )
    print(likedPhotos[indexPath.item])
    cell.configure(viewModelItem: photoViewModelItem)
    return cell
  }
}
