//
//  PhotoDetailMainView.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

protocol PhotoDetailRootViewDelegate: AnyObject {
  func didTapDownloadButton()
}

// swiftlint:disable all
final class PhotoDetailRootView: UIView {

  // MARK: - Delegate
  weak var delegate: PhotoDetailRootViewDelegate?

  // MARK: - Private Properties
  private var isAspectFill = true
  private var isPhotoInfo = true

  // MARK: - Photo Views
  let photoView: PhotoDetailPhotoView = {
    return $0
  }(PhotoDetailPhotoView())

  let profilePhotoView: PhotoDetailPhotoView = {
    $0.contentMode = .scaleAspectFill
    $0.mainImageView.image = UIImage(named: .defaultProfilePhoto)
    $0.layer.cornerRadius = GlobalConst.ultraCircle
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: GlobalConst.ultraValue
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: GlobalConst.ultraValue
    ).isActive = true
    $0.backgroundColor = .systemPurple
    return $0
  }(PhotoDetailPhotoView())

  // MARK: - Gesture
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

  // MARK: - Gradient
 private let gradientView: GradientView = {
   $0.isUserInteractionEnabled = false
    let color = UIColor(
      white: .zero,
      alpha: PhotoDetailRootViewConst.gradientAlpha
    )
    $0.setColors([
      GradientView.Color(
        color: .clear,
        location: PhotoDetailRootViewConst.downLocation
      ),
      GradientView.Color(
        color: color,
        location: PhotoDetailRootViewConst.upLocation
      )
    ])
    return $0
  }(GradientView())

  // MARK: - Spinner
  lazy var spinner: UIActivityIndicatorView = {
    let xCenter = self.downloadBarButtonBlurEffect.contentView.bounds.midX
    let yCenter = self.downloadBarButtonBlurEffect.contentView.bounds.midY
    $0.center = CGPoint(x: xCenter, y: yCenter)
    $0.startAnimating()
    $0.color = .label
    $0.transform = CGAffineTransform(
      scaleX: PhotoDetailRootViewConst.spinnerScale,
      y: PhotoDetailRootViewConst.spinnerScale
    )
    $0.alpha = GlobalConst.defaultAlpha
    return $0
  }(UIActivityIndicatorView(style: .medium))

  // MARK: - Blur Effects
  private let backBarButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = GlobalConst.fullValue
    $0.frame.size.height = GlobalConst.fullValue
    $0.layer.cornerRadius = GlobalConst.circle
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  let downloadBarButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = PhotoDetailRootViewConst.downloadButtonWidth
    $0.frame.size.height = GlobalConst.fullValue
    $0.layer.cornerRadius = GlobalConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  private let toggleContentModePhotoButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = GlobalConst.fullValue
    $0.frame.size.height = GlobalConst.fullValue
    $0.layer.cornerRadius = GlobalConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  // MARK: - Buttons
  private lazy var backBarButton: UIButton = {
    let icon = UIImage(systemName: .backBarButtonImage)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.alpha = GlobalConst.defaultAlpha
    $0.frame = backBarButtonBlurEffect.bounds
    return $0
  }(UIButton())

  lazy var downloadBarButton: UIButton = {
    let icon = UIImage(systemName: .downloadBarButtonImage)
    $0.setImage(icon, for: .normal)
    $0.setTitle(.jpeg, for: .normal)
    $0.titleLabel?.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = GlobalConst.defaultAlpha
    $0.frame = downloadBarButtonBlurEffect.bounds
    return $0
  }(UIButton())

  private lazy var toggleContentModeButton: UIButton = {
    let icon = UIImage(systemName: .toggleUp)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = GlobalConst.defaultAlpha
    $0.frame = toggleContentModePhotoButtonBlurEffect.bounds
//    $0.adjustsImageWhenHighlighted = false
    return $0
  }(UIButton())

  private let infoButton: UIButton = {
    let icon = UIImage(systemName: .infoButtonImage)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .white
    $0.alpha = GlobalConst.defaultAlpha
    return $0
  }(UIButton())

  // MARK: - ImageViews
  private let heartImageView: UIImageView = {
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

  private let cameraImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .cameraImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())

  // MARK: - Labels
  let nameLabel: UILabel = {
    $0.text = .defaultUserName
    $0.textColor = .white
    $0.font = UIFont(
      name: .nameFont,
      size: PhotoDetailRootViewConst.userNameFontSize
    )
    return $0
  }(UILabel())

  let likesLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())

  let downloadsLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())

  private let createdLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())

  var cameraModelLabel: UILabel = {
    $0.text = .defaultCamera
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .black
    )
    return $0
  }(UILabel())

  let resolutionLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    $0.textAlignment = .center
    $0.backgroundColor = .darkGray
    $0.alpha = GlobalConst.defaultAlpha
    $0.layer.cornerRadius = GlobalConst.smallValue
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: PhotoDetailRootViewConst.resolutionLabelWidth
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailRootViewConst.resolutionLabelHeight
    ).isActive = true
    return $0
  }(UILabel())

  let pxLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = GlobalConst.defaultAlpha
    return $0
  }(UILabel())

  let isoValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = GlobalConst.defaultAlpha
    return $0
  }(UILabel())

  private let isoLabel: UILabel = {
    $0.text = .iso
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())

  let apertureValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = GlobalConst.defaultAlpha
    return $0
  }(UILabel())

  private let apertureLabel: UILabel = {
    $0.text = .aperture
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())

  let focalLengthValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = GlobalConst.defaultAlpha
    return $0
  }(UILabel())

  private let focalLengthLabel: UILabel = {
    $0.text = .focalLengt
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())

  let exposureTimeValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    $0.alpha = GlobalConst.defaultAlpha
    return $0
  }(UILabel())

  private let exposureTimeLabel: UILabel = {
    $0.text = .exposure
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: GlobalConst.defaultFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())

  // MARK: - Lines
  private let firstLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = GlobalConst.defaultAlpha
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailRootViewConst.lineWidth
    ).isActive = true
    return $0
  }(UIView())

  private let secondLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = GlobalConst.defaultAlpha
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailRootViewConst.lineWidth
    ).isActive = true
    return $0
  }(UIView())

  private let centerLine: UIView = {
    $0.backgroundColor = .white
    $0.alpha = GlobalConst.defaultAlpha
    $0.widthAnchor.constraint(
      equalToConstant: PhotoDetailRootViewConst.lineWidth
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: PhotoDetailRootViewConst.lineHeight
    ).isActive = true
    return $0
  }(UIView())

  // MARK: - StackViews
  private lazy var profileAndInfoButtonStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.middleValue
    $0.addArrangedSubview(profilePhotoView)
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(infoButton)
    return $0
  }(UIStackView())

  private lazy var likesStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.defaultValue
    $0.addArrangedSubview(heartImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())

  private lazy var downloadStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.defaultValue
    $0.addArrangedSubview(downloadsImageView)
    $0.addArrangedSubview(downloadsLabel)
    return $0
  }(UIStackView())

  private lazy var profitStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.spacing = GlobalConst.fullValue
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(createdLabel)
    return $0
  }(UIStackView())

  private lazy var cameraStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.defaultValue
    $0.addArrangedSubview(cameraImageView)
    $0.addArrangedSubview(cameraModelLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  private lazy var resolutionStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.defaultValue
    $0.addArrangedSubview(resolutionLabel)
    $0.addArrangedSubview(pxLabel)
    return $0
  }(UIStackView())

  private lazy var isoStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.defaultValue
    $0.addArrangedSubview(isoLabel)
    $0.addArrangedSubview(isoValueLabel)
    return $0
  }(UIStackView())

  private lazy var apertureStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.defaultValue
    $0.addArrangedSubview(apertureLabel)
    $0.addArrangedSubview(apertureValueLabel)
    return $0
  }(UIStackView())

  private lazy var focalLengthStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.defaultValue
    $0.addArrangedSubview(focalLengthLabel)
    $0.addArrangedSubview(focalLengthValueLabel)
    return $0
  }(UIStackView())

  private lazy var exposureTimeStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = GlobalConst.defaultValue
    $0.addArrangedSubview(exposureTimeLabel)
    $0.addArrangedSubview(exposureTimeValueLabel)
    return $0
  }(UIStackView())

  private lazy var leftStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .fillProportionally
    $0.alignment = .leading
    $0.spacing = GlobalConst.middleValue
    $0.addArrangedSubview(cameraStackView)
    $0.addArrangedSubview(resolutionStackView)
    return $0
  }(UIStackView())

  private lazy var rightStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.alignment = .leading
    $0.spacing = GlobalConst.defaultValue
    $0.addArrangedSubview(isoStackView)
    $0.addArrangedSubview(focalLengthStackView)
    $0.addArrangedSubview(apertureStackView)
    $0.addArrangedSubview(exposureTimeStackView)
    return $0
  }(UIStackView())

  private lazy var photoInfoStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = GlobalConst.middleValue
    $0.addArrangedSubview(firstLine)
    $0.addArrangedSubview(profitStackView)
    $0.addArrangedSubview(secondLine)
    return $0
  }(UIStackView())

  private lazy var mainStackView: UIStackView = {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = GlobalConst.middleValue
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
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup Data
  func setupData(viewModel: any PhotoDetailViewModelProtocol) {
    guard let photo = viewModel.photo else { return }
    photoView.configure(with: photo, url: photo.regularURL)
    profilePhotoView.configure(with: photo, url: photo.profileImageURL)
    nameLabel.text = viewModel.displayName
    likesLabel.text = viewModel.likes
    createdAt(from: viewModel.createdAt)
    resolutionLabel.text = viewModel.resolution
    pxLabel.text = viewModel.pixels
  }

  func setupPhotoInfoData(viewModel: any PhotoDetailViewModelProtocol) {
    downloadsLabel.text = viewModel.downloads
    cameraModelLabel.text = viewModel.cameraModel
    isoValueLabel.text = viewModel.iso
    focalLengthValueLabel.text = viewModel.focalLength
    apertureValueLabel.text = viewModel.aperture
    exposureTimeValueLabel.text = viewModel.exposureTime
  }

  // MARK: - Setup Views
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
      pRight: PhotoDetailRootViewConst.rightPadding,
      pBottom: PhotoDetailRootViewConst.bottomPadding,
      pLeft: PhotoDetailRootViewConst.leftPadding
    )
  }

  private func setupCenterLineConstraints() {
    centerLine.centerX()
    centerLine.setConstraints(
      top: mainStackView.topAnchor,
      pTop: PhotoDetailRootViewConst.topOffset
    )
  }

  private func setupLeftStackViewConstraints() {
    leftStackView.setConstraints(
      centerY: mainStackView.centerYAnchor,
      pCenterY: PhotoDetailRootViewConst.centerYOffset
    )
    leftStackView.setConstraints(
      right: rightAnchor,
      left: leftAnchor,
      pRight: PhotoDetailRootViewConst.halfRightPadding,
      pLeft: PhotoDetailRootViewConst.leftPadding
    )
  }

  private func setupRightStackViewConstraints() {
    rightStackView.setConstraints(
      centerY: mainStackView.centerYAnchor,
      pCenterY: PhotoDetailRootViewConst.centerYOffset
    )
    rightStackView.setConstraints(
      right: rightAnchor,
      left: centerLine.leftAnchor,
      pRight: PhotoDetailRootViewConst.rightPadding,
      pLeft: PhotoDetailRootViewConst.leftPadding
    )
  }

  // MARK: - Setup Navigation Items
  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    setupBarButtons()
    setupNavigationItems(navigationItem)
    configInfoButtonAction()
    configBackButtonAction(navigationController)
    configToggleContentModeButtonAction()
    configDownloadButtonAction()
  }

  private func setupNavigationItems(_ navigationItem: UINavigationItem) {
    navigationItem.rightBarButtonItems = makeRightBarButtons()
    navigationItem.leftBarButtonItems = makeLeftBarButtons()
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

  // MARK: - Config Navigation Item Actions
  private func configBackButtonAction(
    _ navigationController: UINavigationController?
  ) {
    let backButtonAction = UIAction { _ in
      navigationController?.popViewController(animated: true)
    }
    backBarButton.addAction(
      backButtonAction,
      for: .touchUpInside
    )
  }

  private func configDownloadButtonAction() {
    let downloadButtonAction = UIAction { [weak self] _ in
      guard
        let self = self,
        let delegate = delegate
      else {
        return
      }
      animateDownloadButton()
      delegate.didTapDownloadButton()
    }
    downloadBarButton.addAction(
      downloadButtonAction,
      for: .touchUpInside
    )
  }

  private func configToggleContentModeButtonAction() {
    let toggleContentModeButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      configToggleContentMode()
    }
    toggleContentModeButton.addAction(
      toggleContentModeButtonAction,
      for: .touchUpInside
    )
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

  // MARK: - Animate Buttons
 private func animateDownloadButton() {
    UIView.animate(
      withDuration: PhotoDetailRootViewConst.minDuration
    ) {
      self.downloadBarButtonBlurEffect.frame.origin.x = PhotoDetailRootViewConst.translationX
      self.downloadBarButtonBlurEffect.frame.size.width = GlobalConst.fullValue
      self.downloadBarButtonBlurEffect.frame.size.height = GlobalConst.fullValue
      self.downloadBarButton.alpha = .zero
      self.downloadBarButtonBlurEffect.layer.cornerRadius = GlobalConst.circle
    } completion: { _ in
      self.downloadBarButton.removeFromSuperview()
      self.downloadBarButtonBlurEffect.contentView.addSubview(self.spinner)
    }
  }

  func reverseAnimateDownloadButton() {
    UIView.animate(
      withDuration: PhotoDetailRootViewConst.defaultDuration,
      delay: .zero,
      usingSpringWithDamping: PhotoDetailRootViewConst.defaultDamping,
      initialSpringVelocity: PhotoDetailRootViewConst.defaultVelocity
    ) {
      self.downloadBarButtonBlurEffect.frame.origin.x = -PhotoDetailRootViewConst.translationX
      self.downloadBarButtonBlurEffect.frame.size.width = PhotoDetailRootViewConst.downloadButtonWidth
      self.downloadBarButtonBlurEffect.frame.size.height = GlobalConst.fullValue
      self.downloadBarButtonBlurEffect.layer.cornerRadius = GlobalConst.defaultValue
      self.spinner.removeFromSuperview()
      self.downloadBarButtonBlurEffect.contentView.addSubview(self.downloadBarButton)
      self.downloadBarButton.alpha = GlobalConst.defaultAlpha
    }
  }

  func hidePhotoInfo() {
    UIView.animate(withDuration: PhotoDetailRootViewConst.hidePhotoInfoDuration) {
      let transform = CGAffineTransform(
        translationX: .zero,
        y: PhotoDetailRootViewConst.translationY
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
      self.gradientView.alpha = GlobalConst.defaultAlpha
      self.photoInfoStackView.isHidden = true
    }
  }

  private func showPhotoInfo() {
    UIView.animate(
      withDuration: PhotoDetailRootViewConst.defaultDuration,
      delay: .zero,
      usingSpringWithDamping: PhotoDetailRootViewConst.defaultDamping,
      initialSpringVelocity: PhotoDetailRootViewConst.defaultDuration
    ) {
      self.gradientView.alpha = GlobalConst.maxAlpha
      self.photoInfoStackView.alpha = GlobalConst.maxAlpha
      self.leftStackView.alpha = GlobalConst.maxAlpha
      self.rightStackView.alpha = GlobalConst.maxAlpha
      self.centerLine.alpha = GlobalConst.defaultAlpha
      let transform = CGAffineTransform(
        translationX: .zero,
        y: PhotoDetailRootViewConst.verticalTranslation
      )
      self.mainStackView.transform = transform
      self.leftStackView.transform = transform
      self.rightStackView.transform = transform
      self.centerLine.transform = transform
      self.photoInfoStackView.isHidden = false
    }
  }


  // MARK: - Config Button Actions
  private func configInfoButtonAction() {
    let infoButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.showAndHidePhotoInfo()
    }
    infoButton.addAction(infoButtonAction, for: .touchUpInside)
  }

  // MARK: - Helper
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
