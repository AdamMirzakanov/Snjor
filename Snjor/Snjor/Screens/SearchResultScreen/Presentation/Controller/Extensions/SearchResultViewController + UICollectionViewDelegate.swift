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
      handlePhotoSelection(at: indexPath, delegate: delegate)
    case .topicAndAlbums:
      handleAlbumSelection(at: indexPath, delegate: delegate)
    default:
      break
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
  
  // MARK: - Private Methods
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
    viewModel.executeSearch(with: currentSearchTerm)
  }
  
  private func handlePhotoSelection(
    at indexPath: IndexPath,
    delegate: any SearchResultViewControllerDelegate
  ) {
    let photo = photosViewModel.getItem(at: indexPath.item)
    delegate.searchPhotoCellDidSelect(photo)
  }
  
  private func handleAlbumSelection(
    at indexPath: IndexPath,
    delegate: any SearchResultViewControllerDelegate
  ) {
    let album = albumsViewModel.getItem(at: indexPath.item)
    delegate.searchAlbumcCellDidSelect(album)
  }
}
