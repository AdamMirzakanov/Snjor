//
//  PageScreenTopicPhotos + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit

extension PageScreenPhotosViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let delegate = delegate else { return }
    let photo = viewModel.getItem(at: indexPath.item)
    delegate.didSelect(photo)
  }
}
