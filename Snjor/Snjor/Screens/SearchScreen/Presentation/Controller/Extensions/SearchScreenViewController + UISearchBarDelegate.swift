//
//  SearchScreenViewController + UISearchBarDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

extension SearchScreenViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
      return
    }
    delegate?.searchButtonClicked(with: searchTerm, currentScopeIndex: currentScopeIndex)
  }
  
  func searchBar(
    _ searchBar: UISearchBar,
    selectedScopeButtonIndexDidChange selectedScope: Int
  ) {
    currentScopeIndex = selectedScope

    switch selectedScope {
    case .discover:
      configureForDiscoverMode(searchBar)
    case .topicAndAlbums:
      configureForTopicAndAlbumsMode(searchBar)
    default:
      configureForUsersMode(searchBar)
    }
  }
  
  // MARK: Private Methods
  private func configureForDiscoverMode(_ searchBar: UISearchBar) {
    rootView.albumsCollectionView.removeFromSuperview()
    rootView.usersTableViewView.removeFromSuperview()
    rootView.addSubview(rootView.photosCollectionView)
    rootView.photosCollectionView.fillSuperView()
    searchBar.placeholder = .searchPhotos
    navigationItem.title = .discoverTitle
  }
  
  private func configureForTopicAndAlbumsMode(_ searchBar: UISearchBar) {
    rootView.photosCollectionView.removeFromSuperview()
    rootView.usersTableViewView.removeFromSuperview()
    rootView.addSubview(rootView.albumsCollectionView)
    rootView.albumsCollectionView.fillSuperView()
    searchBar.placeholder = .searchAlbums
    navigationItem.title = .topicsAndAlbumsTitle
  }
  
  private func configureForUsersMode(_ searchBar: UISearchBar) {
    rootView.photosCollectionView.removeFromSuperview()
    rootView.albumsCollectionView.removeFromSuperview()
    rootView.addSubview(rootView.usersTableViewView)
    rootView.usersTableViewView.fillSuperView()
    searchBar.placeholder = .searchUsers
    navigationItem.title = .usersTitle
  }
}
