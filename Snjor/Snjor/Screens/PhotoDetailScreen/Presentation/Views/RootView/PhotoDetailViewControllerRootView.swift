//
//  PhotoDetailMainView.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

fileprivate typealias Const = PhotoDetailViewControllerRootViewConst

// swiftlint:disable all
final class PhotoDetailViewControllerRootView: BaseView {
  // MARK: Delegate
  weak var delegate: PhotoDetailRootViewDelegate?
  
  // MARK: Private Properties
  private var isAspectFill = true
  private var isPhotoInfo = true
  private var backBarButtonAction: (() -> Void)?
  private var downloadBarButtonAction: (() -> Void)?
  private var toggleContentModeBarButtonAction: (() -> Void)?
  private var shareBarButtonAction: (() -> Void)?
  private var infoButtonAction: (() -> Void)?
  
  // MARK: Container View
  let mainView: UIView = {
    $0.backgroundColor = .black
    return $0
  }(UIView())
  
  // MARK: Tags Collection View
  let tagsCollectionView: PhotoDetailTagsCollectionView = {
    $0.heightAnchor.constraint(
      equalToConstant: Const.tagsCollectionViewHeight
    ).isActive = true
    return $0
  }(PhotoDetailTagsCollectionView())
  
  // MARK: Photo View
  let photoView: PhotoDetailPhotoView = {
    return $0
  }(PhotoDetailPhotoView())
  
  let avatarView: UserProfilePhotoView = {
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
  
  // MARK: Gesture
  private lazy var showAndHidePhotoInfoTapGesture: UITapGestureRecognizer = {
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
  
  private func showAndHidePhotoInfo() {
    isPhotoInfo ? showPhotoInfo() : hidePhotoInfo()
    isPhotoInfo.toggle()
  }
  
  private lazy var openProfileTapGesture: UITapGestureRecognizer = {
    return $0
  }(
    UITapGestureRecognizer(
      target: self,
      action: #selector(openProfile(_:))
    )
  )
  
  @objc private func openProfile(_ recognizer: UITapGestureRecognizer) {
    switch recognizer.state {
    case .ended:
      delegate?.didTapAvatar()
    default:
      break
    }
  }
  
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
  
  // MARK: Spinner
  lazy var spinner: UIActivityIndicatorView = {
    let xCenter = self.downloadBarButtonBlurEffect.contentView.bounds.midX
    let yCenter = self.downloadBarButtonBlurEffect.contentView.bounds.midY
    $0.center = CGPoint(x: xCenter, y: yCenter)
    $0.startAnimating()
    $0.color = .label
    $0.transform = CGAffineTransform(
      scaleX: Const.spinnerScale,
      y: Const.spinnerScale
    )
    $0.alpha = Const.defaultOpacity
    return $0
  }(UIActivityIndicatorView(style: .medium))
  
  // MARK: Blur Effects
  private let backBarButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = Const.fullValue
    $0.frame.size.height = Const.fullValue
    $0.layer.cornerRadius = Const.barButtonCircle
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  let downloadBarButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = Const.downloadButtonWidth
    $0.frame.size.height = Const.fullValue
    $0.layer.cornerRadius = Const.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  private let toggleContentModePhotoButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = Const.fullValue
    $0.frame.size.height = Const.fullValue
    $0.layer.cornerRadius = Const.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  private let shareButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = Const.fullValue
    $0.frame.size.height = Const.fullValue
    $0.layer.cornerRadius = Const.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
   
  // MARK: Buttons
  private lazy var backBarButton: UIButton = {
    let icon = SFSymbol.backBarButtonIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.alpha = Const.defaultOpacity
    $0.frame = backBarButtonBlurEffect.bounds
    return $0
  }(UIButton())
  
  private lazy var shareBarButton: UIButton = {
    let icon = SFSymbol.shareBarButtonIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.alpha = Const.defaultOpacity
    $0.frame = shareButtonBlurEffect.bounds
    return $0
  }(UIButton(type: .system))
  
  lazy var downloadBarButton: UIButton = {
    let icon = SFSymbol.downloadBarButtonIcon
    $0.setImage(icon, for: .normal)
    $0.setTitle(.jpeg, for: .normal)
    $0.titleLabel?.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = Const.defaultOpacity
    $0.frame = downloadBarButtonBlurEffect.bounds
    return $0
  }(UIButton())
  
  private lazy var toggleContentModeButton: UIButton = {
    let icon = SFSymbol.toggleUpIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = Const.defaultOpacity
    $0.frame = toggleContentModePhotoButtonBlurEffect.bounds
    return $0
  }(UIButton())
  
  private let infoButton: UIButton = {
    let icon = SFSymbol.infoButtonIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .white
    $0.alpha = Const.defaultOpacity
    
    $0.setContentHuggingPriority(.required, for: .horizontal)
    $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    return $0
  }(UIButton())
  
  // MARK: ImageViews
  private let likesImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.suitHeartIcon
    $0.tintColor = .systemPink
    $0.heightAnchor.constraint(
      equalToConstant: Const.iconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.iconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let downloadsImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.downloadsIcon
    $0.tintColor = .white
    $0.heightAnchor.constraint(
      equalToConstant: Const.iconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.iconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let createdImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.calendarIcon
    $0.tintColor = .white
    $0.heightAnchor.constraint(
      equalToConstant: Const.iconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.iconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let cameraImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.cameraIcon
    $0.tintColor = .white
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
  
  // MARK: Labels
  let userNameLabel: UILabel = {
    $0.textColor = .white
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: .timesNewRomanBold,
      size: Const.userNameFontSize
    )
    return $0
  }(UILabel())
  
  let likesLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let downloadsLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  private let createdLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  var cameraModelLabel: UILabel = {
    $0.text = .defaultCamera
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .black
    )
    return $0
  }(UILabel())
  
  let resolutionLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    $0.textAlignment = .center
    $0.backgroundColor = .darkGray
    $0.alpha = Const.defaultOpacity
    $0.layer.cornerRadius = Const.resolutionLabelFrameCornerRadius
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.resolutionLabelWidth
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.resolutionLabelHeight
    ).isActive = true
    return $0
  }(UILabel())
  
  let pxLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    $0.alpha = Const.defaultOpacity
    return $0
  }(UILabel())
  
