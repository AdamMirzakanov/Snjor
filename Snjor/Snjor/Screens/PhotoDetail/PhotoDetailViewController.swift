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
  private let viewModel: PhotoDetailViewModelProtocol

  // MARK: - Views
  private let screenView: PhotoDetailView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(PhotoDetailView())

  // MARK: - Initializers
  init(viewModel: PhotoDetailViewModelProtocol
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
    stateController()
    setupUI()
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
//          print()
          self.showSpinner()
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
          self.hideSpinner()
        }
      }
      .store(in: &cancellable)
  }

  private func configData() {
    screenView.setupView()
    screenView.photoImageView.setImageFromData(data: viewModel.imageData)
    screenView.nameLabel.text = viewModel.displayName
    screenView.likesLabel.text = viewModel.likes
    screenView.downloadsLabel.text = viewModel.downloads
    screenView.createdAt(from: viewModel.createdAt)
    screenView.cameraModelLabel.text = viewModel.cameraModel
    screenView.resolutionLabel.text = viewModel.resolution
    screenView.pxLabel.text = viewModel.pixels
    screenView.isoLabel.text = viewModel.iso
    screenView.focalLengthLabel.text = viewModel.focalLength
    screenView.apertureLabel.text = viewModel.aperture
    screenView.exposureTimeLabel.text = viewModel.exposureTime
    screenView.instagramUsernameLabel.text = viewModel.instagramUsername
    screenView.twitterUsernameLabel.text = viewModel.twitterUsername
  }

  private func setupUI() {
    view.addSubview(screenView)
    view.backgroundColor = .systemBackground

    NSLayoutConstraint.activate([
      screenView.topAnchor.constraint(equalTo: view.topAnchor),
      screenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      screenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      screenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}

extension PhotoDetailViewController: MessageDisplayable { }
extension PhotoDetailViewController: SpinnerDisplayable { }


