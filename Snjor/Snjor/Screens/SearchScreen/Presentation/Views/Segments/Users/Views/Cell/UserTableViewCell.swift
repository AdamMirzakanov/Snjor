//
//  UserTableViewCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
  // MARK: Main View
  private let mainView: UserTableViewCellMainView = {
    return $0
  }(UserTableViewCellMainView())
  
  // MARK: Initializers
  override init(
    style: UITableViewCell.CellStyle,
    reuseIdentifier: String?
  ) {
    super.init(
      style: style,
      reuseIdentifier: reuseIdentifier
    )
    setupMainView()
  }
  
  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
  
  // MARK: Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    mainView.prepareForReuse()
  }
  
  // MARK: Setup Data
  func configure(viewModelItem: BaseViewModelItem<User>) {
    let user = viewModelItem.item
    let photoURL = viewModelItem.photoURL
    mainView.configure(with: user, url: photoURL)
  }

  // MARK: Setup Views
  private func setupMainView() {
    contentView.addSubview(mainView)
    mainView.fillSuperView()
  }
}
