//
//  PhotoDetailViewController.swift
//  Snjor
//
//  Created by Адам on 18.06.2024.
//

import UIKit
import Combine

// swiftlint:disable all
class PhotoDetailViewController: UIViewController {
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private let viewModel: any PhotoDetailViewModelProtocol
  private var isAspectFill = true
  private var isPhotoInfo = true

  // MARK: - Views
  private let uiContainerView: ContainerView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .systemBackground
    return $0
  }(ContainerView())

  // MARK: - Back Bar Button
  private let backBarButtonBlurView: UIVisualEffectView = {
    $0.frame = CGRect(
      x: .zero,
      y: .zero,
      width: UIConst.buttonHeight,
      height: UIConst.buttonHeight
    )
    $0.layer.cornerRadius = UIConst.backButtonBlurViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  private lazy var backBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .backBarButtonImage), for: .normal)
    $0.tintColor = .label
    $0.alpha = UIConst.alpha
    $0.frame = backBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: - Download Bar Button
  private let downloadBarButtonBlurView: UIVisualEffectView = {
    $0.frame = CGRect(
      x: .zero,
      y: .zero,
      width: UIConst.buttonWidth,
      height: UIConst.buttonHeight
    )
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  private lazy var downloadBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .downloadBarButtonImage), for: .normal)
    $0.setTitle(.jpeg, for: .normal)
    $0.titleLabel?.font = .systemFont(
      ofSize: UIConst.defaultFontSize,
      weight: .regular
    )
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alpha
    $0.frame = downloadBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: - Toggle Content Mode Button
  private let toggleContentModeButtonBlurView: UIVisualEffectView = {
    $0.frame = CGRect(
      x: .zero,
      y: .zero,
      width: UIConst.buttonHeight,
      height: UIConst.buttonHeight
    )
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  private lazy var toggleContentModeButton: UIButton = {
    let icon = UIImage(systemName: .arrowUp)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alpha
    $0.frame = toggleContentModeButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: - Initializers
  init(viewModel: any PhotoDetailViewModelProtocol
  ) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    stateController()
    configData()
    hidePhotoInfo()
    viewModel.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.showCustomTabBar()
    }
  }

  // MARK: - Private Methods
  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        self.hideSpinner()
        switch state {
        case .success:
          self.configData()
        case .loading:
          //          self.showSpinner()
          print()
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
          self.hideSpinner()
        }
      }
      .store(in: &cancellable)
  }

  private func configData() {
    uiContainerView.setupView()
    uiContainerView.mainPhotoImageView.setImageFromData(data: viewModel.backgroundImageData)
    uiContainerView.profilePhotoImageView.setImageFromData(data: viewModel.backgroundImageData)
    uiContainerView.nameLabel.text = viewModel.displayName
    uiContainerView.likesLabel.text = viewModel.likes
    uiContainerView.downloadsLabel.text = viewModel.downloads
    uiContainerView.viewsLabel.text = viewModel.views
    uiContainerView.createdAt(from: viewModel.createdAt)
    uiContainerView.cameraModelLabel.text = viewModel.cameraModel
    uiContainerView.resolutionLabel.text = viewModel.resolution
    uiContainerView.pxLabel.text = viewModel.pixels
    uiContainerView.isoLabel.text = viewModel.iso
    uiContainerView.focalLengthLabel.text = viewModel.focalLength
    uiContainerView.apertureLabel.text = viewModel.aperture
    uiContainerView.exposureTimeLabel.text = viewModel.exposureTime
  }

  private func setupUI() {
    setupBarButtonItems()
    configActions()
    view.addSubview(uiContainerView)
    NSLayoutConstraint.activate([
      uiContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      uiContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      uiContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      uiContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  private func setupBarButtonItems() {
    let toggleContentModeButton = makeToggleContentModeButton()
    let downloadBarButton = makeDownloadBarButton()
    let backBarButton = makeBackBarButton()
    navigationItem.rightBarButtonItems = [toggleContentModeButton, downloadBarButton]
    navigationItem.leftBarButtonItems = [backBarButton]
  }

  private func makeBackBarButton() -> UIBarButtonItem {
    backBarButtonBlurView.contentView.addSubview(backBarButton)
    return UIBarButtonItem(customView: backBarButtonBlurView)
  }

  private func makeDownloadBarButton() -> UIBarButtonItem {
    downloadBarButtonBlurView.contentView.addSubview(downloadBarButton)
    return UIBarButtonItem(customView: downloadBarButtonBlurView)
  }

  private func makeToggleContentModeButton() -> UIBarButtonItem {
    toggleContentModeButtonBlurView.contentView.addSubview(toggleContentModeButton)
    return UIBarButtonItem(customView: toggleContentModeButtonBlurView)
  }


  // MARK: -

  private func configActions() {
    configInfoButtonAction()
    configBackButtonAction()
    configDownloadButtonAction()
    configToggleContentModeButtonAction()
  }

  private func configInfoButtonAction() {
    let infoButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.isPhotoInfo ? self.showPhotoInfo() : self.hidePhotoInfo()
      self.isPhotoInfo.toggle()
    }
    uiContainerView.infoButton.addAction(infoButtonAction, for: .touchUpInside)
  }

  private func configBackButtonAction() {
    let backButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.navigationController?.popViewController(animated: true)
    }
    backBarButton.addAction(backButtonAction, for: .touchUpInside)
  }

  private func configDownloadButtonAction() {
    let downloadButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      //code:
    }
    downloadBarButton.addAction(downloadButtonAction, for: .touchUpInside)
  }

  private func configToggleContentModeButtonAction() {
    let toggleContentModeButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      if self.isAspectFill {
        let icon = UIImage(systemName: .arrowDown)
        self.uiContainerView.mainPhotoImageView.contentMode = .scaleAspectFit
        self.toggleContentModeButton.setImage(icon, for: .normal)
      } else {
        let icon = UIImage(systemName: .arrowUp)
        self.uiContainerView.mainPhotoImageView.contentMode = .scaleAspectFill
        self.toggleContentModeButton.setImage(icon, for: .normal)
      }
      self.isAspectFill.toggle()
    }
    toggleContentModeButton.addAction(toggleContentModeButtonAction, for: .touchUpInside)
  }

  private func hidePhotoInfo() {
    UIView.animate(withDuration: 0.4) {
      self.uiContainerView.profileStackView.transform = CGAffineTransform(translationX: 0, y: -10)
      self.uiContainerView.photoInfoStackView.transform = CGAffineTransform(translationX: 0, y: 100)
      self.uiContainerView.gradientView.alpha = 0.4
      self.uiContainerView.photoInfoStackView.alpha = 0
      self.uiContainerView.photoInfoStackView.isHidden = true
    }
  }

  private func showPhotoInfo() {
    UIView.animate(withDuration: 0.3) {
      self.uiContainerView.gradientView.alpha = 1
    } completion: { _ in
      //      UIView.animate(withDuration: 0.3) {
      //        self.uiContainerView.photoInfoStackView.alpha = 1
      //      }
    }

    UIView.animate(withDuration: 0.3) {
      self.uiContainerView.photoInfoStackView.alpha = 1
    }

    UIView.animate(
      withDuration: 0.7,
      delay: 0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 0.5
    ) {
      self.uiContainerView.mainStackView.transform = .identity
      self.uiContainerView.photoInfoStackView.transform = .identity
      self.uiContainerView.photoInfoStackView.isHidden = false
    }
  }
}

// MARK: - MessageDisplayable
extension PhotoDetailViewController: MessageDisplayable { }

// MARK: - SpinnerDisplayable
extension PhotoDetailViewController: SpinnerDisplayable { }

