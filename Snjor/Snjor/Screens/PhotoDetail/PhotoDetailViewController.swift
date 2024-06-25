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

  private var cancellable = Set<AnyCancellable>()
  private let viewModel: PhotoDetailViewModelProtocol


  init(viewModel: PhotoDetailViewModelProtocol
  ) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: -
  override func viewDidLoad() {
    super.viewDidLoad()

    stateController()
    setupUI()
    viewModel.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomBar()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.showCustomBar()
    }
  }

  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        self.hideSpinner()
        switch state {
        case .success:
          guard let photo = viewModel.photo else { return }
          screenView.setupView()
          screenView.updateUI(with: photo)
        case .loading:
          self.showSpinner()
          print()
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
          self.hideSpinner()
        }
      }
      .store(in: &cancellable)
  }

  private let screenView: PhotoDetailView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(PhotoDetailView())

  func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(screenView)

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
