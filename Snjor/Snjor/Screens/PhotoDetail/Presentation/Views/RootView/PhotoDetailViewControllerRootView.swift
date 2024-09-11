//
//  PhotoDetailMainView.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

// swiftlint:disable all
final class PhotoDetailViewControllerRootView: UIView {
  // MARK: - Delegate
  weak var delegate: PhotoDetailRootViewDelegate?
  
  // MARK: Private Properties
  private var isAspectFill = true
  private var isPhotoInfo = true
  private var backBarButtonAction: (() -> Void)?
  private var downloadBarButtonAction: (() -> Void)?
  private var toggleContentModeBarButtonAction: (() -> Void)?
  private var infoButtonAction: (() -> Void)?
  
  // MARK: - Tags Collection View
  let tagsCollectionView: PhotoDetailTagsCollectionView = {
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.tagsCollectionViewHeight
    ).isActive = true
    return $0
  }(PhotoDetailTagsCollectionView())
  
  // MARK: Photo View
  let photoView: PhotoDetailPhotoView = {
    return $0
  }(PhotoDetailPhotoView())
  
  let profilePhotoView: PhotoDetailPhotoView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = PhotoDetailViewControllerRootViewConst.profilePhotoViewCircle
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.profilePhotoViewSize
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.profilePhotoViewSize
    ).isActive = true
    $0.backgroundColor = .systemPurple
    return $0
  }(PhotoDetailPhotoView())
  
  // MARK: Gesture
  private lazy var tapGesture: UITapGestureRecognizer = {
    return $0
  }(
    UITapGestureRecognizer(
      target: self,
      action: #selector(showAndHidePhotoInfo(_:))
    )
  )
  
  @objc private func showAndHidePhotoInfo(_ recognizer: UITapGestureRecognizer) {
    switch recognizer.state {
    case .ended:
      showAndHidePhotoInfo()
    default:
      break
    }
  }
  
  // MARK: Gradient
  private let gradientView: MainGradientView = {
    $0.isUserInteractionEnabled = false
    let color = UIColor(
      white: .zero,
      alpha: PhotoDetailViewControllerRootViewConst.gradientOpacity
    )
    $0.setColors([
      MainGradientView.Color(
        color: .clear,
        location: PhotoDetailViewControllerRootViewConst.gradientEndLocation
      ),
      MainGradientView.Color(
        color: color,
        location: PhotoDetailViewControllerRootViewConst.gradientStartLocation
      )
    ])
    return $0
  }(MainGradientView())
  
  // MARK: Spinner
  lazy var spinner: UIActivityIndicatorView = {
    let xCenter = self.downloadBarButtonBlurEffect.contentView.bounds.midX
    let yCenter = self.downloadBarButtonBlurEffect.contentView.bounds.midY
    $0.center = CGPoint(x: xCenter, y: yCenter)
    $0.startAnimating()
    $0.color = .label
    $0.transform = CGAffineTransform(
      scaleX: PhotoDetailViewControllerRootViewConst.spinnerScale,
      y: PhotoDetailViewControllerRootViewConst.spinnerScale
    )
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    return $0
  }(UIActivityIndicatorView(style: .medium))
  
  // MARK: Blur Effects
  private let backBarButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = PhotoDetailViewControllerRootViewConst.fullValue
    $0.frame.size.height = PhotoDetailViewControllerRootViewConst.fullValue
    $0.layer.cornerRadius = PhotoDetailViewControllerRootViewConst.defaultCircle
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  let downloadBarButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = PhotoDetailViewControllerRootViewConst.downloadButtonWidth
    $0.frame.size.height = PhotoDetailViewControllerRootViewConst.fullValue
    $0.layer.cornerRadius = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  private let toggleContentModePhotoButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = PhotoDetailViewControllerRootViewConst.fullValue
    $0.frame.size.height = PhotoDetailViewControllerRootViewConst.fullValue
    $0.layer.cornerRadius = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  // MARK: Buttons
  private lazy var backBarButton: UIButton = {
    let icon = UIImage(systemName: .backBarButtonImage)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    $0.frame = backBarButtonBlurEffect.bounds
    return $0
  }(UIButton())
  
  lazy var downloadBarButton: UIButton = {
    let icon = UIImage(systemName: .downloadBarButtonImage)
    $0.setImage(icon, for: .normal)
    $0.setTitle(.jpeg, for: .normal)
    $0.titleLabel?.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    $0.frame = downloadBarButtonBlurEffect.bounds
    return $0
  }(UIButton())
  
  private lazy var toggleContentModeButton: UIButton = {
    let icon = UIImage(systemName: .toggleUp)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    $0.frame = toggleContentModePhotoButtonBlurEffect.bounds
    return $0
  }(UIButton())
  
  private let infoButton: UIButton = {
    let icon = UIImage(systemName: .infoButtonImage)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .white
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    
    $0.setContentHuggingPriority(.required, for: .horizontal)
    $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    return $0
  }(UIButton())
  
  // MARK: ImageViews
  private let likesImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .heartImage)
    $0.tintColor = .systemPink
    return $0
  }(UIImageView())
  
  private let downloadsImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .downloadsImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  private let createdImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .calendar)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  private let cameraImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .cameraImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  // MARK: Labels
  let nameLabel: UILabel = {
    $0.textColor = .white
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: .timesNewRomanBold,
      size: PhotoDetailViewControllerRootViewConst.userNameFontSize
    )
    return $0
  }(UILabel())
  
  let likesLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let downloadsLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  private let createdLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  var cameraModelLabel: UILabel = {
    $0.text = .defaultCamera
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .black
    )
    return $0
  }(UILabel())
  
  let resolutionLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    $0.textAlignment = .center
    $0.backgroundColor = .darkGray
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    $0.layer.cornerRadius = PhotoDetailViewControllerRootViewConst.smallValue
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.resolutionLabelWidth
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.resolutionLabelHeight
    ).isActive = true
    return $0
  }(UILabel())
  
  let pxLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    return $0
  }(UILabel())
  
  let isoValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    return $0
  }(UILabel())
  
  private let isoLabel: UILabel = {
    $0.text = .iso
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let apertureValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    return $0
  }(UILabel())
  
  private let apertureLabel: UILabel = {
    $0.text = .aperture
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let focalLengthValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    return $0
  }(UILabel())
  
  private let focalLengthLabel: UILabel = {
    $0.text = .focalLengt
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let exposureTimeValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    return $0
  }(UILabel())
  
  private let exposureTimeLabel: UILabel = {
    $0.text = .exposure
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: PhotoDetailViewControllerRootViewConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  // MARK: Lines
  private let firstLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.lineWidth
    ).isActive = true
    return $0
  }(UIView())
  
  private let secondLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.lineWidth
    ).isActive = true
    return $0
  }(UIView())
  
  private let thirdLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.lineWidth
    ).isActive = true
    return $0
  }(UIView())
  
  private let centerLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    $0.widthAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.lineWidth
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailViewControllerRootViewConst.lineHeight
    ).isActive = true
    return $0
  }(UIView())
  
  // MARK: StackViews
  private lazy var profileAndInfoButtonStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.middleValue
    $0.addArrangedSubview(profilePhotoView)
    $0.addArrangedSubview(nameLabel)
    let spacerView = UIView()
    $0.addArrangedSubview(spacerView)
    $0.addArrangedSubview(infoButton)
    return $0
  }(UIStackView())
  
  private lazy var likesStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(likesImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())
  
  private lazy var downloadStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(downloadsImageView)
    $0.addArrangedSubview(downloadsLabel)
    let spacerView = UIView()
    $0.addArrangedSubview(spacerView)
    return $0
  }(UIStackView())
  
  private lazy var createdStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(createdImageView)
    $0.addArrangedSubview(createdLabel)
    return $0
  }(UIStackView())
  
  private lazy var profitStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.spacing = PhotoDetailViewControllerRootViewConst.profitStackViewSpacing
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    $0.addArrangedSubview(createdStackView)
    return $0
  }(UIStackView())
  
  private lazy var cameraStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(cameraImageView)
    $0.addArrangedSubview(cameraModelLabel)
    let spacerView = UIView()
    $0.addArrangedSubview(spacerView)
    return $0
  }(UIStackView())
  
  private lazy var resolutionStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(resolutionLabel)
    $0.addArrangedSubview(pxLabel)
    return $0
  }(UIStackView())
  
  private lazy var isoStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(isoLabel)
    $0.addArrangedSubview(isoValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var apertureStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(apertureLabel)
    $0.addArrangedSubview(apertureValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var focalLengthStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(focalLengthLabel)
    $0.addArrangedSubview(focalLengthValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var exposureTimeStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(exposureTimeLabel)
    $0.addArrangedSubview(exposureTimeValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var leftStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .fillProportionally
    $0.alignment = .leading
    $0.spacing = PhotoDetailViewControllerRootViewConst.middleValue
    $0.addArrangedSubview(cameraStackView)
    $0.addArrangedSubview(resolutionStackView)
    return $0
  }(UIStackView())
  
  private lazy var rightStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.alignment = .leading
    $0.spacing = PhotoDetailViewControllerRootViewConst.defaultValue
    $0.addArrangedSubview(isoStackView)
    $0.addArrangedSubview(focalLengthStackView)
    $0.addArrangedSubview(apertureStackView)
    $0.addArrangedSubview(exposureTimeStackView)
    return $0
  }(UIStackView())
  
  private lazy var photoInfoStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = PhotoDetailViewControllerRootViewConst.middleValue
    $0.addArrangedSubview(firstLine)
    $0.addArrangedSubview(profitStackView)
    $0.addArrangedSubview(secondLine)
    $0.addArrangedSubview(tagsCollectionView)
    return $0
  }(UIStackView())
  
  private lazy var mainStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = PhotoDetailViewControllerRootViewConst.middleValue
    $0.addArrangedSubview(profileAndInfoButtonStackView)
    $0.addArrangedSubview(photoInfoStackView)
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
    hidePhotoInfo()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Setup Data
  func setupData(viewModel: any PhotoDetailViewModelProtocol) {
    let viewModelItem = viewModel.getPhotoDetailViewModelItem()
    guard let viewModelItem = viewModelItem else { return }
    let photo = viewModelItem.photo
    let regularURL = photo.regularURL
    let profileImageURL = photo.profileImageURL
    photoView.configure(with: photo, url: regularURL)
    profilePhotoView.configure(with: photo, url: profileImageURL)
    nameLabel.text = viewModelItem.displayName
    likesLabel.text = viewModelItem.likes
    createdAt(from: viewModelItem.createdAt)
    resolutionLabel.text = viewModelItem.resolution
    pxLabel.text = viewModelItem.pixels
  }
  
  func setupPhotoInfoData(viewModel: any PhotoDetailViewModelProtocol) {
    let viewModelItem = viewModel.getPhotoDetailViewModelItem()
    guard let viewModelItem = viewModelItem else { return }
    downloadsLabel.text = viewModelItem.downloads
    cameraModelLabel.text = viewModelItem.cameraModel
    isoValueLabel.text = viewModelItem.iso
    focalLengthValueLabel.text = viewModelItem.focalLength
    apertureValueLabel.text = viewModelItem.aperture
    exposureTimeValueLabel.text = viewModelItem.exposureTime
    getTags(viewModelItem)
  }
  
  private func getTags(_ viewModelItem: PhotoDetailViewModelItem) {
    tagsCollectionView.tags = viewModelItem.tags ?? []
    tagsCollectionView.reloadData()
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(photoView)
    addSubview(gradientView)
    addSubview(mainStackView)
    addSubview(leftStackView)
    addSubview(centerLine)
    addSubview(rightStackView)
    photoView.addGestureRecognizer(tapGesture)
  }
  
  private func setupConstraints() {
    gradientView.fillSuperView()
    photoView.fillSuperView()
    setupMainStackViewConstraints()
    setupCenterLineConstraints()
    setupLeftStackViewConstraints()
    setupRightStackViewConstraints()
  }
  
  private func setupMainStackViewConstraints() {
    mainStackView.setConstraints(
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pRight: PhotoDetailViewControllerRootViewConst.rightPadding,
      pBottom: PhotoDetailViewControllerRootViewConst.mainStackViewBottomPadding,
      pLeft: PhotoDetailViewControllerRootViewConst.leftPadding
    )
  }
  
  private func setupCenterLineConstraints() {
    centerLine.centerX()
    centerLine.setConstraints(
      top: mainStackView.topAnchor,
      pTop: PhotoDetailViewControllerRootViewConst.centerLineTopOffset
    )
  }
  
  private func setupLeftStackViewConstraints() {
    leftStackView.setConstraints(
      centerY: mainStackView.centerYAnchor,
      pCenterY: PhotoDetailViewControllerRootViewConst.leftStackViewCenterYOffset
    )
    leftStackView.setConstraints(
      right: centerLine.rightAnchor,
      left: leftAnchor,
      pRight: PhotoDetailViewControllerRootViewConst.smallRightPadding,
      pLeft: PhotoDetailViewControllerRootViewConst.leftPadding
    )
  }
  
  private func setupRightStackViewConstraints() {
    rightStackView.setConstraints(
      centerY: mainStackView.centerYAnchor,
      pCenterY: PhotoDetailViewControllerRootViewConst.rightStackViewCenterYOffset
    )
    rightStackView.setConstraints(
      right: rightAnchor,
      left: centerLine.leftAnchor,
      pRight: PhotoDetailViewControllerRootViewConst.rightPadding,
      pLeft: PhotoDetailViewControllerRootViewConst.leftPadding
    )
  }
  
  // MARK: Setup Navigation Items
  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    setupBarButtons()
    setupNavigationItems(navigationItem)
    configInfoButtonAction()
    configToggleContentModeBarButtonItem(navigationItem)
    configDownloadBarButtonItem(navigationItem)
    configBacBarButtonItem(navigationItem, navigationController)
  }
  
  private func setupNavigationItems(_ navigationItem: UINavigationItem) {
    navigationItem.leftBarButtonItems = makeLeftBarButtons()
    navigationItem.rightBarButtonItems = makeRightBarButtons()
  }
  
  private func setupBarButtons() {
    backBarButtonBlurEffect.contentView.addSubview(backBarButton)
    downloadBarButtonBlurEffect.contentView.addSubview(downloadBarButton)
    toggleContentModePhotoButtonBlurEffect.contentView.addSubview(toggleContentModeButton)
  }
  
  private func makeRightBarButtons() -> [UIBarButtonItem] {
    let downloadBarButton = UIBarButtonItem(customView: downloadBarButtonBlurEffect)
    let toggleContentModeButton = UIBarButtonItem(customView: toggleContentModePhotoButtonBlurEffect)
    let barButtonItems = [toggleContentModeButton, downloadBarButton]
    return barButtonItems
  }
  
  private func makeLeftBarButtons() -> [UIBarButtonItem] {
    let backBarButton = UIBarButtonItem(customView: backBarButtonBlurEffect)
    let barButtonItems = [backBarButton]
    return barButtonItems
  }
  
  @objc private func infoButtonTapped() {
    infoButtonAction?()
  }
  
  private func configInfoButtonAction() {
    setupInfoButtonAction()
    setupInfoButtonTarget()
  }
  
  private func setupInfoButtonAction() {
    infoButtonAction = { [weak self] in
      self?.showAndHidePhotoInfo()
    }
  }
  
  private func setupInfoButtonTarget() {
    infoButton.addTarget(
      self,
      action: #selector(infoButtonTapped),
      for: .touchUpInside
    )
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
  
  private func setupBackBarButton(_ navigationItem: UINavigationItem) {
    let backBarButton = UIBarButtonItem(customView: backBarButtonBlurEffect)
    navigationItem.leftBarButtonItem = backBarButton
  }
  
  @objc private func downloadBarButtonTapped() {
    downloadBarButtonAction?()
  }
  
  func configDownloadBarButtonItem(
    _ navigationItem: UINavigationItem
  ) {
    setupDownloadButtonAction()
    setupDownloadBarButtonTarget()
  }
  
  private func setupDownloadButtonAction() {
    downloadBarButtonAction = { [weak self] in
      self?.animateDownloadButton()
      self?.delegate?.didTapDownloadButton()
    }
  }
  
  private func setupDownloadBarButtonTarget() {
    downloadBarButton.addTarget(
      self,
      action: #selector(downloadBarButtonTapped),
      for: .touchUpInside
    )
  }
  
  private func setupDownloadBarButton(_ navigationItem: UINavigationItem) {
    let downloadButton = UIBarButtonItem(customView: downloadBarButtonBlurEffect)
    navigationItem.rightBarButtonItem = downloadButton
  }
  
  @objc private func toggleContentModeBarButtonTapped() {
    toggleContentModeBarButtonAction?()
  }
  
  func configToggleContentModeBarButtonItem(
    _ navigationItem: UINavigationItem
  ) {
    setupToggleContentModeBarButtonAction()
    setupToggleContentModeBarButtonTarget()
  }
  
  private func setupToggleContentModeBarButtonAction() {
    toggleContentModeBarButtonAction = { [weak self] in
      self?.configToggleContentMode()
    }
  }
  
  private func setupToggleContentModeBarButtonTarget() {
    toggleContentModeButton.addTarget(
      self,
      action: #selector(toggleContentModeBarButtonTapped),
      for: .touchUpInside
    )
  }
  
  private func setupToggleContentModeBarButton(_ navigationItem: UINavigationItem) {
    let toggleContentModeButton = UIBarButtonItem(
      customView: toggleContentModePhotoButtonBlurEffect
    )
    navigationItem.rightBarButtonItem = toggleContentModeButton
  }
  
  private func configToggleContentMode() {
    if self.isAspectFill {
      let icon = UIImage(systemName: .toggleDown)
      photoView.mainImageView.contentMode = .scaleAspectFit
      toggleContentModeButton.setImage(icon, for: .normal)
    } else {
      let icon = UIImage(systemName: .toggleUp)
      photoView.mainImageView.contentMode = .scaleAspectFill
      toggleContentModeButton.setImage(icon, for: .normal)
    }
    self.isAspectFill.toggle()
  }
  
  // MARK: Animate Buttons
  private func animateDownloadButton() {
    UIView.animate(
      withDuration: PhotoDetailViewControllerRootViewConst.minDuration
    ) {
      self.downloadBarButtonBlurEffect.frame.origin.x = PhotoDetailViewControllerRootViewConst.translationX
      self.downloadBarButtonBlurEffect.frame.size.width = PhotoDetailViewControllerRootViewConst.fullValue
      self.downloadBarButtonBlurEffect.frame.size.height = PhotoDetailViewControllerRootViewConst.fullValue
      self.downloadBarButton.alpha = .zero
      self.downloadBarButtonBlurEffect.layer.cornerRadius = PhotoDetailViewControllerRootViewConst.defaultCircle
    } completion: { _ in
      self.downloadBarButton.removeFromSuperview()
      self.downloadBarButtonBlurEffect.contentView.addSubview(self.spinner)
    }
  }
  
  func reverseAnimateDownloadButton() {
    UIView.animate(
      withDuration: PhotoDetailViewControllerRootViewConst.defaultDuration,
      delay: .zero,
      usingSpringWithDamping: PhotoDetailViewControllerRootViewConst.defaultDamping,
      initialSpringVelocity: PhotoDetailViewControllerRootViewConst.defaultVelocity
    ) {
      self.downloadBarButtonBlurEffect.frame.origin.x = -PhotoDetailViewControllerRootViewConst.translationX
      self.downloadBarButtonBlurEffect.frame.size.width = PhotoDetailViewControllerRootViewConst.downloadButtonWidth
      self.downloadBarButtonBlurEffect.frame.size.height = PhotoDetailViewControllerRootViewConst.fullValue
      self.downloadBarButtonBlurEffect.layer.cornerRadius = PhotoDetailViewControllerRootViewConst.defaultValue
      self.spinner.removeFromSuperview()
      self.downloadBarButtonBlurEffect.contentView.addSubview(self.downloadBarButton)
      self.downloadBarButton.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
    }
  }
  
  func hidePhotoInfo() {
    UIView.animate(withDuration: PhotoDetailViewControllerRootViewConst.hidePhotoInfoDuration) {
      let transform = CGAffineTransform(
        translationX: .zero,
        y: PhotoDetailViewControllerRootViewConst.translationY
      )
      self.profileAndInfoButtonStackView.transform = transform
      self.mainStackView.transform = transform
      self.leftStackView.transform = transform
      self.rightStackView.transform = transform
      self.centerLine.transform = transform
      self.photoInfoStackView.alpha = .zero
      self.leftStackView.alpha = .zero
      self.rightStackView.alpha = .zero
      self.centerLine.alpha = .zero
      self.gradientView.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
      self.photoInfoStackView.isHidden = true
    }
  }
  
  private func showPhotoInfo() {
    UIView.animate(
      withDuration: PhotoDetailViewControllerRootViewConst.defaultDuration,
      delay: .zero,
      usingSpringWithDamping: PhotoDetailViewControllerRootViewConst.defaultDamping,
      initialSpringVelocity: PhotoDetailViewControllerRootViewConst.defaultDuration
    ) {
      self.gradientView.alpha = PhotoDetailViewControllerRootViewConst.maxOpacity
      self.photoInfoStackView.alpha = PhotoDetailViewControllerRootViewConst.maxOpacity
      self.leftStackView.alpha = PhotoDetailViewControllerRootViewConst.maxOpacity
      self.rightStackView.alpha = PhotoDetailViewControllerRootViewConst.maxOpacity
      self.centerLine.alpha = PhotoDetailViewControllerRootViewConst.defaultOpacity
      let transform = CGAffineTransform(
        translationX: .zero,
        y: PhotoDetailViewControllerRootViewConst.verticalTranslation
      )
      self.mainStackView.transform = transform
      self.leftStackView.transform = transform
      self.rightStackView.transform = transform
      self.centerLine.transform = transform
      self.photoInfoStackView.isHidden = false
    }
  }
  
  // MARK: Helper
  private func createdAt(from date: String) {
    guard let date = ISO8601DateFormatter().date(from: date) else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    let readableDate = dateFormatter.string(from: date)
    createdLabel.text = readableDate
  }
  
  private func showAndHidePhotoInfo() {
    isPhotoInfo ? showPhotoInfo() : hidePhotoInfo()
    isPhotoInfo.toggle()
  }
}
