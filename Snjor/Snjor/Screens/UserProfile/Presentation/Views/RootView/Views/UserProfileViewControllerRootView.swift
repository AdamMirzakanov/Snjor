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
  private var screenWidth: CGFloat {
    UIScreen.main.bounds.width
  }
  
  private lazy var tabButtons = [
    userLikedPhotosButton, userPhotosButton, userAlbumsButton
  ]
  
  // MARK: CollectinView
  lazy var userProfileCollectionView: UserProfileCollectionView = {
    $0.heightAnchor.constraint(
      equalToConstant: Const.heightUserProfileCollectionView
    ).isActive = true
    return $0
  }(UserProfileCollectionView())
  
  // MARK: Indicator
  lazy var indicatorView: UIView = {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = Const.indicatorViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIView())
  
  // MARK: Main Background Photo
  var backgroundPhotoView: UserProfilePhotoView = {
    return $0
  }(UserProfilePhotoView())
  
  // MARK: User Profile Photo
  private let profilePhotoView: UserProfilePhotoView = {
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
  private let locationImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .locationIcon)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  // MARK: Buttons
  private let userLikedPhotosButton: UIButton = {
    let icon = UIImage(systemName: .heartIcon)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .systemPink
    $0.imageView?.contentMode = .scaleAspectFit
    return $0
  }(UIButton())
  
