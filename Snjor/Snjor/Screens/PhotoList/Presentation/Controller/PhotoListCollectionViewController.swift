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
    viewModel.viewDidLoad()

    collectionView.register(
      SectionHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: SectionHeaderView.reuseIdentifier
    )
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

class SectionHeaderView: UICollectionReusableView {

  static let reuseIdentifier = "SectionHeaderView"

  let label: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
      label.textColor = .label

      return label
  }()

  let mainImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  // MARK: - Применить конфигурации
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(mainImageView)
    addSubview(label)
    mainImageView.fillSuperView()
    label.fillSuperView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setImage(_ image: UIImage) {
    mainImageView.image = image
  }
}
