//
//  SearchResultViewController + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

extension SearchResultViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let delegate = delegate else { return }
    switch currentScopeIndex {
    case .discover:
      let photo = photosViewModel.getItem(at: indexPath.item)
      delegate.searchPhotoCellDidSelect(photo)
    case .topicAndAlbums:
      let album = albumsViewModel.getItem(at: indexPath.item)
      delegate.searchAlbumcCellDidSelect(album)
    default:
      print(#function, Self.self)
    }
  }
}
