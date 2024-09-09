//
//  UserTableViewCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.09.2024.
//

import UIKit

final class UserTableViewCellMainView: MainImageContainerView {
  // MARK: Private Views
  private let userNameLabel: UILabel = {
    $0.font = UIFont.systemFont(
      ofSize: UserTableViewCellMainViewConst.userNameFontSize,
      weight: .medium
    )
    $0.textColor = .label
    return $0
  }(UILabel())
  
  private let heartImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .rightChevron)
    $0.tintColor = .systemGray
    return $0
  }(UIImageView())
  
  lazy var mainStackView: UIStackView = {
    $0.axis = .horizontal
    $0.spacing = UserTableViewCellMainViewConst.stackViewSpacing
    $0.alignment = .center
    $0.addArrangedSubview(mainImageView)
    $0.addArrangedSubview(userNameLabel)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(heartImageView)
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
    userNameLabel.text = user.displayName
  }
  
  func prepareForReuse() {
    reset()
  }
  
  private func reset() {
    currentPhotoID = nil
    mainImageView.image = nil
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
