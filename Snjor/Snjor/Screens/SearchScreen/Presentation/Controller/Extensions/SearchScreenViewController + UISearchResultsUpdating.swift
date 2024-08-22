//
//  SearchScreenViewController + UISearchResultsUpdating.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

import UIKit

extension SearchScreenViewController: UISearchResultsUpdating {
  
  @objc private func fetchMatchingItems(query: String) {
    guard 
      let searchResultsController = searchController.searchResultsController as? SearchResultScreenViewController
    else {
      return
    }
    searchResultsController.fetchMatchingItems(with: query)
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let query = searchController.searchBar.text, !query.isEmpty else { return }
    NSObject.cancelPreviousPerformRequests(
      withTarget: self,
      selector: #selector(fetchMatchingItems),
      object: nil
    )
    perform(#selector(fetchMatchingItems), with: query, afterDelay: 0.6)
  }
}


extension SearchScreenViewController {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = .empty
    searchController.isActive = false
    if let searchResultsController = searchController.searchResultsController as? SearchResultScreenViewController {
      searchResultsController.photosViewModel.photos.removeAll()
      searchResultsController.applyPhotosSnapshot()
    }
  }
}
