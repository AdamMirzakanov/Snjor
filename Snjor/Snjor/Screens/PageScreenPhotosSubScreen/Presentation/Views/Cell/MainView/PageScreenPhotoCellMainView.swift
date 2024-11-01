//
//  PageScreenPhotoCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 30.07.2024.
//

import UIKit

fileprivate typealias Const = PageScreenPhotoCellMainViewConst

final class PageScreenPhotoCellMainView: MainImageContainerView {
  // MARK: Private Properties
  private var screenScale: CGFloat {
    UIScreen.main.scale
  }
  
  private var showsUsername = true {
    didSet {
      userNameLabel.alpha = showsUsername ? Const.maxOpacity : .zero
      gradientView.alpha = showsUsername ? Const.maxOpacity : .zero
    }
  }
  
  // MARK: Views
  private let gradientView: MainGradientView = {
    let color = UIColor(
      white: .zero,
      alpha: Const.gradientOpacity
    )
    $0.setColors([
      MainGradientView.Color(
        color: .clear,
        location: Const.gradientStartLocation
      ),
      MainGradientView.Color(
        color: color,
        location: Const.gradientEndLocation
      )
    ])
    return $0
  }(MainGradientView())
  
  private let avatarView: UserProfilePhotoView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = Const.profilePhotoViewCircle
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.profilePhotoViewSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.profilePhotoViewSize
    ).isActive = true
    return $0
  }(UserProfilePhotoView())
  
  private let checkmarkIconImageView: UIImageView = {
    $0.image = SFSymbol.checkmarkIcon
    $0.tintColor = .white
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.checkmarkIconSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.checkmarkIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let userNameLabel: UILabel = {
    $0.textColor = .white
    $0.numberOfLines = .zero
    $0.font = .systemFont(
      ofSize: Const.userNameLabelFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  private lazy var userNameLabelAndcheckmarkIconStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(userNameLabel)
    $0.addArrangedSubview(checkmarkIconImageView)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())
  
  private lazy var profileStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.middleValue
    $0.addArrangedSubview(avatarView)
    $0.addArrangedSubview(userNameLabelAndcheckmarkIconStackView)
    return $0
  }(UIStackView())

  // MARK: Initializers
  override init() {
    super.init()
    setupPhotoCellViews()
  }

  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
  
  // MARK: Sized Image
  override func sizedImageURL(from url: URL) -> URL {
    layoutIfNeeded()
    let widthValue = String(describing: frame.width)
    let screenScaleValue = String(describing: Int(screenScale))
    let widthQueryItem = URLQueryItem(
      name: ParamKey.width.rawValue,
      value: widthValue
    )
    let screenScaleQueryItem = URLQueryItem(
      name: ParamKey.devicePixelRatio.rawValue,
      value: screenScaleValue
    )
    return url.appending(
      queryItems: [widthQueryItem, screenScaleQueryItem]
    )
  }

  // MARK: Setup Data
  func configure(
    with photo: Photo,
    showsUsername: Bool = true,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: photo.blurHash,
      photoID: photo.id
    )
    self.showsUsername = showsUsername
    userNameLabel.text = photo.user.displayName
    avatarView.configure(
      with: photo,
      url: photo.profileImageURL
    )
  }
  
  // MARK: Setup Views
  private func setupPhotoCellViews() {
    addSubviews()
    setupConstraints()
  }

  private func addSubviews() {
    addSubview(gradientView)
    addSubview(profileStackView)
  }

  private func setupConstraints() {
    setupGradientConstraints()
    setupUserNameLabelConstraints()
  }

  private func setupGradientConstraints() {
    gradientView.fillSuperView()
  }

  private func setupUserNameLabelConstraints() {
    profileStackView.setConstraints(
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pRight: Const.middleValue,
      pBottom: Const.middleValue,
      pLeft: Const.middleValue
    )
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
}
