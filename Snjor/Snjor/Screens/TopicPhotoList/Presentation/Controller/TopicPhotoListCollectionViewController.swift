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
  
  // MARK: - Internal Properties
  var topicID: String?
  var pageIndex: Int?
  var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?
  
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
  
  deinit {
    print("DEINIT \(Self.self)")
    cancellable.forEach { $0.cancel() }  
  }
  
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.bouncesZoom = true
    resetPage()
    registerSectionHeaderView()
    setupCollectionViewConstraints()
    setupDataSource()
    viewModel.viewDidLoad()
    stateController()
  }
  
  // MARK: - Private Methods
  private func setupDataSource() {
    createDataSource(
      for: collectionView
    )
  }
  
  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(viewModel.snapshot, animatingDifferences: true)
  }
  
  private func resetPage() {
    PrepareParameters.page = .zero
  }
  
  private func createDataSource(
    for collectionView: UICollectionView
  ) {
    dataSource = UICollectionViewDiffableDataSource<Section, Photo>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      guard
        let strongSelf = self,
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: TopicsPagePhotoListCell.reuseID,
          for: indexPath
        ) as? TopicsPagePhotoListCell
      else {
        return UICollectionViewCell()
      }
      let viewModelItem = strongSelf.viewModel.getTopicPhotoListViewModelItem(at: indexPath.item)
      cell.configure(viewModelItem: viewModelItem)
      return cell
    }
    
    dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
      guard 
        kind == UICollectionView.elementKindSectionHeader
      else {
        return nil
      }
      let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: SectionHeaderView.reuseID,
        for: indexPath
      ) as! SectionHeaderView
      headerView.setImage()
      return headerView
    }
  }

  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          self.applySnapshot()
        case .loading: break
        case .fail(error: let error):
          presentAlert(message: error, title: AppLocalized.error)
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
  
  private func setupCollectionViewConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
