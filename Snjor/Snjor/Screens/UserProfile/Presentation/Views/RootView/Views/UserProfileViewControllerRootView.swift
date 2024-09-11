//
//  UserProfileViewControllerRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 10.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class UserProfileViewControllerRootView: UIView {
  // MARK: Private Properties
  
  
  // MARK: Views
  let profilePhotoView: UserProfilePhotoView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = Const.profilePhotoCircle
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.profilePhotoSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.profilePhotoSize
    ).isActive = true
    return $0
  }(UserProfilePhotoView())
  
  private let gradientView: MainGradientView = {
    $0.isUserInteractionEnabled = false
    let color = UIColor(
      white: .zero,
      alpha: Const.gradientOpacity
    )
    $0.setColors([
      MainGradientView.Color(
        color: .clear,
        location: Const.gradientEndLocation
      ),
      MainGradientView.Color(
        color: color,
        location: Const.gradientStartLocation
      )
    ])
    return $0
  }(MainGradientView())
  
  private let likesImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .heartImage)
    $0.tintColor = .systemPink
    return $0
  }(UIImageView())
  
  let likesLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let nameLabel: UILabel = {
    $0.textColor = .white
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: .timesNewRomanBold,
      size: Const.userNameFontSize
    )
    return $0
  }(UILabel())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Setup Data
  func setupData(viewModel: any UserProfileViewModelProtocol) {
    let viewModelItem = viewModel.getUserProfileViewModelItem()
    guard let viewModelItem = viewModelItem else { return }
    let user = viewModelItem.user
    let profilePhotoURL = user.regularURL
    profilePhotoView.configure(with: user, url: profilePhotoURL)
    nameLabel.text = viewModelItem.displayName
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
     addSubview(profilePhotoView)
  }
  
  private func setupConstraints() {
    profilePhotoView.centerXY()
  }
  
}

enum UserProfileViewControllerRootViewConst {
  static let gradientOpacity: CGFloat = 0.8
  static let gradientStartLocation: CGFloat = 0.9
  static let gradientEndLocation: CGFloat = 0.1
  static let defaultFontSize: CGFloat = 14.0
  static let userNameFontSize: CGFloat = 25.0
  static let profilePhotoSize: CGFloat = 100.0
  static let profilePhotoCircle: CGFloat = profilePhotoSize / 2
}
