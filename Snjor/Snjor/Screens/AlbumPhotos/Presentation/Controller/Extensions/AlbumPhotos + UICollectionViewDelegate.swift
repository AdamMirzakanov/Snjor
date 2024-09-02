//
//  AlbumPhotos + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

extension AlbumPhotosViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let delegate = delegate else { return }
    let photo = viewModel.getItem(at: indexPath.item)
    delegate.didSelect(photo)
  }
}
