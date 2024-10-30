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
    delegate.didSelectCell(photo)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    handleWillDisplay(for: indexPath, viewModel: viewModel)
  }
  
  // MARK: Private Methods
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
