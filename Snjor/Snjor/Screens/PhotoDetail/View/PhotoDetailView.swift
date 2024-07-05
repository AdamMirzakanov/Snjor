//
//  PhotoDetailView.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

// swiftlint:disable all
class PhotoDetailView: UIView {
  // MARK: - Private Properties
  private var isAspectFill = true
  private var isPhotoInfo = true

  // MARK: -  Views
  // MARK: Back Bar Button
  private let backBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = UIConst.buttonHeight
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.backButtonBlurViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  private lazy var backBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .backBarButtonImage), for: .normal)
    $0.tintColor = .label
    $0.alpha = UIConst.alphaDefault
    $0.frame = backBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: Download Bar Button
  let downloadBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = UIConst.buttonWidth
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  lazy var downloadBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .downloadBarButtonImage), for: .normal)
    $0.setTitle(.jpeg, for: .normal)
    $0.titleLabel?.font = .systemFont(
      ofSize: UIConst.defaultFontSize,
      weight: .regular
    )
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alphaDefault
    $0.frame = downloadBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: Pause Bar Button
  let pauseBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  lazy var pauseBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .pauseBarButtonImage), for: .normal)
    $0.tintColor = .label
    $0.alpha = UIConst.alphaDefault
    $0.frame = pauseBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: Toggle Bar Button
  private let toggleContentModeButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = UIConst.buttonHeight
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  private lazy var toggleContentModeButton: UIButton = {
    let icon = UIImage(systemName: .arrowUp)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alphaDefault
    $0.frame = toggleContentModeButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: Main Photo
  private let mainPhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  // MARK: Gradient
  private let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    let color = UIColor(white: .zero, alpha: UIConst.gradientAlpha)
    $0.setColors([
      GradientView.Color(
        color: .clear,
        location: UIConst.halfLocation
      ),
      GradientView.Color(
        color: color,
        location: UIConst.location
      )
    ])
    $0.clipsToBounds = true
    return $0
  }(GradientView())

  // MARK: Profile
  private let profilePhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: .profileDefaultPhotoImage)
    $0.layer.cornerRadius = UIConst.backButtonBlurViewCornerRadius
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: UIConst.blurViewSize).isActive = true
    $0.heightAnchor.constraint(equalToConstant: UIConst.blurViewSize).isActive = true
    return $0
  }(UIImageView())

  private let nameLabel: UILabel = {
    $0.text = .nameDefault
    $0.textColor = .white
    $0.font = UIFont(name: .nameFont, size: UIConst.nameFontSize)
    return $0
  }(UILabel())

  // MARK: Info Button
  private let infoButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: .infoButtonImage), for: .normal)
    $0.tintColor = .white
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UIButton(type: .system))

  // MARK: Profile & Info Button Stack View
  private lazy var profileAndInfoButtonStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.midlValue
    $0.addArrangedSubview(profilePhotoImageView)
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(infoButton)
    return $0
  }(UIStackView())

  // MARK: First Line
  private let firstLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = UIConst.alphaDefault
    $0.heightAnchor.constraint(equalToConstant: UIConst.lineHeightAnchor).isActive = true
    return $0
  }(UIView())

  // MARK: Likes
  private let heartImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .heartImage)
    $0.tintColor = .systemBrown
    return $0
  }(UIImageView())

  private let likesLabel: UILabel = {
    $0.text = .likesDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  private lazy var likesStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(heartImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())

  // MARK: Downloads
  private let downloadsImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .downloadsImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())

  private let downloadsLabel: UILabel = {
    $0.text = .downloadDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  private lazy var downloadStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(downloadsImageView)
    $0.addArrangedSubview(downloadsLabel)
    return $0
  }(UIStackView())

  // MARK: Activity
  private let activityImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .viewsImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())

  private let activityLabel: UILabel = {
    $0.text = .viewsDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  private lazy var activityStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(activityImageView)
    $0.addArrangedSubview(activityLabel)
    return $0
  }(UIStackView())

  // MARK: Likes & Downloads Stack Views
  private lazy var profitStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.longValue
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    $0.addArrangedSubview(activityStackView)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  //  private lazy var profitAndInfoButtonStackView: UIStackView = {
  //    $0.translatesAutoresizingMaskIntoConstraints = false
  //    $0.axis = .horizontal
  //    $0.distribution = .fill
  //    $0.alignment = .fill
  //    $0.spacing = UIConst.midlValue
  //    $0.addArrangedSubview(profitStackViews)
  //    $0.addArrangedSubview(UIView())
  //    return $0
  //  }(UIStackView())

  // MARK: Second Line
  private let secondLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = UIConst.alphaDefault
    $0.heightAnchor.constraint(equalToConstant: UIConst.lineHeightAnchor).isActive = true
    return $0
  }(UIView())

  // MARK: Created,
  private let createdLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  // MARK: Camera model
  private let cameraImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .cameraImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())

  private var cameraModelLabel: UILabel = {
    $0.text = .cameraDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .black)
    return $0
  }(UILabel())

  private lazy var cameraStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(cameraImageView)
    $0.addArrangedSubview(cameraModelLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: Resolution
  private let resolutionLabel: UILabel = {
    $0.text = .resolutionDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.textAlignment = .center
    $0.backgroundColor = .darkGray
    $0.alpha = UIConst.alphaDefault
    $0.layer.cornerRadius = UIConst.resolutionLabelCornerRadius
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: UIConst.resolutionLabelWidth).isActive = true
    $0.heightAnchor.constraint(equalToConstant: UIConst.resolutionLabelHeight).isActive = true
    return $0
  }(UILabel())

  private let pxLabel: UILabel = {
    $0.text = .pxlDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())

  // MARK: Resolution Stack View
  private lazy var resolutionStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(resolutionLabel)
    $0.addArrangedSubview(pxLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: Exposure parameters
  private let isoLabel: UILabel = {
    $0.text = .isoDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())

  private let apertureLabel: UILabel = {
    $0.text = .apertureDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())

  private let focalLengthLabel: UILabel = {
    $0.text = .focalLengtDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())

  private let exposureTimeLabel: UILabel = {
    $0.text = .exposureDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())

  private lazy var characteristicsPhotoStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.addArrangedSubview(isoLabel)
    $0.addArrangedSubview(focalLengthLabel)
    $0.addArrangedSubview(apertureLabel)
    $0.addArrangedSubview(exposureTimeLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: Photo Info Stack View
  private lazy var photoInfoStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.midlValue
    $0.addArrangedSubview(firstLine)
    $0.addArrangedSubview(profitStackView)
    $0.addArrangedSubview(secondLine)
    $0.addArrangedSubview(createdLabel)
    $0.addArrangedSubview(cameraStackView)
    $0.addArrangedSubview(resolutionStackView)
    $0.addArrangedSubview(characteristicsPhotoStackView)
    return $0
  }(UIStackView())

  // MARK: Main Stack View
  private lazy var mainStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.midlValue
    $0.addArrangedSubview(profileAndInfoButtonStackView)
    $0.addArrangedSubview(photoInfoStackView)
    return $0
  }(UIStackView())

  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Internal Methods
  func setupData(viewModel: any PhotoDetailViewModelProtocol) {
    mainPhotoImageView.setImageFromData(data: viewModel.backgroundImageData)
    profilePhotoImageView.setImageFromData(data: viewModel.backgroundImageData)
    nameLabel.text = viewModel.displayName
    likesLabel.text = viewModel.likes
    downloadsLabel.text = viewModel.downloads
    activityLabel.text = viewModel.views
    createdAt(from: viewModel.createdAt)
    cameraModelLabel.text = viewModel.cameraModel
    resolutionLabel.text = viewModel.resolution
    pxLabel.text = viewModel.pixels
    isoLabel.text = viewModel.iso
    focalLengthLabel.text = viewModel.focalLength
    apertureLabel.text = viewModel.aperture
    exposureTimeLabel.text = viewModel.exposureTime
  }

  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    setupBarButtons()
    navigationItem.rightBarButtonItems = makeRightBackBarButtons()
    navigationItem.leftBarButtonItems = makeLeftBackBarButtons()
    configInfoButtonAction()
    configPauseButtonAction()
    configBackButtonAction(navigationController: navigationController)
    configToggleContentModeButtonAction()
  }


  func animateDownloadButton() {
    self.downloadBarButtonBlurView.frame.origin.x = 0.0
    UIView.animate(
      withDuration: UIConst.durationDefault,
      delay: .zero,
      usingSpringWithDamping: UIConst.dampingDefault,
      initialSpringVelocity: UIConst.velocityDefault
    ) {
      self.downloadBarButtonBlurView.frame.size.width = UIConst.buttonHeight
      self.downloadBarButtonBlurView.frame.origin.x = UIConst.translationX
      self.downloadBarButton.frame.size.width = UIConst.buttonHeight
      self.downloadBarButton.setTitle(nil, for: .normal)
      self.downloadBarButton.setImage(nil, for: .normal)
      self.downloadBarButton.isEnabled = false

      self.pauseBarButtonBlurView.frame.size.width = UIConst.buttonHeight
      self.pauseBarButton.frame = self.pauseBarButtonBlurView.bounds
    }
  }

  // MARK: - Private Methods
  private func setupViews() {
    addSubview(mainPhotoImageView)
    addSubview(gradientView)
    addSubview(mainStackView)
    setupConstraint()
    hidePhotoInfo()
  }

  private func setupConstraint() {
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),

      mainPhotoImageView.topAnchor.constraint(equalTo: topAnchor),
      mainPhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      mainPhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainPhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConst.mainStackLeadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConst.mainStackLeadingAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIConst.mainStackViewBottomAnchor)
    ])
  }

  // MARK: Make Bar Buttons
  private func setupNavigationItems(navigationItem: UINavigationItem) {
    navigationItem.rightBarButtonItems = makeRightBackBarButtons()
    navigationItem.leftBarButtonItems = makeLeftBackBarButtons()
  }

  private func setupBarButtons() {
    backBarButtonBlurView.contentView.addSubview(backBarButton)
    downloadBarButtonBlurView.contentView.addSubview(downloadBarButton)
    pauseBarButtonBlurView.contentView.addSubview(pauseBarButton)
    toggleContentModeButtonBlurView.contentView.addSubview(toggleContentModeButton)
  }

  private func makeRightBackBarButtons() -> [UIBarButtonItem] {
    let downloadBarButton = UIBarButtonItem(customView: downloadBarButtonBlurView)
    let pauseBarButton = UIBarButtonItem(customView: pauseBarButtonBlurView)
    let toggleContentModeButton = UIBarButtonItem(customView: toggleContentModeButtonBlurView)
    let barButtonItems = [toggleContentModeButton, downloadBarButton, pauseBarButton]
    return barButtonItems
  }

  private func makeLeftBackBarButtons() -> [UIBarButtonItem] {
    let backBarButton = UIBarButtonItem(customView: backBarButtonBlurView)
    let barButtonItems = [backBarButton]
    return barButtonItems
  }

  // MARK: Config Actions
  private func configBackButtonAction(navigationController: UINavigationController?) {
    let backButtonAction = UIAction { _ in
      navigationController?.popViewController(animated: true)
    }
    backBarButton.addAction(backButtonAction, for: .touchUpInside)
  }

  private func configPauseButtonAction() {
    let pauseButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.configToggleContentMode()
    }
    pauseBarButton.addAction(pauseButtonAction, for: .touchUpInside)
  }

  private func configToggleContentModeButtonAction() {
    let toggleContentModeButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.configToggleContentMode()
    }
    toggleContentModeButton.addAction(toggleContentModeButtonAction, for: .touchUpInside)
  }

  private func configToggleContentMode() {
    if self.isAspectFill {
      let icon = UIImage(systemName: .arrowDown)
      mainPhotoImageView.contentMode = .scaleAspectFit
      toggleContentModeButton.setImage(icon, for: .normal)
    } else {
      let icon = UIImage(systemName: .arrowUp)
      mainPhotoImageView.contentMode = .scaleAspectFill
      toggleContentModeButton.setImage(icon, for: .normal)
    }
    self.isAspectFill.toggle()
  }

  private func configInfoButtonAction() {
    let infoButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.isPhotoInfo ? self.showPhotoInfo() : self.hidePhotoInfo()
      self.isPhotoInfo.toggle()
    }
    infoButton.addAction(infoButtonAction, for: .touchUpInside)
  }

  // MARK: Displaying Photo Info
  private func hidePhotoInfo() {
    UIView.animate(withDuration: UIConst.hidePhotoInfoDurationDefault) {
      let transform = CGAffineTransform(translationX: .zero, y: UIConst.translationY)
      self.profileAndInfoButtonStackView.transform = transform
      self.photoInfoStackView.alpha = .zero
      self.gradientView.alpha = UIConst.alphaDefault
      self.photoInfoStackView.isHidden = true
    }
  }

  private func showPhotoInfo() {
    UIView.animate(
      withDuration: UIConst.durationDefault,
      delay: .zero,
      usingSpringWithDamping: UIConst.dampingDefault,
      initialSpringVelocity: UIConst.velocityDefault
    ) {
      self.gradientView.alpha = UIConst.maxOpacity
      self.photoInfoStackView.alpha = UIConst.maxOpacity
      self.mainStackView.transform = .identity
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
}
