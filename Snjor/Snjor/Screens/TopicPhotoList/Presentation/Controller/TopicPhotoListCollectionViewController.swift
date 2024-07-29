//
//  TopicPhotoListCollectionViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

//protocol TopicPhotoListCollectionViewControllerDelegate: AnyObject {
//  func didSelect(_ photo: Photo)
//}

final class TopicPhotoListCollectionViewController: UICollectionViewController {
  
  // MARK: - Internal Properties
  var topicID: String?
  var pageIndex: Int?
  var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?
  
  // MARK: - Delegate
//  private(set) weak var delegate: (any TopicPhotoListCollectionViewControllerDelegate)?
  
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
//    delegate: any TopicPhotoListCollectionViewControllerDelegate,
    layout: UICollectionViewLayout
  ) {
    self.viewModel = viewModel
//    self.delegate = delegate
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
    resetPage()
    registerSectionHeaderView()
    setupCollectionViewConstraints()
    setupDataSource()
    viewModel.viewDidLoad()
    stateController()
    configureDownloadSession()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    downloadService.invalidateSession(withID: Self.sessionID)
//    setNavigationBarHidden(false, animated: animated)
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
  
  private func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
    self.navigationController?.setNavigationBarHidden(hidden, animated: animated)
  }
  
  private func resetPage() {
    PrepareParameters.page = .zero
  }
  
  private func createDataSource(
    for collectionView: UICollectionView
    //    delegate: any PhotoCellDelegate
  ) {
    dataSource = UICollectionViewDiffableDataSource
    <Section, Photo>(collectionView: collectionView) { [weak self] collectionView, indexPath, photo in
      guard let strongSelf = self else { return UICollectionViewCell() }
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PhotoCell.reuseID,
        for: indexPath
      )
      guard let photoCell = cell as? PhotoCell else { return cell }
      let viewModelItem = strongSelf.viewModel.getTopicPhotoListViewModelItem(at: indexPath.item)
      photoCell.configure(viewModelItem: viewModelItem)
      return photoCell
    }
    dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
      guard kind == UICollectionView.elementKindSectionHeader else {
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


//protocol TopicPhotoListCollectionViewControllerDelegate: AnyObject {
//  func didSelect(_ photo: Photo)
//}
//
//final class TopicPhotoListCollectionViewController: UICollectionViewController {
//
//  // MARK: - Private Properties
//  var topicID: String?
//  var pageIndex: Int?
//  var photos: [Photo] = []
//  private var cancellable = Set<AnyCancellable>()
//  private(set) var downloadService = DownloadService()
//  private(set) var documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//  private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?
//  private var state = PassthroughSubject<StateController, Never>()
//  private let networkService = NetworkService()
//  private var lastPageValidationUseCase = LastPageValidationUseCase()
//
//  // MARK: - Delegate
////  private(set) weak var delegate: (any TopicPhotoListCollectionViewControllerDelegate)?
//
//  // MARK: - Initializers
//  init() {
//    super.init(collectionViewLayout: UICollectionViewLayout())
//    collectionView.collectionViewLayout = SingleColumnCascadeLayout(with: self)
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  deinit {
//    print("DEINIT")
//  }
//
//  // MARK: - View Lifecycle
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    registerSectionHeaderView()
//    setupDataSource()
//    fetchPhotos()
//    stateController()
//    configureDownloadSession()
//    setupCollectionViewConstraints()
//  }
//
//  private func setupCollectionViewConstraints() {
//    collectionView.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
//      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//    ])
//  }
//
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
////    setNavigationBarHidden(true, animated: animated)
//  }
//
//  override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
////    setNavigationBarHidden(false, animated: animated)
//  }
//
//  private func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
//    self.navigationController?.setNavigationBarHidden(hidden, animated: animated)
//  }
//
//  // MARK: - Private Methods
//  private func setupDataSource() {
//    dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: collectionView) { collectionView, indexPath, photo in
//      let cell = collectionView.dequeueReusableCell(
//        withReuseIdentifier: PhotoCell.reuseID,
//        for: indexPath
//      )
//      guard let photoCell = cell as? PhotoCell else { return cell }
////      photoCell.delegate = self
//      self.checkAndLoadMorePhotos(at: indexPath.item)
//      photoCell.configure(with: photo)
//      return photoCell
//    }
//
//    dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
//      guard kind == UICollectionView.elementKindSectionHeader else {
//        return nil
//      }
//      let headerView = collectionView.dequeueReusableSupplementaryView(
//        ofKind: kind,
//        withReuseIdentifier: SectionHeaderView.reuseID,
//        for: indexPath
//      ) as! SectionHeaderView
//      headerView.setImage()
//      return headerView
//    }
//  }
//
//  private func configureDownloadSession() {
//    downloadService.configureSession(delegate: self, id: Self.sessionID)
//  }
//
//  private func stateController() {
//    state
//      .receive(on: DispatchQueue.main)
//      .sink { [weak self] state in
//        guard let self = self else { return }
//        switch state {
//        case .success:
//          self.applySnapshot()
//        case .loading: break
//        case .fail(let error):
//          self.presentAlert(message: error, title: AppLocalized.error)
//        }
//      }
//      .store(in: &cancellable)
//  }
//
//  private func registerSectionHeaderView() {
//    collectionView.register(
//      SectionHeaderView.self,
//      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//      withReuseIdentifier: SectionHeaderView.reuseID
//    )
//    collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
//  }
//
//  private func fetchPhotos() {
//    state.send(.loading)
//    Task {
//      let result = await loadPhotos()
//      updateStateUI(with: result)
//    }
//  }
//
//  private func loadPhotos() async -> Result<[Photo], Error> {
//    let repository = LoadPageTopicsPhotoListRepository(networkService: networkService)
//    let loadUseCase = LoadTopicsPagePhotoListUseCase(repository: repository, topic: Topic(id: topicID ?? "", title: "Topic Name"))
//    return await loadUseCase.execute()
//  }
//
//  private func updateStateUI(with result: Result<[Photo], Error>) {
//    switch result {
//    case .success(let photos):
//      let existingPhotoIDs = self.photos.map { $0.id }
//      let newPhotos = photos.filter { !existingPhotoIDs.contains($0.id) }
//      lastPageValidationUseCase.updateLastPage(itemsCount: photos.count)
//      self.photos.append(contentsOf: newPhotos)
//      state.send(.success)
//    case .failure(let error):
//      state.send(.fail(error: error.localizedDescription))
//    }
//  }
//
//  private func checkAndLoadMorePhotos(at index: Int) {
//    lastPageValidationUseCase.checkAndLoadMoreItems(at: index, actualItems: photos.count) {
//      self.fetchPhotos()
//    }
//  }
//
//  private func applySnapshot() {
//    var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
//    snapshot.appendSections([.main])
//    snapshot.appendItems(photos)
//    dataSource?.apply(snapshot, animatingDifferences: true)
//  }
//}
//
//// MARK: - Section
//private enum Section: CaseIterable {
//  case main
//}
