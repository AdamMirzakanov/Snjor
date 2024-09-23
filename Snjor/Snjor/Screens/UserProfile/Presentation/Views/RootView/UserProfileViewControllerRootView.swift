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
  private var portfolioBarButtonAction: (() -> Void)?
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
  private let avatarMulticolorBackgroundView: UIImageView = {
    $0.image = UIImage(named: .avatarBackgroundImage)
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = Const.avatarMulticolorBackgroundViewCircle
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.avatarMulticolorBackgroundViewSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.avatarMulticolorBackgroundViewSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let avatarBlackBackgroundView: UIView = {
    $0.backgroundColor = .black
    $0.layer.cornerRadius = Const.avatarBlackBackgroundViewCircle
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.avatarBlackBackgroundViewSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.avatarBlackBackgroundViewSize
    ).isActive = true
    return $0
  }(UIView())
  
  private let avatarView: UserProfilePhotoView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = Const.avatarCircle
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.avatarSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.avatarSize
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
  
  private let portfolioBarButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = Const.fullValue
    $0.frame.size.height = Const.fullValue
    $0.layer.cornerRadius = Const.defaultValue
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
  
  private let noLikedImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .heartCircleIcon)
    $0.tintColor = .systemPink
    $0.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let noPhotoImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .photoCircleIcon)
    $0.tintColor = .systemOrange
    $0.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let noAlbumImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .macroCircleIcon)
    $0.tintColor = .systemGreen
    $0.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
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
  
  private lazy var portfolioBarButton: UIButton = {
    let icon = UIImage(systemName: .globeEuropeAfricaFillIcon)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.alpha = Const.defaultOpacity
    $0.frame = portfolioBarButtonBlurEffect.bounds
    return $0
  }(UIButton(type: .system))
  
  let userLikedPhotosButton: UIButton = {
    let icon = UIImage(systemName: .heartFillIcon)
    $0.setImage(icon, for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.tintColor = .systemPink
    $0.imageView?.contentMode = .scaleAspectFit
    return $0
  }(UIButton(type: .system))
  
  let userPhotosButton: UIButton = {
    let icon = UIImage(systemName: .photoIcon)
    $0.setImage(icon, for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.tintColor = .white
    $0.imageView?.contentMode = .scaleAspectFit
    return $0
  }(UIButton(type: .system))
  
  let userAlbumsButton: UIButton = {
    let icon = UIImage(systemName: .macroIcon)
    $0.setImage(icon, for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.imageView?.contentMode = .scaleAspectFit
    $0.tintColor = .white
    return $0
  }(UIButton(type: .system))
  
  // MARK: Labels
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
  
  private let nameLabel: UILabel = {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: .impact,
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
  lazy var noLikedPhotosStackView: UIStackView = {
    $0.alpha = Const.bigIconOpacity
    $0.isUserInteractionEnabled = false
    $0.isHidden = true
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(noLikedImageView)
    $0.addArrangedSubview(noLikedPhotosLabel)
    return $0
  }(UIStackView())
  
  lazy var noPhotosStackView: UIStackView = {
    $0.alpha = Const.bigIconOpacity
    $0.isUserInteractionEnabled = false
    $0.isHidden = true
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(noPhotoImageView)
    $0.addArrangedSubview(noPhotosLabel)
    return $0
  }(UIStackView())
  
  lazy var noAlbumsStackView: UIStackView = {
    $0.alpha = Const.bigIconOpacity
    $0.isUserInteractionEnabled = false
    $0.isHidden = true
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(noAlbumImageView)
    $0.addArrangedSubview(noAlbumsLabel)
    return $0
  }(UIStackView())
  
  private lazy var avatarAndNameLabelStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(avatarMulticolorBackgroundView)
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
    return $0
  }(UIStackView())
  
  private lazy var userInfoStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(avatarAndNameLabelStackView)
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
    $0.addArrangedSubview(horizontalCollectionView)
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
    case .userPhotos:
      updateUserPhotosButtonState()
    default:
      updateUserAlbumsButtonState()
    }
  }
  
  private func updateUserLikedPhotosButtonState() {
    let userLikedIcon = UIImage(systemName: .heartFillIcon)
    userLikedPhotosButton.setImage(userLikedIcon, for: .normal)
    
    let userPhotosIcon = UIImage(systemName: .photoIcon)
    userPhotosButton.setImage(userPhotosIcon, for: .normal)
    
    userAlbumsButton.tintColor = .white
  }
  
  private func updateUserPhotosButtonState() {
    let userLikedIcon = UIImage(systemName: .heartIcon)
    userLikedPhotosButton.setImage(userLikedIcon, for: .normal)
    
    let userPhotosIcon = UIImage(systemName: .photoFillIcon)
    userPhotosButton.setImage(userPhotosIcon, for: .normal)
    
    userAlbumsButton.tintColor = .white
  }
  
  private func updateUserAlbumsButtonState() {
    let userLikedIcon = UIImage(systemName: .heartIcon)
    userLikedPhotosButton.setImage(userLikedIcon, for: .normal)
    
    let userPhotosIcon = UIImage(systemName: .photoIcon)
    userPhotosButton.setImage(userPhotosIcon, for: .normal)
    
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
    avatarView.configure(with: viewModelItem.user, url: profilePhotoURL)
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
    let userPhotos = .spacer + viewModelItem.totalPhotos
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
    mainView.addSubview(mainStackView)
    mainView.addSubview(indicatorView)
    mainView.addSubview(bottomGradientView)
    horizontalCollectionView.addSubview(noLikedPhotosStackView)
    horizontalCollectionView.addSubview(noPhotosStackView)
    horizontalCollectionView.addSubview(noAlbumsStackView)
    mainView.addSubview(avatarView)
    avatarMulticolorBackgroundView.addSubview(avatarBlackBackgroundView)
    avatarBlackBackgroundView.addSubview(avatarView)
  }
  
  private func setupConstraints() {
    mainView.fillSuperView()
    setupGradientViewConstraints()
    setupMainStackViewConstraints()
    setupIndicatorViewConstraints()
    setupBottomGradientViewConstraints()
    backgroundPhotoConstraints()
    noLikesStackViewConstraints()
    noPhotosStackViewConstraints()
    noAlbumsStackViewConstraints()
    setupAvatarViewConstraints()
    setupAvatarBlackBackgroundViewConstraints()
    
  }
  
  private func setupAvatarBlackBackgroundViewConstraints() {
    avatarBlackBackgroundView.centerXY()
  }
  
  private func setupAvatarViewConstraints() {
    avatarView.centerXY()
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
      bottom: bottomAnchor,
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
  
  private func noLikesStackViewConstraints() {
    noLikedPhotosStackView.setConstraints(
      centerY: horizontalCollectionView.centerYAnchor,
      centerX: horizontalCollectionView.centerXAnchor,
      pCenterY: Const.stackViewCenterYOffset
    )
  }
  
  private func noPhotosStackViewConstraints() {
    noPhotosStackView.setConstraints(
      centerY: horizontalCollectionView.centerYAnchor,
      centerX: horizontalCollectionView.centerXAnchor,
      pCenterY: Const.stackViewCenterYOffset
    )
  }
  
  private func noAlbumsStackViewConstraints() {
    noAlbumsStackView.setConstraints(
      centerY: horizontalCollectionView.centerYAnchor,
      centerX: horizontalCollectionView.centerXAnchor,
      pCenterY: Const.stackViewCenterYOffset
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
    animateButton(sender)
  }
  
  // MARK: Setup Navigation Items
  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    setupBarButtons()
    setupNavigationItems(navigationItem)
    configBacBarButtonItem(navigationItem, navigationController)
    configPortfolioBarButtonItem(navigationItem, navigationController)
  }
  
  private func setupNavigationItems(_ navigationItem: UINavigationItem) {
    navigationItem.leftBarButtonItems = makeLeftBarButtons()
    navigationItem.rightBarButtonItems = makeRightBarButtons()
  }
  
  private func setupBarButtons() {
    backBarButtonBlurEffect.contentView.addSubview(backBarButton)
    portfolioBarButtonBlurEffect.contentView.addSubview(portfolioBarButton)
  }
  
  private func makeLeftBarButtons() -> [UIBarButtonItem] {
    let backBarButton = UIBarButtonItem(customView: backBarButtonBlurEffect)
    let barButtonItems = [backBarButton]
    return barButtonItems
  }
  
  private func makeRightBarButtons() -> [UIBarButtonItem] {
    let portfolioBarButton = UIBarButtonItem(customView: portfolioBarButtonBlurEffect)
    let barButtonItems = [portfolioBarButton]
    return barButtonItems
  }
  
  @objc private func backBarButtonTapped() {
    backBarButtonAction?()
  }
  
  @objc private func portfolioBarButtonTapped() {
    portfolioBarButtonAction?()
  }
  
  func configBacBarButtonItem(
    _ navigationItem: UINavigationItem,
    _ navigationController: UINavigationController?
  ) {
    setupBackButtonAction(navigationController)
    setupBackBarButtonTarget()
  }
  
  func configPortfolioBarButtonItem(
    _ navigationItem: UINavigationItem,
    _ navigationController: UINavigationController?
  ) {
    setupPortfolioButtonAction(navigationController)
    setupPortfolioButtonTarget()
  }
  
  private func setupBackButtonAction(_ navigationController: UINavigationController?) {
    backBarButtonAction = { [weak navigationController] in
      navigationController?.popViewController(animated: true)
    }
  }
  
  private func setupPortfolioButtonAction(_ navigationController: UINavigationController?) {
    portfolioBarButtonAction = { [weak navigationController] in
      navigationController?.popViewController(animated: true)
      print("FYUGIHOJPIJHUGY")
    }
  }
  
  private func setupBackBarButtonTarget() {
    backBarButton.addTarget(
      self,
      action: #selector(backBarButtonTapped),
      for: .touchUpInside
    )
  }
  
  private func setupPortfolioButtonTarget() {
    portfolioBarButton.addTarget(
      self,
      action: #selector(portfolioBarButtonTapped),
      for: .touchUpInside
    )
  }
  
  // MARK: Animate Tab Buttons
  private func animateButton(_ sender: UIButton) {
    UIView.animate(withDuration: Const.duration) {
      let scaleTransform = CGAffineTransform(
        scaleX: Const.pressingScale,
        y: Const.pressingScale
      )
      sender.transform = scaleTransform
    } completion: { _ in
      UIView.animate(withDuration: Const.duration) {
        sender.transform = .identity
      }
    }
  }
}
