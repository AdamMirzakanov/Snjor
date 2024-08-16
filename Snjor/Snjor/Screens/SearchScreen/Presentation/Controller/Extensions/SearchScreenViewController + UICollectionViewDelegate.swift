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
    case 0:
      let photo = photosViewModel.getPhoto(at: indexPath.item)
      delegate.photoCellDidSelect(photo)
    case 1:
      let topic = topicsViewModel.getTopic(at: indexPath.item)
      delegate.topicCellDidSelect(topic)
    default:
      print("Selected a different scope")
    }
  }
}
