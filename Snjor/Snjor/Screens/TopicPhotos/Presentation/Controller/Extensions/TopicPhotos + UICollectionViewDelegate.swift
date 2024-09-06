//
//  TopicPhotos + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

extension TopicPhotosViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let delegate = delegate else { return }
    let photo = viewModel.getItem(at: indexPath.item)
    delegate.didSelect(photo)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    handleWillDisplay(for: indexPath, viewModel: viewModel)
  }
  
  private func handleWillDisplay(
    for indexPath: IndexPath,
    viewModel: any ContentManagingProtocol
  ) {
    guard
      indexPath.item == viewModel.itemsCount - .thresholdValue
    else {
      return
    }
    viewModel.viewDidLoad()
  }
}
