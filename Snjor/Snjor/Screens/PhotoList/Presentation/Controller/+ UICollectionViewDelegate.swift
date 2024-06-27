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
    let id = viewModel.getPhotoID(at: indexPath)
    delegate?.didSelect(id: id)
  }
}
