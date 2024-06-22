//
//  + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

import UIKit

extension PhotoListCollectionViewController {
  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let itemIndex = indexPath.item
    let photo = viewModel.fetchPhoto(at: indexPath)
    delegate?.didSelect(photo: photo)
  }
}
