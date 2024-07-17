//
//  PhotoListCollectionViewController.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit
import Combine

protocol PhotoListViewControllerDelegate: AnyObject {
  func didSelect(_ photo: Photo)
}

final class PhotoListCollectionViewController: UICollectionViewController {

  // MARK: - Delegate
  private(set) weak var delegate: (any PhotoListViewControllerDelegate)?

  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var downloadService = DownloadService()
  private(set) var viewModel: any PhotoListViewModelProtocol
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!

  // MARK: - Views
  let spinnerVisualEffectView: SpinnerVisualEffectView = {
    $0.frame.size.width = GlobalConst.fullValue
    $0.frame.size.height = GlobalConst.fullValue
    $0.effect = nil
    return $0
  }(SpinnerVisualEffectView(effect: UIBlurEffect(style: .regular)))

  // MARK: - Initializers
  init(
    viewModel: any PhotoListViewModelProtocol,
    delegate: any PhotoListViewControllerDelegate,
    layout: UICollectionViewLayout
  ) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(collectionViewLayout: layout)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    stateController()
    setupDataSource()
    configureDownloadSession()
    setupNavigationBarItems()
    viewModel.viewDidLoad()
  }

  // MARK: - Private Methods
  private func setupDataSource() {
    viewModel.createDataSource(
      for: collectionView,
      delegate: self
    )
  }

  private func configureDownloadSession() {
    downloadService.configureSession(
      delegate: self,
      id: Self.sessionID
    )
  }

  private func setupNavigationBarItems() {
    navigationItem.leftBarButtonItem = spinnerVisualEffectView.makeSpinnerBarItem()
  }

  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          viewModel.applySnapshot()
        case .loading: break
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }
}

extension PhotoListCollectionViewController: SessionIdentifiable { }
