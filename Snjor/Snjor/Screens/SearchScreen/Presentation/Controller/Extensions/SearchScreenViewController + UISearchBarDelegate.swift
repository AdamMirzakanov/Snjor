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
    case .discover:
      rootView.albumsCollectionView.removeFromSuperview()
      rootView.addSubview(rootView.photosCollectionView)
      rootView.photosCollectionView.fillSuperView()
      searchBar.placeholder = .searchPhotos
      navigationItem.title = .discoverTitle
    case .topicAndAlbums:
      rootView.photosCollectionView.removeFromSuperview()
      rootView.addSubview(rootView.albumsCollectionView)
      rootView.albumsCollectionView.fillSuperView()
      searchBar.placeholder = .searchAlbums
      navigationItem.title = .topicsAndAlbumsTitle
    default:
      rootView.photosCollectionView.isHidden = true
      rootView.albumsCollectionView.isHidden = true
      searchBar.placeholder = .searchUsers
      navigationItem.title = .usersTitle
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
      return
    }
    delegate?.searchButtonClicked(with: searchTerm, currentScopeIndex: currentScopeIndex)
  }
}
