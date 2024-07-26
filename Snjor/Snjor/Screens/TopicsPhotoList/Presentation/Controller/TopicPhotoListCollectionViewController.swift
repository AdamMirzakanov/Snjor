//
//  TopicPhotoListCollectionViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

protocol TopicPhotoListCollectionViewControllerDelegate: AnyObject {
  func didSelect(_ photo: Photo)
}

final class TopicPhotoListCollectionViewController: UICollectionViewController {
  
  // MARK: - Private Properties
  var topicID: String?
  var pageIndex: Int?
  
  // MARK: - Delegate
  private(set) weak var delegate: (any TopicPhotoListCollectionViewControllerDelegate)?
  
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var downloadService = DownloadService()
  private(set) var viewModel: any TopicPhotoListViewModelProtocol
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  // MARK: - Views
  private let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      GradientView.Color(
        color: UIColor(white: 0, alpha: 1.0),
        location: 0.065
      ),
      GradientView.Color(
        color: .clear,
        location: 0.15
      ),
    ])
    $0.isUserInteractionEnabled = false
    return $0
  }(GradientView())
  
  // MARK: - Initializers
  init(
    viewModel: any TopicPhotoListViewModelProtocol,
    delegate: any TopicPhotoListCollectionViewControllerDelegate,
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
    setupViews()
    viewModel.viewDidLoad()
    stateController()
    setupDataSource()
    registerSectionHeaderView()
    configureDownloadSession()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    setNavigationBarHidden(false, animated: animated)
  }
  
  private func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
    self.navigationController?.setNavigationBarHidden(hidden, animated: animated)
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
  
  private func registerSectionHeaderView() {
    collectionView.register(
      SectionHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: SectionHeaderView.reuseID
    )
  }
  
  private func setupViews() {
    view.addSubview(gradientView)
    gradientView.fillSuperView()
  }
}
