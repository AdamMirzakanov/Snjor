//
//  TagsCollectionView + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

extension TagsCollectionView: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TagCell.reuseID,
      for: indexPath
    ) as? TagCell
    else {
      return UICollectionViewCell()
    }
    cell.configure(with: tags[indexPath.item])
    return cell
  }
}
