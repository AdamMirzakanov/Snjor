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

  // MARK: - Views
  private let uiContainerView: ContainerView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .systemBackground
    return $0
  }(ContainerView())

  private let backBarButtonBlurView: UIVisualEffectView = {
    $0.frame = CGRect(
      x: .zero,
      y: .zero,
      width: UIConst.downloadButtonHeight,
      height: UIConst.downloadButtonHeight
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

  private let downloadBarButtonBlurView: UIVisualEffectView = {
    $0.frame = CGRect(
      x: .zero,
      y: .zero,
      width: UIConst.downloadButtonWidth,
      height: UIConst.downloadButtonHeight
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
          self.showSpinner()
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
          self.hideSpinner()
        }
      }
      .store(in: &cancellable)
  }

  private func configData() {
    uiContainerView.setupView()
    uiContainerView.photoImageView.setImageFromData(data: viewModel.imageData)
    uiContainerView.profilePhotoImageView.setImageFromData(data: viewModel.imageData)
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
    setupBackButton()
    setupDownloadButton()
    view.addSubview(uiContainerView)
    NSLayoutConstraint.activate([
      uiContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      uiContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      uiContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      uiContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }

  private func setupBackButton() {
    backBarButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    backBarButtonBlurView.contentView.addSubview(backBarButton)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButtonBlurView)
  }

  private func setupDownloadButton() {
    downloadBarButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
    downloadBarButtonBlurView.contentView.addSubview(downloadBarButton)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: downloadBarButtonBlurView)
  }

  @objc private func backButtonTapped() {
    navigationController?.popViewController(animated: true)
  }

  @objc private func downloadButtonTapped() {
    print(#function)
  }
}

// MARK: - MessageDisplayable
extension PhotoDetailViewController: MessageDisplayable { }

// MARK: - SpinnerDisplayable
extension PhotoDetailViewController: SpinnerDisplayable { }
