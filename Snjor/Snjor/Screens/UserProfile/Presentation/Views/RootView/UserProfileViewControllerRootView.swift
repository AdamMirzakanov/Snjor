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
  private var backBarButtonAction: (() -> Void)?
  private var screenWidth: CGFloat {
    UIScreen.main.bounds.width
  }
  
  private lazy var tabButtons = [
    userLikedPhotosButton, userPhotosButton, userAlbumsButton
  ]
  
  // MARK: Container View
  private let mainView: UIView = {
    return $0
  }(UIView())
  
  // MARK: Collectin View
  lazy var horizontalCollectionView: UserProfileCollectionView = {
    $0.backgroundColor = .black
    $0.heightAnchor.constraint(
      equalToConstant: Const.heightUserProfileCollectionView
    ).isActive = true
    $0.clipsToBounds = true
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
  private let backgroundPhotoView: UserProfilePhotoView = {
    $0.backgroundColor = .black
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
  private let backgroundGradientView: MainGradientView = {
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
  
  // MARK: Blur Effects
  private let backBarButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = Const.fullValue
    $0.frame.size.height = Const.fullValue
    $0.layer.cornerRadius = Const.defaultCircle
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  // MARK: ImageViews
  private let locationImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .locationIcon)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  // MARK: Buttons
  private lazy var backBarButton: UIButton = {
    let icon = UIImage(systemName: .backBarButtonIcon)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.alpha = Const.defaultOpacity
    $0.frame = backBarButtonBlurEffect.bounds
    return $0
  }(UIButton())
  
  private let userLikedPhotosButton: UIButton = {
    let icon = UIImage(systemName: .heartFillIcon)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .systemPink
    $0.imageView?.contentMode = .scaleAspectFit
    return $0
  }(UIButton())
  
  private let userPhotosButton: UIButton = {
    let icon = UIImage(named: .photosIcon)
    let imageView = UIImageView(image: icon)
    imageView.contentMode = .scaleAspectFit
    $0.alpha = Const.defaultOpacity
    $0.tintColor = .white
    $0.addSubview(imageView)
    imageView.setConstraints(
      left: $0.leftAnchor,
      centerY: $0.centerYAnchor,
      pLeft: Const.userPhotosButtonLeftPadding
    )
    imageView.heightAnchor.constraint(
      equalToConstant: Const.iconSize
    ).isActive = true
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
  
  private lazy var userInfoStackView: UIStackView = {
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
  
  private lazy var userInfoStackContainerStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = .zero
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(userInfoStackView)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())
  
  private lazy var mainStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(userInfoStackContainerStackView)
    $0.addArrangedSubview(iconsStackView)
    $0.addArrangedSubview(secondLine)
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    backgroundColor = .black
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Setup Data
  func updateButtonStatesForVisiblePage(
    for viewModel: any UserProfileViewModelProtocol
  ) {
    let pageWidth = horizontalCollectionView.bounds.size.width
    let contentOffsetX = horizontalCollectionView.contentOffset.x
    let currentPage = Int(round(contentOffsetX / pageWidth))
    switch currentPage {
    case .likedPhotos:
      updateUserLikedPhotosButtonState()
    case .userHasPhotos:
      updateUserPhotosButtonState()
    default:
      updateUserAlbumsButtonState()
    }
  }
  
  private func updateUserLikedPhotosButtonState() {
    let userLikedIcon = UIImage(systemName: .heartFillIcon)
    userLikedPhotosButton.setImage(userLikedIcon, for: .normal)
    userLikedPhotosButton.alpha = Const.maxOpacity
    userPhotosButton.alpha = Const.defaultOpacity
    userAlbumsButton.alpha = Const.defaultOpacity
    userAlbumsButton.tintColor = .white
  }
  
  private func updateUserPhotosButtonState() {
    let userLikedIcon = UIImage(systemName: .heartIcon)
    userLikedPhotosButton.setImage(userLikedIcon, for: .normal)
    userPhotosButton.alpha = Const.maxOpacity
    userAlbumsButton.alpha = Const.defaultOpacity
    userAlbumsButton.tintColor = .white
  }
  
  private func updateUserAlbumsButtonState() {
    let userLikedIcon = UIImage(systemName: .heartIcon)
    userLikedPhotosButton.setImage(userLikedIcon, for: .normal)
    userPhotosButton.alpha = Const.defaultOpacity
    userAlbumsButton.alpha = Const.maxOpacity
    userAlbumsButton.tintColor = .systemGreen
  }
  
  func setupData(viewModel: any UserProfileViewModelProtocol) {
    guard let viewModelItem = viewModel.getUserProfileViewModelItem() else { return }
    configurePhotos(viewModelItem: viewModelItem)
    configureLabels(viewModelItem: viewModelItem)
    configureButtons(viewModelItem: viewModelItem)
  }
  
  private func configurePhotos(viewModelItem: UserProfileViewModelItem) {
    let backgroundPhotoURL = viewModelItem.photo.regularURL
    let profilePhotoURL = viewModelItem.user.regularURL
    backgroundPhotoView.configure(with: viewModelItem.photo, url: backgroundPhotoURL)
    profilePhotoView.configure(with: viewModelItem.user, url: profilePhotoURL)
  }
  
  private func configureLabels(viewModelItem: UserProfileViewModelItem) {
    nameLabel.text = viewModelItem.displayName
    bioLabel.text = viewModelItem.userBio
    locationLabel.text = viewModelItem.location
    bioLabel.isHidden = viewModelItem.userBio == .empty
    locationStackView.isHidden = viewModelItem.location == .empty ? true : false
  }
  
  private func configureButtons(viewModelItem: UserProfileViewModelItem) {
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
    addSubview(mainView)
    mainView.addSubview(backgroundPhotoView)
    mainView.addSubview(backgroundGradientView)
    mainView.addSubview(horizontalCollectionView)
    mainView.addSubview(mainStackView)
    mainView.addSubview(indicatorView)
    mainView.addSubview(bottomGradientView)
  }
  
  private func setupConstraints() {
    mainView.fillSuperView()
    setupGradientViewConstraints()
    setupMainStackViewConstraints()
    setupIndicatorViewConstraints()
    setupBottomGradientViewConstraints()
    backgroundPhotoConstraints()
    setupUserProfileCollectionViewConstraints()
  }
  
  private func setupGradientViewConstraints() {
    backgroundGradientView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: horizontalCollectionView.topAnchor,
      left: leftAnchor,
      pBottom: Const.backgroundGradientViewBottomPadding
    )
  }
  
  private func setupMainStackViewConstraints() {
    mainStackView.setConstraints(
      right: rightAnchor,
      bottom: backgroundGradientView.bottomAnchor,
      left: leftAnchor,
      pRight: Const.rightPadding,
      pLeft: Const.leftPadding
    )
  }
  
  func setupIndicatorViewConstraints() {
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
  
  private func setupUserProfileCollectionViewConstraints() {
    horizontalCollectionView.setConstraints(
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor
    )
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
  
  private func backgroundPhotoConstraints() {
    backgroundPhotoView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: backgroundGradientView.bottomAnchor,
      left: leftAnchor
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
    horizontalCollectionView.scrollToItem(
      at: indexPath,
      at: .centeredHorizontally,
      animated: true
    )
  }
  
  // MARK: Setup Navigation Items
  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    setupBarButtons()
    setupNavigationItems(navigationItem)
    configBacBarButtonItem(navigationItem, navigationController)
  }
  
  private func setupNavigationItems(_ navigationItem: UINavigationItem) {
    navigationItem.leftBarButtonItems = makeLeftBarButtons()
  }
  
  private func setupBarButtons() {
    backBarButtonBlurEffect.contentView.addSubview(backBarButton)
  }
  
  private func makeLeftBarButtons() -> [UIBarButtonItem] {
    let backBarButton = UIBarButtonItem(customView: backBarButtonBlurEffect)
    let barButtonItems = [backBarButton]
    return barButtonItems
  }
  
  @objc private func backBarButtonTapped() {
    backBarButtonAction?()
  }
  
  func configBacBarButtonItem(
    _ navigationItem: UINavigationItem,
    _ navigationController: UINavigationController?
  ) {
    setupBackButtonAction(navigationController)
    setupBackBarButtonTarget()
  }
  
  private func setupBackButtonAction(_ navigationController: UINavigationController?) {
    backBarButtonAction = { [weak navigationController] in
      navigationController?.popViewController(animated: true)
    }
  }
  
  private func setupBackBarButtonTarget() {
    backBarButton.addTarget(
      self,
      action: #selector(backBarButtonTapped),
      for: .touchUpInside
    )
  }
  
}
