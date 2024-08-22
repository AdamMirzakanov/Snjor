//
//  SearchScreenViewController + UISearchResultsUpdating.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

import UIKit

extension SearchScreenViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
    guard let query = searchController.searchBar.text, !query.isEmpty else { return }
    
    // Получаем ссылку на SearchResultsController
    if let searchResultsController = searchController.searchResultsController as? SearchResultScreenViewController {
      print(#function)
    }
    
    
//    NSObject.cancelPreviousPerformRequests(
//      withTarget: self,
//      selector: #selector(fetchMatchingItems),
//      object: nil
//    )
//    perform(#selector(fetchMatchingItems), with: nil, afterDelay: 0.3)
    
    
  }
}
