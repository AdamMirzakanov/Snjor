//
//  UserTableViewCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

import UIKit

final class UserTableViewCellMainView: MainImageContainerView {
  // MARK: Private Views
  private let nameLabel: UILabel = {
    $0.font = UIFont.systemFont(
      ofSize: UserTableViewCellMainViewConst.nameFontSize,
      weight: .medium
    )
    $0.textColor = .label
    return $0
  }(UILabel())
  
  private let userNameLabel: UILabel = {
    $0.font = UIFont.systemFont(
      ofSize: UserTableViewCellMainViewConst.userNameFontSize,
      weight: .medium
    )
    $0.textColor = .systemGray
    return $0
  }(UILabel())
  
  private let chevronImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .rightChevronIcon)
    $0.tintColor = .systemGray
    return $0
  }(UIImageView())
  
  lazy var userNameStackView: UIStackView = {
    $0.axis = .vertical
    $0.spacing = UserTableViewCellMainViewConst.stackViewSpacing
    $0.alignment = .leading
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(userNameLabel)
    return $0
  }(UIStackView())
  
  lazy var mainStackView: UIStackView = {
    $0.axis = .horizontal
    $0.spacing = UserTableViewCellMainViewConst.stackViewSpacing
    $0.alignment = .center
    $0.addArrangedSubview(mainImageView)
    $0.addArrangedSubview(userNameStackView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(chevronImageView)
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  override init() {
    super.init()
    setupViews()
    configImage()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Setup Data
  func configure(with user: User, showsUsername: Bool = false, url: URL?) {
    super.configure(url: url, photoID: user.id)
    nameLabel.text = user.name
    userNameLabel.text = "@" + user.username
  }
  
  func prepareForReuse() {
    reset()
  }
  
  private func reset() {
    currentPhotoID = nil
    mainImageView.image = nil
    nameLabel.text = nil
    userNameLabel.text = nil
    imageDownloader.cancel()
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubview(mainStackView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    mainStackView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pTop: UserTableViewCellMainViewConst.topPadding,
      pRight: UserTableViewCellMainViewConst.rightPadding,
      pBottom: UserTableViewCellMainViewConst.bottomPadding,
      pLeft: UserTableViewCellMainViewConst.leftPadding)
  }
  
  private func configImage() {
    let cornerRadius = UserTableViewCellMainViewConst.mainImageViewCornerRadius
    mainImageView.layer.cornerRadius = cornerRadius
    mainImageView.widthAnchor.constraint(
      equalToConstant: UserTableViewCellMainViewConst.mainImageViewSize
    ).isActive = true
    mainImageView.heightAnchor.constraint(
      equalToConstant: UserTableViewCellMainViewConst.mainImageViewSize
    ).isActive = true
    mainImageView.clipsToBounds = true
  }
}
