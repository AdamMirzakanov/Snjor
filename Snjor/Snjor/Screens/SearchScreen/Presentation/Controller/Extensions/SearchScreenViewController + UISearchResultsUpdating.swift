//
//  SearchScreenViewController + UISearchResultsUpdating.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 20.08.2024.
//

import UIKit

extension SearchScreenViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    NSObject.cancelPreviousPerformRequests(
      withTarget: self,
      selector: #selector(fetchMatchingItems),
      object: nil
    )
    perform(#selector(fetchMatchingItems), with: nil, afterDelay: 0.3)
  }
}
