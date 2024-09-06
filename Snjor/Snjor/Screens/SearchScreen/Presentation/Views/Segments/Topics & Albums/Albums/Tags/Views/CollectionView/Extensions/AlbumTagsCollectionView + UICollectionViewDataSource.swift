//
//  AlbumTagsCollectionView + UICollectionViewDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

extension AlbumTagsCollectionView: UICollectionViewDataSource {
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
      withReuseIdentifier: AlbumTagCell.reuseID,
      for: indexPath
    ) as? AlbumTagCell
    else {
      return UICollectionViewCell()
    }
    cell.configure(with: tags[indexPath.item])
    return cell
  }
}
