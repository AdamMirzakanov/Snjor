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
  
  func collectionView(
    _ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    switch currentScopeIndex {
    case .discover:
      handleWillDisplay(for: indexPath, viewModel: photosViewModel)
    case .topicAndAlbums:
      handleWillDisplay(for: indexPath, viewModel: albumsViewModel)
    default:
      break
    }
  }
  
  private func handleWillDisplay(
    for indexPath: IndexPath,
    viewModel: any SearchViewModelProtocol
  ) {
    guard
      indexPath.item == viewModel.itemsCount - .thresholdValue,
      let currentSearchTerm = currentSearchTerm
    else {
      return
    }
    viewModel.search(with: currentSearchTerm)
  }
}
