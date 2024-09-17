//
//  UserProfileViewControllerRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 10.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class UserProfileViewControllerRootView: UIView {
  // MARK: Internal Properties
  var indicatorPosition: CGFloat = .zero
  
  // MARK: Private Properties
  private let screenWidth = UIScreen.main.bounds.width - 40
  
  // MARK: CollectinView
  let mainHorizontalCollectionView: UserProfileCollectionView = {
    $0.heightAnchor.constraint(
      equalToConstant: 300
    ).isActive = true
    return $0
  }(UserProfileCollectionView())
  
  // MARK: Indicator
  lazy var indicatorView: UIView = {
    $0.backgroundColor = .white
    return $0
  }(UIView())
  
  // MARK: UserProfilePhoto
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
  
  // MARK: Gradient
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
  
  
  private let bottomGradientView: MainGradientView = {
    $0.isUserInteractionEnabled = false
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      MainGradientView.Color(
        color: UIColor(
          white: .zero,
          alpha: PageScreenRootViewConst.gradientOpacity
        ),
        location: PageScreenRootViewConst.gradientStartLocation
      ),
      MainGradientView.Color(
        color: .clear,
        location: PageScreenRootViewConst.gradientEndLocation
      ),
    ])
    $0.isUserInteractionEnabled = false
    return $0
  }(MainGradientView())
  
  // MARK: ImageViews
  private let totalLikesImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .heartImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  private let totalPhotosImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: .photosImage)
    $0.widthAnchor.constraint(
      equalToConstant: Const.socialIconSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.socialIconSize
    ).isActive = true
    $0.alpha = 0.5
    return $0
  }(UIImageView())
  
  private let totalAlbumsImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .albumsImage)
    $0.tintColor = .white
    $0.alpha = 0.5
    return $0
  }(UIImageView())
  
  private let locationImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .locationImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  private let instImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: .instIcon)
    $0.widthAnchor.constraint(
      equalToConstant: Const.socialIconSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.socialIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let twitImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: .twitIcon)
    $0.widthAnchor.constraint(
      equalToConstant: Const.socialIconSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.socialIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  // MARK: Labels
  let nameLabel: UILabel = {
    $0.textColor = .white
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: .timesNewRomanBold,
      size: Const.userNameFontSize
    )
    return $0
  }(UILabel())
  
  let bioLabel: UILabel = {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .light
    )
    return $0
  }(UILabel())
  
  let instLabel: UILabel = {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let twitLabel: UILabel = {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let indicatorPositionLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: 20,
      weight: .black
    )
    return $0
  }(UILabel())
  
  let totalPhotosLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let totalAlbumsLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let locationLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  // MARK: Lines
  private let firstLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = Const.defaultOpacity
    $0.heightAnchor.constraint(
      equalToConstant: Const.lineWidth
    ).isActive = true
    return $0
  }(UIView())
  
  private let secondLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = Const.defaultOpacity
    $0.heightAnchor.constraint(
      equalToConstant: Const.lineWidth
    ).isActive = true
    return $0
  }(UIView())
  
  // MARK: StackViews
  private lazy var profilePhotoAndNameLabelStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(profilePhotoView)
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(locationStackView)
    return $0
  }(UIStackView())
  
  private lazy var instStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(instImageView)
    $0.addArrangedSubview(instLabel)
    return $0
  }(UIStackView())
  
  private lazy var twitStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .leading
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(twitImageView)
    $0.addArrangedSubview(twitLabel)
    return $0
  }(UIStackView())
  
  private lazy var locationStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.halfStackViewSpacing
    $0.addArrangedSubview(locationImageView)
    $0.addArrangedSubview(locationLabel)
    return $0
  }(UIStackView())
  
  private lazy var socialStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .leading
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(instStackView)
    $0.addArrangedSubview(twitStackView)
    return $0
  }(UIStackView())
  
  private lazy var totalLikesStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(totalLikesImageView)
//    $0.addArrangedSubview(totalLikesLabel)
    return $0
  }(UIStackView())
  
  private lazy var totalPhotosStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(totalPhotosImageView)
