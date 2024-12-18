//
//  SecondCellRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class SecondCellRootView: BaseView {
  // MARK: Views
  lazy var noPhotosStackView: UIStackView = {
    $0.alpha = Const.bigIconOpacity
    $0.isUserInteractionEnabled = false
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(noPhotoImageView)
    $0.addArrangedSubview(noPhotosLabel)
    return $0
  }(UIStackView())
  
  private let noPhotoImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.photoCircleIcon
    $0.tintColor = .systemOrange
    $0.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let noPhotosLabel: UILabel = {
    $0.text = .noPhotos
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: Const.bigIconFontName,
      size: Const.bigIconFontSize
    )
    return $0
  }(UILabel())
  
  let userPhotosCollectionView: UserPhotosCollectionView = {
    $0.backgroundColor = .black
    return $0
  }(UserPhotosCollectionView())
  
  // MARK: Initializers
  override func initViews() {
    setupViews()
    setupConstraints()
  }
  
  // MARK: Private Methods
  private func setupViews() {
    addSubview(userPhotosCollectionView)
    addSubview(noPhotosStackView)
  }
  
  private func setupConstraints() {
    noPhotosStackView.setConstraints(
      centerY: centerYAnchor,
      centerX: centerXAnchor,
      pCenterY: Const.stackViewCenterYOffset
    )
  }
}
