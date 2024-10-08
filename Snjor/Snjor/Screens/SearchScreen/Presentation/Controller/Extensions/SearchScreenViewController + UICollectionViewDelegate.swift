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
    case .discover:
      handleDiscoverSelection(at: indexPath, delegate: delegate)
    case .topicAndAlbums:
      handleTopicAndAlbumsSelection(at: indexPath, delegate: delegate)
    default:
      break
    }
  }
  
  // MARK: - Private Methods
  private func handleDiscoverSelection(
    at indexPath: IndexPath,
    delegate: any SearchScreenViewControllerDelegate
  ) {
    let photo = photosViewModel.getItem(at: indexPath.item)
    delegate.photoCellDidSelect(photo)
  }
  
  private func handleTopicAndAlbumsSelection(
    at indexPath: IndexPath,
    delegate: any SearchScreenViewControllerDelegate
  ) {
    switch indexPath.section {
    case .zero:
      let topic = topicsViewModel.getItem(at: indexPath.item)
      delegate.topicCellDidSelect(topic)
    default:
      let album = albumsViewModel.getItem(at: indexPath.item)
      delegate.albumCellDidSelect(album)
    }
  }
}