  let isoValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    $0.alpha = Const.defaultOpacity
    return $0
  }(UILabel())
  
  private let isoLabel: UILabel = {
    $0.text = .iso
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let apertureValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    $0.alpha = Const.defaultOpacity
    return $0
  }(UILabel())
  
  private let apertureLabel: UILabel = {
    $0.text = .aperture
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let focalLengthValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    $0.alpha = Const.defaultOpacity
    return $0
  }(UILabel())
  
  private let focalLengthLabel: UILabel = {
    $0.text = .focalLengt
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  let exposureTimeValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
    )
    $0.alpha = Const.defaultOpacity
    return $0
  }(UILabel())
  
  private let exposureTimeLabel: UILabel = {
    $0.text = .exposure
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.defaultFontSize,
      weight: .medium
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
  
  private let thirdLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = Const.defaultOpacity
    $0.heightAnchor.constraint(
      equalToConstant: Const.lineWidth
    ).isActive = true
    return $0
  }(UIView())
  
  private let centerLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = Const.defaultOpacity
    $0.widthAnchor.constraint(
      equalToConstant: Const.lineWidth
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.lineHeight
    ).isActive = true
    return $0
  }(UIView())
  
  // MARK: StackViews
  private lazy var userNameLabelAndCheckmarkIconStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.middleStackViewSpacing
    $0.addArrangedSubview(userNameLabel)
    $0.addArrangedSubview(checkmarkIconBackgroundView)
    return $0
  }(UIStackView())
  
  private lazy var locationStackView: UIStackView = {
    $0.isHidden = true
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.locationStackViewSpacing
    $0.addArrangedSubview(locationImageView)
    $0.addArrangedSubview(locationLabel)
    $0.alpha = Const.middleOpacity
    return $0
  }(UIStackView())
  
  private lazy var userNameLabelAndCheckmarkIconAndLocationStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .leading
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(userNameLabelAndCheckmarkIconStackView)
    $0.addArrangedSubview(locationStackView)
    return $0
  }(UIStackView())
  
  private lazy var avatarAndUserNameLabelStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.middleValue
    $0.addArrangedSubview(avatarView)
    $0.addArrangedSubview(userNameLabelAndCheckmarkIconAndLocationStackView)
    return $0
  }(UIStackView())
  
  private lazy var profileAndInfoButtonStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.middleValue
    $0.addArrangedSubview(avatarAndUserNameLabelStackView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(infoButton)
    return $0
  }(UIStackView())
  
  private lazy var likesStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(likesImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())
  
  private lazy var downloadStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.defaultValue
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
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(createdImageView)
    $0.addArrangedSubview(createdLabel)
    return $0
  }(UIStackView())
  
  private lazy var profitStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.spacing = Const.profitStackViewSpacing
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    $0.addArrangedSubview(createdStackView)
    return $0
  }(UIStackView())
  
  private lazy var cameraStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.defaultValue
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
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(resolutionLabel)
    $0.addArrangedSubview(pxLabel)
    return $0
  }(UIStackView())
  
  private lazy var isoStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(isoLabel)
    $0.addArrangedSubview(isoValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var apertureStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(apertureLabel)
    $0.addArrangedSubview(apertureValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var focalLengthStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(focalLengthLabel)
    $0.addArrangedSubview(focalLengthValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var exposureTimeStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(exposureTimeLabel)
    $0.addArrangedSubview(exposureTimeValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var leftStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .fillProportionally
    $0.alignment = .leading
    $0.spacing = Const.middleValue
    $0.addArrangedSubview(cameraStackView)
    $0.addArrangedSubview(resolutionStackView)
    return $0
  }(UIStackView())
  
  private lazy var rightStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.alignment = .leading
    $0.spacing = Const.defaultValue
    $0.addArrangedSubview(isoStackView)
    $0.addArrangedSubview(focalLengthStackView)
    $0.addArrangedSubview(apertureStackView)
    $0.addArrangedSubview(exposureTimeStackView)
    return $0
  }(UIStackView())
  
  private lazy var photoInfoStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = Const.middleValue
    $0.addArrangedSubview(firstLine)
    $0.addArrangedSubview(profitStackView)
    $0.addArrangedSubview(secondLine)
    $0.addArrangedSubview(tagsCollectionView)
    return $0
  }(UIStackView())
  
  private lazy var mainStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = Const.middleValue
    $0.addArrangedSubview(profileAndInfoButtonStackView)
    $0.addArrangedSubview(photoInfoStackView)
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  override func initViews() {
    setupViews()
    hidePhotoInfo()
    setupGestureRecognizers()
  }
  
  // MARK: Setup Data
  func setupData(viewModel: any PhotoDetailViewModelProtocol) {
    let viewModelItem = viewModel.getPhotoDetailViewModelItem()
    guard let viewModelItem = viewModelItem else { return }
    let photo = viewModelItem.photo
    let regularURL = photo.regularURL
    let profileImageURL = photo.profileImageURL
    photoView.configure(with: photo, url: regularURL)
    avatarView.configure(with: photo, url: profileImageURL)
    userNameLabel.text = viewModelItem.displayName
    setupLikes(viewModelItem: viewModelItem)
    createdAt(from: viewModelItem.createdAt)
    resolutionLabel.text = viewModelItem.resolution
    pxLabel.text = viewModelItem.pixels
  }
  
  func setupPhotoInfoData(viewModel: any PhotoDetailViewModelProtocol) {
    guard let viewModelItem = viewModel.getPhotoDetailViewModelItem() else { return }
    cameraModelLabel.text = viewModelItem.cameraModel
    isoValueLabel.text = viewModelItem.iso
    focalLengthValueLabel.text = viewModelItem.focalLength
    apertureValueLabel.text = viewModelItem.aperture
    exposureTimeValueLabel.text = viewModelItem.exposureTime
    setupDownloads(viewModelItem: viewModelItem)
    setupLocation(viewModelItem: viewModelItem)
    getTags(viewModelItem)
  }
  
  private func setupLikes(viewModelItem: PhotoDetailViewModelItem) {
    if viewModelItem.likes == .zero {
      likesStackView.isHidden = true
    } else {
      likesLabel.text = viewModelItem.likes
    }
  }
  
  private func setupDownloads(viewModelItem: PhotoDetailViewModelItem) {
    if viewModelItem.downloads == .zero {
      downloadStackView.isHidden = true
    } else {
      downloadsLabel.text = viewModelItem.downloads
    }
  }
  
  private func setupLocation(viewModelItem: PhotoDetailViewModelItem) {
    if viewModelItem.location == .empty {
      locationStackView.isHidden = true
    } else {
      locationStackView.isHidden = false
      locationLabel.text = viewModelItem.location
    }
  }
  
  private func getTags(_ viewModelItem: PhotoDetailViewModelItem) {
    if viewModelItem.tags?.isEmpty == true {
      hideTags()
      setNoTagsConstraints()
    } else {
      setTagsConstraints()
      updateTagsCollectionView(with: viewModelItem.tags ?? [])
    }
  }
  
  private func hideTags() {
    tagsCollectionView.isHidden = true
  }
  
  private func updateTagsCollectionView(with tags: [Tag]) {
    tagsCollectionView.tags = tags
    tagsCollectionView.isHidden = false
    tagsCollectionView.reloadData()
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(mainView)
    mainView.addSubview(photoView)
    mainView.addSubview(gradientView)
    mainView.addSubview(mainStackView)
    mainView.addSubview(leftStackView)
    mainView.addSubview(centerLine)
    mainView.addSubview(rightStackView)
    checkmarkIconBackgroundView.addSubview(checkmarkIconImageView)
  }
  
  private func setupGestureRecognizers() {
    photoView.addGestureRecognizer(showAndHidePhotoInfoTapGesture)
    avatarAndUserNameLabelStackView.addGestureRecognizer(openProfileTapGesture)
  }
  
  private func setupConstraints() {
    mainView.fillSuperView()
    gradientView.fillSuperView()
    photoView.fillSuperView()
    setupMainStackViewConstraints()
    setupCenterLineConstraints()
    setupLeftStackViewConstraints()
    setupRightStackViewConstraints()
    checkmarkIconImageViewConstraints()
  }
  
  private func checkmarkIconImageViewConstraints() {
    checkmarkIconImageView.setConstraints(
      centerY: checkmarkIconBackgroundView.centerYAnchor,
      centerX: checkmarkIconBackgroundView.centerXAnchor
    )
  }
  
  private func setupMainStackViewConstraints() {
    mainStackView.setConstraints(
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pRight: Const.rightPadding,
      pBottom: Const.mainStackViewBottomPadding,
      pLeft: Const.leftPadding
    )
  }
  
  private func setNoTagsConstraints() {
    leftStackView.setConstraints(
      centerY: centerLine.centerYAnchor
    )
    rightStackView.setConstraints(
      centerY: centerLine.centerYAnchor
    )
    centerLine.setConstraints(
      top: mainStackView.bottomAnchor,
      pTop: Const.centerLineTopOffset
    )
  }
  
  private func setTagsConstraints() {
    leftStackView.setConstraints(
      centerY: centerLine.centerYAnchor
    )
    rightStackView.setConstraints(
      centerY: centerLine.centerYAnchor
    )
    centerLine.setConstraints(
      top: mainStackView.bottomAnchor,
      pTop: Const.centerLineTopOffset
    )
  }
  
  private func setupCenterLineConstraints() {
    centerLine.centerX()
  }
  
  private func setupLeftStackViewConstraints() {
    leftStackView.setConstraints(
      right: centerLine.rightAnchor,
      left: leftAnchor,
      pRight: Const.smallRightPadding,
      pLeft: Const.leftPadding
    )
  }
  
  private func setupRightStackViewConstraints() {
    rightStackView.setConstraints(
      right: rightAnchor,
      left: centerLine.leftAnchor,
      pRight: Const.rightPadding,
      pLeft: Const.leftPadding
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
    configShareBarButtonItem(navigationItem, navigationController)
  }
  
  private func setupNavigationItems(_ navigationItem: UINavigationItem) {
    navigationItem.leftBarButtonItems = makeLeftBarButtons()
    navigationItem.rightBarButtonItems = makeRightBarButtons()
  }
  
  private func setupBarButtons() {
    backBarButtonBlurEffect.contentView.addSubview(backBarButton)
    downloadBarButtonBlurEffect.contentView.addSubview(downloadBarButton)
    toggleContentModePhotoButtonBlurEffect.contentView.addSubview(
      toggleContentModeButton
    )
    shareButtonBlurEffect.contentView.addSubview(shareBarButton)
  }
  
  private func makeRightBarButtons() -> [UIBarButtonItem] {
    let downloadBarButton = UIBarButtonItem(customView: downloadBarButtonBlurEffect)
    let toggleContentModeButton = UIBarButtonItem(
      customView: toggleContentModePhotoButtonBlurEffect
    )
    let shareBarButton = UIBarButtonItem(
      customView: shareButtonBlurEffect
    )
    let barButtonItems = [
      shareBarButton,
      toggleContentModeButton,
      downloadBarButton
    ]
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
  
  // Back Bar Button
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
  
  // Download Bar Button
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
  
  // Toggle Content Mode Bar Button
  @objc private func toggleContentModeBarButtonTapped() {
    toggleContentModeBarButtonAction?()
  }
  
  private func configToggleContentModeBarButtonItem(
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
  
  private func configToggleContentMode() {
    if self.isAspectFill {
      let icon = SFSymbol.toggleDownIcon
      photoView.mainImageView.contentMode = .scaleAspectFit
      toggleContentModeButton.setImage(icon, for: .normal)
    } else {
      let icon = SFSymbol.toggleUpIcon
      photoView.mainImageView.contentMode = .scaleAspectFill
      toggleContentModeButton.setImage(icon, for: .normal)
    }
    self.isAspectFill.toggle()
  }
  
  // Share Bar Button
  @objc private func shareBarButtonTapped() {
    shareBarButtonAction?()
  }
  
  private func configShareBarButtonItem(
    _ navigationItem: UINavigationItem,
    _ navigationController: UINavigationController?
  ) {
    setupShareBarButtonAction(navigationController)
    setupShareBarButtonTarget()
  }
  
  private func setupShareBarButtonAction(
    _ navigationController: UINavigationController?
  ) {
    shareBarButtonAction = { [
      weak self,
      weak navigationController
    ] in
      guard let image = self?.photoView.mainImageView.image else { return }
      let activityController = UIActivityViewController(
        activityItems: [image],
        applicationActivities: nil
      )
      guard
        let navigationController
      else {
        return
      }
      activityController.popoverPresentationController?.sourceView = self?.shareBarButton
      navigationController.present(activityController, animated: true)
    }
  }
  
  private func setupShareBarButtonTarget() {
    shareBarButton.addTarget(
      self,
      action: #selector(shareBarButtonTapped),
      for: .touchUpInside
    )
  }
  
  // MARK: Animate Buttons
  private func animateDownloadButton() {
    UIView.animate(
      withDuration: Const.minDuration
    ) {
      self.downloadBarButtonBlurEffect.frame.origin.x = Const.translationX
      self.downloadBarButtonBlurEffect.frame.size.width = Const.fullValue
      self.downloadBarButtonBlurEffect.frame.size.height = Const.fullValue
      self.downloadBarButton.alpha = .zero
    } completion: { _ in
      self.downloadBarButton.removeFromSuperview()
      self.downloadBarButtonBlurEffect.contentView.addSubview(self.spinner)
    }
  }
  
  func reverseAnimateDownloadButton() {
    UIView.animate(
      withDuration: Const.defaultDuration,
      delay: .zero,
      usingSpringWithDamping: Const.defaultDamping,
      initialSpringVelocity: Const.defaultVelocity
    ) {
      self.downloadBarButtonBlurEffect.frame.origin.x = -Const.translationX
      self.downloadBarButtonBlurEffect.frame.size.width = Const.downloadButtonWidth
      self.downloadBarButtonBlurEffect.frame.size.height = Const.fullValue
      self.downloadBarButtonBlurEffect.layer.cornerRadius = Const.defaultValue
      self.spinner.removeFromSuperview()
      self.downloadBarButtonBlurEffect.contentView.addSubview(self.downloadBarButton)
      self.downloadBarButton.alpha = Const.defaultOpacity
    }
  }
  
  func hidePhotoInfo() {
    UIView.animate(withDuration: Const.hidePhotoInfoDuration) {
      let transform = CGAffineTransform(
        translationX: .zero,
        y: Const.translationY
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
      self.gradientView.alpha = Const.defaultOpacity
      self.photoInfoStackView.isHidden = true
    }
  }
  
  private func showPhotoInfo() {
    UIView.animate(
      withDuration: Const.defaultDuration,
      delay: .zero,
      usingSpringWithDamping: Const.defaultDamping,
      initialSpringVelocity: Const.defaultDuration
    ) {
      self.gradientView.alpha = Const.maxOpacity
      self.photoInfoStackView.alpha = Const.maxOpacity
      self.leftStackView.alpha = Const.maxOpacity
      self.rightStackView.alpha = Const.maxOpacity
      self.centerLine.alpha = Const.defaultOpacity
      let transform = CGAffineTransform(
        translationX: .zero,
        y: Const.verticalTranslation
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
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    let readableDate = dateFormatter.string(from: date)
    createdLabel.text = readableDate
  }
}
