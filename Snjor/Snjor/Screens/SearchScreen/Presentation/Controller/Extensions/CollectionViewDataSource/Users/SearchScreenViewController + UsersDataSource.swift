//
//  SearchScreenViewController + UsersDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

import UIKit

extension SearchScreenViewController {
  // MARK: Private Properties
  private var usersSnapshot: UsersSnapshot {
    var snapshot = UsersSnapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(usersViewModel.items, toSection: .main)
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
    usersDataSource = UsersDataSource(
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
        indexPath: indexPath
      )
    }
  }
  
  private func configureCell(
    tableView: UITableView,
    indexPath: IndexPath
  ) -> UITableViewCell {
    let section = usersSections[indexPath.section]
    switch section {
    case .main:
      return configureUserCell(
        tableView: tableView,
        indexPath: indexPath
      )
    }
  }
  
  private func configureUserCell(
    tableView: UITableView,
    indexPath: IndexPath
  ) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: UserTableViewCell.reuseID,
        for: indexPath
      ) as? UserTableViewCell
    else {
      return UITableViewCell()
    }
    
    let viewModelItem = usersViewModel.getSearchItemsViewModelItem(
      at: indexPath.row,
      with: .initialUserSearchQuery
    )
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
