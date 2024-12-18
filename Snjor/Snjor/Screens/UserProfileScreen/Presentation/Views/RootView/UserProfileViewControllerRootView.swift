//
//  UserProfileViewControllerRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 10.09.2024.
//

import UIKit
import SafariServices

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class UserProfileViewControllerRootView: UIView {
  // MARK: Internal Properties
  var portfolioURL: URL?
  
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
  let mainView: UIView = {
    $0.backgroundColor = .black
    return $0
  }(UIView())
  
  // MARK: Collectin View
  lazy var horizontalCollectionView: UserProfileCollectionView = {
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
  
  // MARK: Avatar
  private let avatarView: AvatarPhotoView = {
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
  }(AvatarPhotoView())
  
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
  private let avatarMulticolorBackgroundImageView: UIImageView = {
    $0.image = SFSymbol.avatarBackgroundImage
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
  
  private let checkmarkIconBackgroundView: UIView = {
    $0.backgroundColor = .white
    $0.widthAnchor.constraint(
      equalToConstant: Const.checkmarkIconBackgroundViewSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.checkmarkIconBackgroundViewSize
    ).isActive = true
    return $0
  }(UIView())
  
  private let checkmarkIconImageView: UIImageView = {
    $0.image = SFSymbol.checkmarkIcon
    $0.tintColor = .systemBlue
    $0.contentMode = .scaleAspectFill
    $0.widthAnchor.constraint(
      equalToConstant: Const.checkmarkIconSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.checkmarkIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let locationImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.locationIcon
    $0.tintColor = .white
    $0.heightAnchor.constraint(
      equalToConstant: Const.loacationIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.loacationIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  // MARK: Buttons
  private lazy var backBarButton: UIButton = {
    let icon = SFSymbol.backBarButtonIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.alpha = Const.defaultOpacity
    $0.frame = backBarButtonBlurEffect.bounds
    return $0
  }(UIButton())
  
  private lazy var portfolioBarButton: UIButton = {
    let icon = SFSymbol.portfolioIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.alpha = Const.defaultOpacity
    $0.frame = portfolioBarButtonBlurEffect.bounds
    return $0
  }(UIButton(type: .system))
  
  private let userLikedPhotosButton: UIButton = {
    let icon = SFSymbol.heartFillIcon
    $0.setImage(icon, for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.tintColor = .systemPink
    $0.imageView?.contentMode = .scaleAspectFit
    return $0
  }(UIButton(type: .system))
  
  private let userPhotosButton: UIButton = {
    let icon = SFSymbol.photoAngledIcon
    $0.setImage(icon, for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.tintColor = .white
    $0.imageView?.contentMode = .scaleAspectFit
    return $0
  }(UIButton(type: .system))
  
  private let userAlbumsButton: UIButton = {
    let icon = SFSymbol.macroIcon
    $0.setImage(icon, for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.imageView?.contentMode = .scaleAspectFit
    $0.tintColor = .white
    return $0
  }(UIButton(type: .system))
  
  // MARK: Labels
  private let userNameLabel: UILabel = {
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
  private lazy var userNameAndCheckmarkIconStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.middleStackViewSpacing
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(userNameLabel)
    $0.addArrangedSubview(checkmarkIconBackgroundView)
    return $0
  }(UIStackView())
  
  private lazy var avatarAndNameLabelStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(avatarMulticolorBackgroundImageView)
    $0.addArrangedSubview(userNameAndCheckmarkIconStackView)
    $0.addArrangedSubview(locationStackView)
    return $0
  }(UIStackView())
  
  private lazy var locationStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.locationStackViewSpacing
    $0.addArrangedSubview(locationImageView)
    $0.addArrangedSubview(locationLabel)
    $0.addArrangedSubview(UIView())
    $0.isHidden = true
    $0.alpha = Const.middleOpacity
    return $0
  }(UIStackView())
  
  private lazy var iconsStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.spacing = .zero
    $0.heightAnchor.constraint(
      equalToConstant: Const.userInfoStackViewHeight
    ).isActive = true
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
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Setup Data
  /// Обновляет состояния кнопок в зависимости от текущей
  /// видимой страницы в `horizontalCollectionView`.
  ///
  /// - Parameter viewModel: Модель представления,
  /// соответствующая протоколу `UserProfileViewModelProtocol`.
  func updateButtonStatesForVisiblePage(
    for viewModel: any UserProfileViewModelProtocol
  ) {
    // Получаем ширину страницы и текущую позицию прокрутки по оси X.
    let pageWidth = horizontalCollectionView.bounds.size.width
    let contentOffsetX = horizontalCollectionView.contentOffset.x
    
    // Вычисляем текущую страницу, округляя значение смещения по ширине страницы.
    let currentPage = Int(round(contentOffsetX / pageWidth))
    
    // Изменяем состояние кнопок на основе текущей страницы.
    switch currentPage {
    case .likedPhotos:
      updateUserLikedPhotosButtonState()
    case .userPhotos:
      updateUserPhotosButtonState()
    default:
      updateUserAlbumsButtonState()
    }
  }
  
  /// Обновляет состояние кнопки, отображающей понравившиеся пользователю фотографии.
  /// В зависимости от текущего цвета кнопки (серый или нет), изменяет иконку и цвет других кнопок,
  /// чтобы отобразить актуальное состояние раздела "Понравившиеся".
  private func updateUserLikedPhotosButtonState() {
    if userLikedPhotosButton.tintColor == .systemGray {
      let userLikedSlashIcon = SFSymbol.heartSlashFillIcon
      userLikedPhotosButton.setImage(userLikedSlashIcon, for: .normal)
    } else {
      let userLikedIcon = SFSymbol.heartFillIcon
      userLikedPhotosButton.setImage(userLikedIcon, for: .normal)
    }
    
    let userPhotosIcon = SFSymbol.photoAngledIcon
    userPhotosButton.setImage(userPhotosIcon, for: .normal)
    
    // Обновляет цвет кнопок "Альбомы" и "Фото" в зависимости от текущего цвета
    userAlbumsButton.tintColor = userAlbumsButton.tintColor == .systemGray ? .systemGray : .white
    userPhotosButton.tintColor = userPhotosButton.tintColor == .systemGray ? .systemGray : .white
  }
  
  /// Обновляет состояние кнопки, отображающей личные фотографии пользователя.
  /// В зависимости от текущего цвета кнопки "Понравившиеся", изменяет иконку и цвет других кнопок,
  /// чтобы отобразить активное состояние раздела "Фотографии".
  private func updateUserPhotosButtonState() {
    if userLikedPhotosButton.tintColor == .systemGray {
      let userLikedSlashIcon = SFSymbol.heartSlashIcon
      userLikedPhotosButton.setImage(userLikedSlashIcon, for: .normal)
    } else {
      let userLikedIcon = SFSymbol.heartIcon
      userLikedPhotosButton.setImage(userLikedIcon, for: .normal)
    }
    
    let userPhotosIcon = SFSymbol.photoAngledFillIcon
    userPhotosButton.setImage(userPhotosIcon, for: .normal)
    
    // Обновляет цвет кнопок "Альбомы" и "Фото" в зависимости от текущего цвета
    userAlbumsButton.tintColor = userAlbumsButton.tintColor == .systemGray ? .systemGray : .white
    userPhotosButton.tintColor = userPhotosButton.tintColor == .systemGray ? .systemGray : .white
  }
  
  /// Обновляет состояние кнопки, отображающей альбомы пользователя.
  /// Изменяет иконки и цвета других кнопок в соответствии с текущим активным разделом "Альбомы".
  private func updateUserAlbumsButtonState() {
    if userLikedPhotosButton.tintColor == .systemGray {
      let userLikedSlashIcon = SFSymbol.heartSlashIcon
      userLikedPhotosButton.setImage(userLikedSlashIcon, for: .normal)
    } else {
      let userLikedIcon = SFSymbol.heartIcon
      userLikedPhotosButton.setImage(userLikedIcon, for: .normal)
    }
    
    let userPhotosIcon = SFSymbol.photoAngledIcon
    userPhotosButton.setImage(userPhotosIcon, for: .normal)
    
    // Устанавливает цвет кнопок "Альбомы" и "Фото" в зависимости от текущего активного состояния
    userAlbumsButton.tintColor = userAlbumsButton.tintColor == .systemGray ? .systemGray : .systemGreen
    userPhotosButton.tintColor = userPhotosButton.tintColor == .systemGray ? .systemGray : .white
  }
  
  func setupData(viewModel: any UserProfileViewModelProtocol) {
    guard let viewModelItem = viewModel.getUserProfileViewModelItem() else { return }
    configurePhotos(viewModelItem: viewModelItem)
    configureLabels(viewModelItem: viewModelItem)
    configureButtons(viewModelItem: viewModelItem)
    configurePorfolioButton(viewModelItem: viewModelItem)
  }
  
  private func configurePhotos(viewModelItem: UserProfileViewModelItem) {
    let backgroundPhotoURL = viewModelItem.photo.regularURL
    let profilePhotoURL = viewModelItem.user.regularURL
    backgroundPhotoView.configure(with: viewModelItem.photo, url: backgroundPhotoURL)
    avatarView.configure(with: viewModelItem.user, url: profilePhotoURL)
  }
  
  private func configureLabels(viewModelItem: UserProfileViewModelItem) {
    userNameLabel.text = viewModelItem.displayName
    bioLabel.text = viewModelItem.userBio
    locationLabel.text = viewModelItem.location
    bioLabel.isHidden = viewModelItem.userBio == .empty
    locationStackView.isHidden = viewModelItem.location == .empty ? true : false
  }
  
  private func configurePorfolioButton(viewModelItem: UserProfileViewModelItem) {
    if viewModelItem.user.social?.portfolioUrl != nil {
      let icon = SFSymbol.portfolioIcon
      portfolioBarButton.setImage(icon, for: .normal)
    } else {
      let icon = SFSymbol.noPortfolioIcon
      portfolioBarButton.setImage(icon, for: .normal)
      portfolioBarButton.isEnabled = false
    }
  }
  
  private func configureButtons(viewModelItem: UserProfileViewModelItem) {
    let userLikedPhotos = .spacer + viewModelItem.totalLikes
    let userPhotos = .spacer + viewModelItem.totalPhotos
    let userAlbums = .spacer + viewModelItem.totalCollections
    
    if viewModelItem.user.totalLikes == .zero {
      userLikedPhotosButton.setTitle(.empty, for: .normal)
      userLikedPhotosButton.tintColor = .systemGray
      let heartSlashFillIcon = SFSymbol.heartSlashFillIcon
      userLikedPhotosButton.setImage(heartSlashFillIcon, for: .normal)
    } else {
      userLikedPhotosButton.setTitle(userLikedPhotos, for: .normal)
    }
    
    if viewModelItem.user.totalPhotos == .zero {
      userPhotosButton.setTitle(.empty, for: .normal)
      userPhotosButton.tintColor = .systemGray
    } else {
      userPhotosButton.setTitle(userPhotos, for: .normal)
    }
    
    if viewModelItem.user.totalCollections == .zero {
      userAlbumsButton.setTitle(.empty, for: .normal)
      userAlbumsButton.tintColor = .systemGray
      let macroSlashIcon = SFSymbol.macroSlashIcon
      userAlbumsButton.setImage(macroSlashIcon, for: .normal)
    } else {
      userAlbumsButton.setTitle(userAlbums, for: .normal)
    }
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
    mainView.addSubview(avatarView)
    avatarMulticolorBackgroundImageView.addSubview(avatarView)
    checkmarkIconBackgroundView.addSubview(checkmarkIconImageView)
  }
  
  private func setupConstraints() {
    mainView.fillSuperView()
    setupGradientViewConstraints()
    setupMainStackViewConstraints()
    setupIndicatorViewConstraints()
    setupBottomGradientViewConstraints()
    setupBackgroundPhotoConstraints()
    setupAvatarViewConstraints()
    setupAvatarBlackBackgroundViewConstraints()
    setupCheckmarkIconImageViewConstraints()
  }
  
  private func setupCheckmarkIconImageViewConstraints() {
    checkmarkIconImageView.setConstraints(
      centerY: checkmarkIconBackgroundView.centerYAnchor,
      centerX: checkmarkIconBackgroundView.centerXAnchor
    )
  }
  
  private func setupAvatarBlackBackgroundViewConstraints() {
    avatarView.centerXY()
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
      constant: Const.indicatorBaseHeight / traitCollection.displayScale
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
  
  private func setupBackgroundPhotoConstraints() {
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
  
  private func setupBackButtonAction(
    _ navigationController: UINavigationController?
  ) {
    backBarButtonAction = { [weak navigationController] in
      navigationController?.popViewController(animated: true)
    }
  }
  
  private func setupPortfolioButtonAction(
    _ navigationController: UINavigationController?
  ) {
    portfolioBarButtonAction = { [weak navigationController] in
      guard let url = self.portfolioURL else { return }
      let safariViewController = SFSafariViewController(url: url)
      navigationController?.present(safariViewController, animated: true)
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
