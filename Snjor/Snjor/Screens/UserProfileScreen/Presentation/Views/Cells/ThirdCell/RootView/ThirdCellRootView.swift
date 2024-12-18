//
//  ThirdCellRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class ThirdCellRootView: BaseView {
  // MARK: Views
  lazy var noAlbumsStackView: UIStackView = {
    $0.alpha = Const.bigIconOpacity
    $0.isUserInteractionEnabled = false
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(noAlbumImageView)
    $0.addArrangedSubview(noAlbumsLabel)
    return $0
  }(UIStackView())
  
  private let noAlbumImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.macroCircleIcon
    $0.tintColor = .systemGreen
    $0.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let noAlbumsLabel: UILabel = {
    $0.text = .noAlbums
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: Const.bigIconFontName,
      size: Const.bigIconFontSize
    )
    return $0
  }(UILabel())
  
  let userAlbumsCollectionView: UserAlbumsCollectionView = {
    $0.backgroundColor = .black
    return $0
  }(UserAlbumsCollectionView())
  
  // MARK: Initializers
  override func initViews() {
    setupViews()
    setupConstraints()
  }
  
  // MARK: Private Methods
  private func setupViews() {
    addSubview(userAlbumsCollectionView)
    addSubview(noAlbumsStackView)
  }
  
  private func setupConstraints() {
    noAlbumsStackView.setConstraints(
      centerY: centerYAnchor,
      centerX: centerXAnchor,
      pCenterY: Const.stackViewCenterYOffset
    )
  }
}
