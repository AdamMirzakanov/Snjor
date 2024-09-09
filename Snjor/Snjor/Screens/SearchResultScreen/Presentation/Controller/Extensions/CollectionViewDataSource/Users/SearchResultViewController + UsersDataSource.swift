//
//  SearchResultViewController + UsersDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.09.2024.
//

import UIKit

extension SearchResultViewController {
  // MARK: Private Properties
  private var usersSnapshot: SearchResultUsersSnapshot {
    var snapshot = SearchResultUsersSnapshot()
    snapshot.appendSections([.users])
    snapshot.appendItems(usersViewModel.items, toSection: .users)
    usersSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: Internal Methods
  func applyUsersSnapshot() {
    guard let dataSource = usersDataSource else { return }
    dataSource.apply(
      usersSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createUsersDataSource(
    for tableView: UITableView
  ) {
    usersDataSource = SearchResultUsersDataSource(
      tableView: tableView
    ) { [weak self] collectionView, indexPath, user in
      let cell = UITableViewCell()
      guard
        let self = self
      else {
        return cell
      }
      return self.configureCell(
        tableView: tableView,
        indexPath: indexPath,
        user: user
      )
    }
  }
  
  private func configureCell(
    tableView: UITableView,
    indexPath: IndexPath,
    user: User
  ) -> UITableViewCell {
    let section = usersSections[indexPath.section]
    switch section {
    case .users:
      return configureUserCell(
        tableView: tableView,
        indexPath: indexPath,
        user: user
      )
    }
  }
  
  private func configureUserCell(
    tableView: UITableView,
    indexPath: IndexPath,
    user: User
  ) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: UserTableViewCell.reuseID,
        for: indexPath
      ) as? UserTableViewCell
    else {
      return UITableViewCell()
    }
    
    guard let currentSearchTerm = self.currentSearchTerm else {
      return cell
    }
    
    let viewModelItem = usersViewModel.getSearchItemsViewModelItem(
      at: indexPath.row,
      with: currentSearchTerm
    )
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}

