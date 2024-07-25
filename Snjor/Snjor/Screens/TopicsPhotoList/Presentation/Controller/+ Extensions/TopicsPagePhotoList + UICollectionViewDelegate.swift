//
//  TopicsPagePhotoList + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit

extension TopicsPagePhotoListViewController {
  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let delegate = delegate else { return }
    let photo = viewModel.getPhoto(at: indexPath.item)
    delegate.didSelect(photo)
  }
}
