//
//  SearchScreenViewController + UISearchBarDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

extension SearchScreenViewController: UISearchBarDelegate {
  func searchBar(
    _ searchBar: UISearchBar,
    selectedScopeButtonIndexDidChange selectedScope: Int
  ) {
    currentScopeIndex = selectedScope
    switch selectedScope {
    case .zero:
      rootView.albumsCollectionView.removeFromSuperview()
      rootView.addSubview(rootView.photosCollectionView)
      rootView.photosCollectionView.fillSuperView()
      navigationItem.title = "Photos"
    case 1:
      rootView.photosCollectionView.removeFromSuperview()
      rootView.addSubview(rootView.albumsCollectionView)
      rootView.albumsCollectionView.fillSuperView()
      navigationItem.title = "Collections"
    default:
      rootView.photosCollectionView.isHidden = true
      rootView.albumsCollectionView.isHidden = true
      navigationItem.title = "Users"
      print(#function)
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
      return
    }
    delegate?.searchButtonClicked(with: searchTerm)
  }
}