//    $0.addArrangedSubview(totalPhotosLabel)
    return $0
  }(UIStackView())
  
  private lazy var totalAlbumsStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(totalAlbumsImageView)
//    $0.addArrangedSubview(totalAlbumsLabel)
    return $0
  }(UIStackView())
  
  private lazy var profitStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(totalLikesStackView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(totalPhotosStackView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(totalAlbumsStackView)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())
  
  private lazy var infoStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(profilePhotoAndNameLabelStackView)
    $0.addArrangedSubview(bioLabel)
    $0.addArrangedSubview(firstLine)
    $0.addArrangedSubview(profitStackView)
    $0.addArrangedSubview(secondLine)
    $0.addArrangedSubview(indicatorPositionLabel)
    $0.addArrangedSubview(mainHorizontalCollectionView)
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Setup Data
  func updateLabelBasedOnVisibleCell(viewModel: any UserProfileViewModelProtocol) {
    guard let visibleIndexPath = mainHorizontalCollectionView.indexPathsForVisibleItems.first else {
      return
    }
    let viewModelItem = viewModel.getUserProfileViewModelItem()
    guard let viewModelItem = viewModelItem else { return }
    switch visibleIndexPath.item {
    case 0:
      indicatorPositionLabel.text = "Liked " + viewModelItem.totalLikes + " photos"
      totalLikesImageView.alpha = 1
      totalPhotosImageView.alpha = 0.5
      totalAlbumsImageView.alpha = 0.5
    case 1:
      indicatorPositionLabel.text = "User has " + viewModelItem.totalPhotos + " photos"
      totalLikesImageView.alpha = 0.5
      totalPhotosImageView.alpha = 1
      totalAlbumsImageView.alpha = 0.5
    default:
      indicatorPositionLabel.text = "User has " + viewModelItem.totalCollections + " albums"
      totalLikesImageView.alpha = 0.5
      totalPhotosImageView.alpha = 0.5
      totalAlbumsImageView.alpha = 1
    }
  }
  
  func setupData(viewModel: any UserProfileViewModelProtocol) {
    let viewModelItem = viewModel.getUserProfileViewModelItem()
    guard let viewModelItem = viewModelItem else { return }
    let user = viewModelItem.user
    let profilePhotoURL = user.regularURL
    profilePhotoView.configure(with: user, url: profilePhotoURL)
    nameLabel.text = viewModelItem.displayName
    bioLabel.text = viewModelItem.userBio
    indicatorPositionLabel.text = "Liked " + viewModelItem.totalLikes + " photos"
    locationLabel.text = viewModelItem.location
//    instLabel.text = viewModelItem.instagramUserName
//    twitLabel.text = viewModelItem.twitterUsername
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(gradientView)
    addSubview(infoStackView)
    addSubview(indicatorView)
    addSubview(bottomGradientView)
  }
  
  private func setupConstraints() {
    setupGradientViewConstraints()
    setupInfoStackViewConstraints()
    setupIndicatorViewConstraints()
    setupBottomGradientViewConstraints()
  }
  
  private func setupGradientViewConstraints() {
    gradientView.fillSuperView()
  }
  
  private func setupInfoStackViewConstraints() {
    infoStackView.setConstraints(
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pRight: Const.rightPadding,
      pBottom: Const.bottomPadding,
      pLeft: Const.leftPadding
    )
  }
  
  private func setupIndicatorViewConstraints() {
    indicatorView.setConstraints(
      top: secondLine.topAnchor,
      left: secondLine.leftAnchor
    )
    indicatorView.heightAnchor.constraint(
      equalTo: secondLine.heightAnchor,
      constant: traitCollection.displayScale * 0.7
    ).isActive = true
    indicatorView.widthAnchor.constraint(
      equalToConstant: screenWidth / 3
    ).isActive = true
  }
  
  private func setupBottomGradientViewConstraints() {
    bottomGradientView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pBottom: -100
    )
    
    bottomGradientView.transform = CGAffineTransform(rotationAngle: .pi)
  }
}
