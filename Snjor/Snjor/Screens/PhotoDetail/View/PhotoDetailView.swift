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
  
  // MARK: - Main Photo View
  private let photoView: PhotoView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(PhotoView())

  // MARK: - Gradient
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
  
  // MARK: - BlurViews
  private let backBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = UIConst.buttonHeight
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.backButtonBlurViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  let downloadBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = UIConst.buttonWidth
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  let pauseBarButtonBlurView: UIVisualEffectView = {
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  private let toggleContentModeButtonBlurView: UIVisualEffectView = {
    $0.frame.size.width = UIConst.buttonHeight
    $0.frame.size.height = UIConst.buttonHeight
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  // MARK: - Buttons
  private lazy var backBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .backBarButtonImage), for: .normal)
    $0.tintColor = .label
    $0.alpha = UIConst.alphaDefault
    $0.frame = backBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))
  
  lazy var downloadBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .downloadBarButtonImage), for: .normal)
    $0.setTitle(.jpeg, for: .normal)
    $0.titleLabel?.font = .systemFont(
      ofSize: UIConst.downloadButtonFontSize,
      weight: .medium
    )
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alphaDefault
    $0.frame = downloadBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))
  
  lazy var pauseBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .pauseBarButtonImage), for: .normal)
    $0.tintColor = .label
    $0.alpha = UIConst.alphaDefault
    $0.frame = pauseBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))
  
  private lazy var toggleContentModeButton: UIButton = {
    let icon = UIImage(systemName: .arrowUp)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alphaDefault
    $0.frame = toggleContentModeButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))
  
  private let infoButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: .infoButtonImage), for: .normal)
    $0.tintColor = .white
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UIButton(type: .system))
  
  // MARK: - ImageViews
  let profilePhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: .profileDefaultPhotoImage)
    $0.layer.cornerRadius = UIConst.backButtonBlurViewCornerRadius
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: UIConst.blurViewSize).isActive = true
    $0.heightAnchor.constraint(equalToConstant: UIConst.blurViewSize).isActive = true
    return $0
  }(UIImageView())
  
  private let heartImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .heartImage)
    $0.tintColor = .systemPink
    return $0
  }(UIImageView())
  
  private let downloadsImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .downloadsImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  private let cameraImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .cameraImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())
  
  // MARK: - Labels
  let nameLabel: UILabel = {
    $0.text = .nameDefault
    $0.textColor = .white
    $0.font = UIFont(name: .nameFont, size: UIConst.nameFontSize)
    return $0
  }(UILabel())
  
  let likesLabel: UILabel = {
    $0.text = .likesDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())
  
  let downloadsLabel: UILabel = {
    $0.text = .downloadDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())
  
  private let createdLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())
  
  var cameraModelLabel: UILabel = {
    $0.text = .cameraDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .black)
    return $0
  }(UILabel())
  
  let resolutionLabel: UILabel = {
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
  
  let pxLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())
  
  let isoValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())
  
  private let isoLabel: UILabel = {
    $0.text = .iso
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())
  
  let apertureValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())
  
  private let apertureLabel: UILabel = {
    $0.text = .aperture
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())
  
  let focalLengthValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())
  
  private let focalLengthLabel: UILabel = {
    $0.text = .focalLengt
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())
  
  let exposureTimeValueLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alphaDefault
    return $0
  }(UILabel())
  
  private let exposureTimeLabel: UILabel = {
    $0.text = .exposure
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())
  
  // MARK: - Lines
  private let firstLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = UIConst.alphaDefault
    $0.heightAnchor.constraint(equalToConstant: UIConst.lineHeightAnchor).isActive = true
    return $0
  }(UIView())
  
  private let secondLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = UIConst.alphaDefault
    $0.heightAnchor.constraint(equalToConstant: UIConst.lineHeightAnchor).isActive = true
    return $0
  }(UIView())
  
  private let centerLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = UIConst.alphaDefault
    $0.widthAnchor.constraint(equalToConstant: UIConst.lineHeightAnchor).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
    return $0
  }(UIView())

  // MARK: - StackViews
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

  private lazy var profitStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.spacing = UIConst.longValue
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(createdLabel)
    return $0
  }(UIStackView())
  
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
  
  private lazy var resolutionStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(resolutionLabel)
    $0.addArrangedSubview(pxLabel)
    return $0
  }(UIStackView())
  
  private lazy var isoStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(isoLabel)
    $0.addArrangedSubview(isoValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var apertureStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(apertureLabel)
    $0.addArrangedSubview(apertureValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var focalLengthStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(focalLengthLabel)
    $0.addArrangedSubview(focalLengthValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var exposureTimeStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(exposureTimeLabel)
    $0.addArrangedSubview(exposureTimeValueLabel)
    return $0
  }(UIStackView())
  
  private lazy var leftStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .fillProportionally
    $0.alignment = .leading
    $0.spacing = UIConst.midlValue
//    $0.addArrangedSubview(createdLabel)
    $0.addArrangedSubview(cameraStackView)
    $0.addArrangedSubview(resolutionStackView)
    return $0
  }(UIStackView())
  
  private lazy var rightStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.alignment = .leading
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(isoStackView)
    $0.addArrangedSubview(focalLengthStackView)
    $0.addArrangedSubview(apertureStackView)
    $0.addArrangedSubview(exposureTimeStackView)
    return $0
  }(UIStackView())
  
  private lazy var photoInfoStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.midlValue
    $0.addArrangedSubview(firstLine)
    $0.addArrangedSubview(profitStackView)
    $0.addArrangedSubview(secondLine)
    return $0
  }(UIStackView())
  
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
      photoView.configure(with: viewModel.photo!)
      photoView.setupImageView()
      nameLabel.text = viewModel.displayName
      likesLabel.text = viewModel.likes
      downloadsLabel.text = viewModel.downloads
      createdAt(from: viewModel.createdAt)
      cameraModelLabel.text = viewModel.cameraModel
      resolutionLabel.text = viewModel.resolution
      pxLabel.text = viewModel.pixels
      isoValueLabel.text = viewModel.iso
      focalLengthValueLabel.text = viewModel.focalLength
      apertureValueLabel.text = viewModel.aperture
      exposureTimeValueLabel.text = viewModel.exposureTime
    }
  
  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    setupBarButtons()
    navigationItem.rightBarButtonItems = makeRightBarButtons()
    navigationItem.leftBarButtonItems = makeLeftBarButtons()
    configInfoButtonAction()
    configPauseButtonAction()
    configBackButtonAction(navigationController: navigationController)
    configToggleContentModeButtonAction()
  }
  
  func animateDownloadButton() {
    UIView.animate(
      withDuration: UIConst.durationDefault,
      delay: .zero,
      usingSpringWithDamping: UIConst.dampingDefault,
      initialSpringVelocity: UIConst.velocityDefault
    ) {
      self.downloadBarButtonBlurView.frame.origin.x = UIConst.translationX
      self.downloadBarButtonBlurView.frame.size.width = UIConst.buttonHeight
      self.downloadBarButtonBlurView.frame.size.height = UIConst.buttonHeight
      self.downloadBarButton.frame.size.width = UIConst.buttonHeight
      self.downloadBarButton.frame.size.height = UIConst.buttonHeight
      self.downloadBarButton.setTitle(nil, for: .normal)
      self.downloadBarButton.setImage(UIImage(systemName: .pauseBarButtonImage), for: .normal)
      self.downloadBarButton.isEnabled = false
      self.pauseBarButtonBlurView.frame.size.width = UIConst.buttonHeight
      self.pauseBarButtonBlurView.frame.size.height = UIConst.buttonHeight
      self.pauseBarButtonBlurView.isHidden = false
      self.pauseBarButton.frame.size.width = UIConst.buttonHeight
      self.pauseBarButton.frame.size.height = UIConst.buttonHeight
      self.pauseBarButton.setImage(UIImage(systemName: .stopBarButtonImage), for: .normal)
    }
  }

  func reverseAnimateDownloadButton() {
    UIView.animate(
      withDuration: UIConst.durationDefault,
      delay: .zero
    ) {
      self.downloadBarButtonBlurView.frame.origin.x = -UIConst.translationX
      self.downloadBarButtonBlurView.frame.size.width = UIConst.buttonWidth
      self.downloadBarButtonBlurView.frame.size.height = UIConst.buttonHeight
      self.downloadBarButtonBlurView.layer.cornerRadius = UIConst.defaultValue
      self.downloadBarButton.frame = self.downloadBarButtonBlurView.bounds
      self.downloadBarButton.setImage(UIImage(systemName: .downloadBarButtonImage), for: .normal)
      self.downloadBarButton.setTitle(.jpeg, for: .normal)
      self.downloadBarButton.isEnabled = true
      self.pauseBarButtonBlurView.frame.origin.x = -8
      self.pauseBarButtonBlurView.frame.size.width = .zero
      self.pauseBarButtonBlurView.frame.size.height = UIConst.buttonHeight
      self.pauseBarButton.frame.size.width = .zero
      self.pauseBarButton.frame.size.height = UIConst.buttonHeight
    }
  }
  
  // MARK: - Private Methods
  private func setupViews() {
    addSubview(photoView)
    addSubview(gradientView)
    addSubview(mainStackView)
    addSubview(leftStackView)
    addSubview(centerLine)
    addSubview(rightStackView)

    setupConstraint()
    hidePhotoInfo()
  }
  
  private func setupConstraint() {
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      photoView.topAnchor.constraint(equalTo: topAnchor),
      photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 50),
      photoView.leadingAnchor.constraint(equalTo: leadingAnchor),
      photoView.trailingAnchor.constraint(equalTo: trailingAnchor),

      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConst.mainStackLeadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConst.mainStackLeadingAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIConst.mainStackViewBottomAnchor),

      centerLine.centerXAnchor.constraint(equalTo: centerXAnchor),
      centerLine.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 225),
      centerLine.heightAnchor.constraint(equalToConstant: 100),

      leftStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConst.mainStackLeadingAnchor),
      leftStackView.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor, constant: 120),
      leftStackView.trailingAnchor.constraint(equalTo: centerLine.trailingAnchor, constant: -10),

      rightStackView.leadingAnchor.constraint(equalTo: centerLine.leadingAnchor, constant: UIConst.mainStackLeadingAnchor),
      rightStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConst.mainStackLeadingAnchor),
      rightStackView.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor, constant: 120),
    ])
  }

  // MARK: Make Bar Buttons
  private func setupNavigationItems(navigationItem: UINavigationItem) {
    navigationItem.rightBarButtonItems = makeRightBarButtons()
    navigationItem.leftBarButtonItems = makeLeftBarButtons()
  }
  
  private func setupBarButtons() {
    backBarButtonBlurView.contentView.addSubview(backBarButton)
    downloadBarButtonBlurView.contentView.addSubview(downloadBarButton)
    pauseBarButtonBlurView.contentView.addSubview(pauseBarButton)
    toggleContentModeButtonBlurView.contentView.addSubview(toggleContentModeButton)
  }
  
  private func makeRightBarButtons() -> [UIBarButtonItem] {
    let downloadBarButton = UIBarButtonItem(customView: downloadBarButtonBlurView)
    let pauseBarButton = UIBarButtonItem(customView: pauseBarButtonBlurView)
    let toggleContentModeButton = UIBarButtonItem(customView: toggleContentModeButtonBlurView)
    let barButtonItems = [toggleContentModeButton, downloadBarButton, pauseBarButton]
    return barButtonItems
  }
  
  private func makeLeftBarButtons() -> [UIBarButtonItem] {
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
      photoView.mainPhotoImageView.contentMode = .scaleAspectFit
      toggleContentModeButton.setImage(icon, for: .normal)
    } else {
      let icon = UIImage(systemName: .arrowUp)
      photoView.mainPhotoImageView.contentMode = .scaleAspectFill
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
      self.mainStackView.transform = transform
      self.leftStackView.transform = transform
      self.rightStackView.transform = transform
      self.centerLine.transform = transform
      self.photoInfoStackView.alpha = .zero
      self.leftStackView.alpha = .zero
      self.rightStackView.alpha = .zero
      self.centerLine.alpha = .zero
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
      self.leftStackView.alpha = UIConst.maxOpacity
      self.rightStackView.alpha = UIConst.maxOpacity
      self.centerLine.alpha = UIConst.alphaDefault
      let transform = CGAffineTransform(translationX: .zero, y: -120)
      self.mainStackView.transform = transform
      self.leftStackView.transform = transform
      self.rightStackView.transform = transform
      self.centerLine.transform = transform
      self.photoInfoStackView.isHidden = false
    }
  }
  
  // MARK: Helper
  func createdAt(from date: String) {
    guard let date = ISO8601DateFormatter().date(from: date) else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    let readableDate = dateFormatter.string(from: date)
    createdLabel.text = readableDate
  }
}
