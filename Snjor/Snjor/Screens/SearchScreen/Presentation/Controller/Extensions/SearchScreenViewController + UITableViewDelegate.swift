//
//  SearchScreenViewController + UITableViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.09.2024.
//

import UIKit

extension SearchScreenViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let delegate = delegate else { return }
    let user = usersViewModel.getItem(at: indexPath.row)
    delegate.userRowDidSelect(user)
  }
}
