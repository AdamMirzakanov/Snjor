//
//  SearchResultScreenViewController + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

extension SearchResultScreenViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let delegate = delegate else { return }
    switch currentScopeIndex {
    case .zero:
      let photo = photosViewModel.getPhoto(at: indexPath.item)
      delegate.searchPhotoCellDidSelect(photo)
    default:
      switch indexPath.section {
      case .zero:
        print(#function, currentScopeIndex)
      default:
        print(#function, currentScopeIndex)
      }
    }
  }
}
