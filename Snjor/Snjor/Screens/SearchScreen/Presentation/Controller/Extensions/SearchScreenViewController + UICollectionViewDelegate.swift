//
//  SearchScreenViewController + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.08.2024.
//

import UIKit

extension SearchScreenViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let delegate = delegate else { return }
    switch currentScopeIndex {
    case .zero:
      let photo = photosViewModel.getItem(at: indexPath.item)
      delegate.photoCellDidSelect(photo)
    default:
      switch indexPath.section {
      case .zero:
        let topic = topicsViewModel.getTopic(at: indexPath.item)
        delegate.topicCellDidSelect(topic)
      default:
        let album = albumsViewModel.getItem(at: indexPath.item)
        delegate.albumcCellDidSelect(album)
      }
    }
  }
}
