//
//  PhotoDetailTagsCollectionView + UICollectionViewDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

import UIKit

extension PhotoDetailTagsCollectionView: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return tags.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: PhotoDetailTagCell.reuseID,
      for: indexPath
    ) as? PhotoDetailTagCell
    else {
      return UICollectionViewCell()
    }
    cell.configure(with: tags[indexPath.item])
    return cell
  }
}