//  private let userPhotosButton: UIButton = {
//    let icon = UIImage(systemName: .photoIcon)
//    $0.setImage(icon, for: .normal)
//    $0.imageView?.contentMode = .scaleAspectFit
//    $0.alpha = Const.defaultOpacity
//    return $0
//  }(UIButton())
  
  private let userPhotosButton: UIButton = {
    let icon = UIImage(named: .photosIcon)
    let imageView = UIImageView(image: icon)
    imageView.contentMode = .scaleAspectFit
    $0.alpha = Const.defaultOpacity
    $0.tintColor = .white
    $0.addSubview(imageView)
    imageView.setConstraints(left: $0.leftAnchor, centerY: $0.centerYAnchor, pLeft: 10)
    imageView.heightAnchor.constraint(equalToConstant: Const.iconSize).isActive = true
    return $0
  }(UIButton())
  
  private let userAlbumsButton: UIButton = {
    let icon = UIImage(systemName: .macroIcon)
    $0.setImage(icon, for: .normal)
    $0.imageView?.contentMode = .scaleAspectFit
    $0.tintColor = .white
    $0.alpha = Const.defaultOpacity
    return $0
  }(UIButton())
  
  // MARK: Labels
  private let nameLabel: UILabel = {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: .timesNewRomanBold,
      size: Const.userNameFontSize
    )
    return $0
  }(UILabel())
  
  private let bioLabel: UILabel = {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .light
    )
    return $0
  }(UILabel())
  
  private let locationLabel: UILabel = {
    $0.textColor = .white
    $0.numberOfLines = .zero
    $0.textAlignment = .center
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
  
  private lazy var locationStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.halfStackViewSpacing
    $0.addArrangedSubview(locationImageView)
    $0.addArrangedSubview(locationLabel)
    $0.isHidden = true
    return $0
  }(UIStackView())
  
  private lazy var iconsStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.spacing = .zero
    $0.heightAnchor.constraint(
      equalToConstant: Const.iconsStackViewHeight
    ).isActive = true
    return $0
  }(UIStackView())
  
  private lazy var infoStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(profilePhotoAndNameLabelStackView)
    $0.addArrangedSubview(bioLabel)
    $0.addArrangedSubview(firstLine)
    $0.widthAnchor.constraint(
      equalToConstant: screenWidth - Const.infoStackViewPadding
    ).isActive = true
    return $0
  }(UIStackView())
  
  private lazy var infoContainerStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = .zero
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(infoStackView)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())
  
  private lazy var mainStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(infoContainerStackView)
    $0.addArrangedSubview(iconsStackView)
    $0.addArrangedSubview(secondLine)
    $0.addArrangedSubview(userProfileCollectionView)
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
    let pageWidth = userProfileCollectionView.bounds.size.width
    let contentOffsetX = userProfileCollectionView.contentOffset.x
    let currentPage = round(contentOffsetX / pageWidth)
    switch Int(currentPage) {
    case .likedPhotos:
      userLikedPhotosButton.alpha = Const.maxOpacity
      userPhotosButton.alpha = Const.defaultOpacity
      userAlbumsButton.alpha = Const.defaultOpacity
      userAlbumsButton.tintColor = .white
    case .userHasPhotos:
      userLikedPhotosButton.alpha = Const.defaultOpacity
      userPhotosButton.alpha = Const.maxOpacity
      userAlbumsButton.alpha = Const.defaultOpacity
      userAlbumsButton.tintColor = .white
    default:
      userLikedPhotosButton.alpha = Const.defaultOpacity
      userPhotosButton.alpha = Const.defaultOpacity
      userAlbumsButton.alpha = Const.maxOpacity
      userAlbumsButton.tintColor = .systemGreen
    }
  }
  
  func setupData(viewModel: any UserProfileViewModelProtocol) {
    let viewModelItem = viewModel.getUserProfileViewModelItem()
    guard let viewModelItem = viewModelItem else { return }
    let photo = viewModelItem.photo
    let user = viewModelItem.user
    let backgroundPhotoURL = photo.regularURL
    let profilePhotoURL = user.regularURL
    backgroundPhotoView.configure(with: viewModelItem.photo, url: backgroundPhotoURL)
    profilePhotoView.configure(with: user, url: profilePhotoURL)
    nameLabel.text = viewModelItem.displayName
    bioLabel.text = viewModelItem.userBio
    locationLabel.text = viewModelItem.location
    if viewModelItem.userBio == .empty {
      bioLabel.isHidden = true
    }
    if viewModelItem.location == .empty {
      locationStackView.isHidden = true
    } else {
      locationStackView.isHidden = false
    }
    let userLikedPhotos = .spacer + viewModelItem.totalLikes
    let userPhotos = .tab + viewModelItem.totalPhotos
    let userAlbums = .spacer + viewModelItem.totalCollections
    
    userLikedPhotosButton.setTitle(userLikedPhotos, for: .normal)
    userPhotosButton.setTitle(userPhotos, for: .normal)
    userAlbumsButton.setTitle(userAlbums, for: .normal)
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
    setupTabIcons()
  }
  
  private func addSubviews() {
    addSubview(backgroundPhotoView)
    addSubview(gradientView)
    addSubview(mainStackView)
    addSubview(indicatorView)
    addSubview(bottomGradientView)
  }
  
  private func setupConstraints() {
    setupGradientViewConstraints()
    setupMainStackViewConstraints()
    setupIndicatorViewConstraints()
    setupBottomGradientViewConstraints()
    mainBackgroundPhotoConstraints()
  }
  
  private func setupGradientViewConstraints() {
    gradientView.fillSuperView()
  }
  
  private func setupMainStackViewConstraints() {
    mainStackView.setConstraints(
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pRight: Const.rightPadding,
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
      constant: traitCollection.displayScale * Const.indicatorHeightMultiplier
    ).isActive = true
    indicatorView.widthAnchor.constraint(
      equalToConstant: screenWidth / Const.indicatorWidthDivision
    ).isActive = true
  }
  
  private func setupBottomGradientViewConstraints() {
    bottomGradientView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pBottom: Const.bottomGradientViewBottomPadding
    )
    bottomGradientView.transform = CGAffineTransform(rotationAngle: .pi)
  }
  
  private func mainBackgroundPhotoConstraints() {
    backgroundPhotoView.setConstraints(
      top: gradientView.topAnchor,
      right: gradientView.rightAnchor,
      bottom: gradientView.bottomAnchor,
      left: gradientView.leftAnchor,
      pBottom: 370
    )
  }
  
  private func setupTabIcons() {
    for (index, button) in tabButtons.enumerated() {
      var tabButton = UIButton()
      tabButton = button
      tabButton.tag = index
      tabButton.addTarget(
        self,
        action: #selector(tabButtonTapped(_:)),
        for: .touchUpInside
      )
      iconsStackView.addArrangedSubview(tabButton)
    }
  }
  
  @objc private func tabButtonTapped(_ sender: UIButton) {
    let indexPath = IndexPath(item: sender.tag, section: .zero)
    userProfileCollectionView.scrollToItem(
      at: indexPath,
      at: .centeredHorizontally,
      animated: true
    )
  }
}
