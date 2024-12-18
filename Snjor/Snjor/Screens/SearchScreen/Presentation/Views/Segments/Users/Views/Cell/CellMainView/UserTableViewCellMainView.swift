//
//  UserTableViewCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

import UIKit

fileprivate typealias Const = UserTableViewCellMainViewConst

final class UserTableViewCellMainView: UIView {
  // MARK: Private Views
  private let avatarView: AvatarView = {
    return $0
  }(AvatarView())
  
  private let nameLabel: UILabel = {
    $0.font = UIFont.systemFont(
      ofSize: Const.nameFontSize,
      weight: .medium
    )
    $0.textColor = .label
    return $0
  }(UILabel())
  
  private let userNameLabel: UILabel = {
    $0.font = UIFont.systemFont(
      ofSize: Const.userNameFontSize,
      weight: .medium
    )
    $0.textColor = .systemGray
    return $0
  }(UILabel())
  
  private let chevronImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.rightChevronIcon
    $0.tintColor = .systemGray
    return $0
  }(UIImageView())
  
  private lazy var userNameStackView: UIStackView = {
    $0.axis = .vertical
    $0.spacing = Const.stackViewSpacing
    $0.alignment = .leading
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(userNameLabel)
    return $0
  }(UIStackView())
  
  private lazy var avatarAndUserNameStackView: UIStackView = {
    $0.axis = .horizontal
    $0.spacing = Const.stackViewSpacing
    $0.alignment = .center
    $0.addArrangedSubview(avatarView)
    $0.addArrangedSubview(userNameStackView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(chevronImageView)
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
    configImage()
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Setup Data
  func configure(with user: User, showsUsername: Bool = false, url: URL?) {
    avatarView.configure(url: url, photoID: user.id)
    nameLabel.text = user.name
    userNameLabel.text = "@" + user.username
  }
  
  func prepareForReuse() {
    reset()
  }
  
  private func reset() {
    avatarView.currentPhotoID = nil
    avatarView.mainImageView.image = nil
    nameLabel.text = nil
    userNameLabel.text = nil
    avatarView.imageDownloader.cancel()
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubview(avatarAndUserNameStackView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    avatarAndUserNameStackView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pTop: Const.topPadding,
      pRight: Const.rightPadding,
      pBottom: Const.bottomPadding,
      pLeft: Const.leftPadding)
  }
  
  private func configImage() {
    let cornerRadius = Const.mainImageViewCornerRadius
    avatarView.layer.cornerRadius = cornerRadius
    avatarView.widthAnchor.constraint(
      equalToConstant: Const.mainImageViewSize
    ).isActive = true
    avatarView.heightAnchor.constraint(
      equalToConstant: Const.mainImageViewSize
    ).isActive = true
    avatarView.clipsToBounds = true
  }
}
