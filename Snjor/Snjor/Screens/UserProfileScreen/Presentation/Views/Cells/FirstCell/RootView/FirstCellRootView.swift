//
//  FirstCellRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class FirstCellRootView: BaseView {
  // MARK: Views
  private let noLikedPhotosLabel: UILabel = {
    $0.text = .noLikes
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: Const.bigIconFontName,
      size: Const.bigIconFontSize
    )
    return $0
  }(UILabel())
  
  private let noLikedImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.heartCircleIcon
    $0.tintColor = .systemPink
    $0.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  lazy var noLikedPhotosStackView: UIStackView = {
    $0.alpha = Const.bigIconOpacity
    $0.isUserInteractionEnabled = false
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(noLikedImageView)
    $0.addArrangedSubview(noLikedPhotosLabel)
    return $0
  }(UIStackView())
  
  let userLikedPhotosCollectionView: UserLikedPhotosCollectionView = {
    $0.backgroundColor = .black
    return $0
  }(UserLikedPhotosCollectionView())
  
  // MARK: Initializers
  override func initViews() {
    setupViews()
    setupConstraints()
  }
  
  // MARK: Private Methods
  private func setupViews() {
    addSubview(userLikedPhotosCollectionView)
    addSubview(noLikedPhotosStackView)
  }
  
  private func setupConstraints() {
    noLikedPhotosStackView.setConstraints(
      centerY: centerYAnchor,
      centerX: centerXAnchor,
      pCenterY: Const.stackViewCenterYOffset
    )
  }
}
