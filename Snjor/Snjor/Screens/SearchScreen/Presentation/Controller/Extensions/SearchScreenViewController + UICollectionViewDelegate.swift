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
      let photo = photosViewModel.getItem(at: indexPath.item)
      delegate.photoCellDidSelect(photo)
    case .topicAndAlbums:
      switch indexPath.section {
      case .zero:
        let topic = topicsViewModel.getItem(at: indexPath.item)
        delegate.topicCellDidSelect(topic)
      default:
        let album = albumsViewModel.getItem(at: indexPath.item)
        delegate.albumcCellDidSelect(album)
      }
    default :
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
  
  private func handleWillDisplay(
    for indexPath: IndexPath,
    viewModel: any SearchViewModelProtocol
  ) {
    guard indexPath.item == viewModel.itemsCount - .thresholdValue else {
      return
    }
    viewModel.viewDidLoad()
  }
}
