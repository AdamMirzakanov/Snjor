//
//  SearchScreenViewController + UISearchResultsUpdating.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

import UIKit

extension SearchScreenViewController {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let query = searchBar.text, !query.isEmpty else {
      return
    }
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
    delegate?.searchButtonClicked(with: query)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    if let searchResultsController = searchController.searchResultsController as? SearchResultScreenViewController {
      searchResultsController.photosViewModel.photos.removeAll()
      if let tabBar = tabBarController as? MainTabBarController {
        tabBar.showCustomTabBar()
      }
    }
  }
}
