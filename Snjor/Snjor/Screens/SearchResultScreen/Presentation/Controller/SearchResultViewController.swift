//
//  SearchResultViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.08.2024.
//

import UIKit
import Combine

final class SearchResultViewController: MainViewController<SearchResultScreenRootView> {
  
  // MARK: Internal Properties
  var photosDataSource: UICollectionViewDiffableDataSource<SearchResultPhotosSection, Photo>?
  var collectionsDataSource: UICollectionViewDiffableDataSource<AlbumsSection, Album>?
  var photosSections: [SearchResultPhotosSection] = []
  var collectionsSections: [AlbumsSection] = []
  var currentScopeIndex: Int
  var photosViewModel: any SearchViewModelProtocol <Photo>
  var albumsViewModel: any SearchViewModelProtocol <Album>
  var currentSearchTerm: String?
  
  // MARK: Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) weak var delegate: (any SearchResultViewControllerDelegate)?
  private(set) var downloadService = DownloadService()
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  // MARK: Initializers
  init(
    currentScopeIndex: Int,
    photosViewModel: any SearchViewModelProtocol <Photo>,
    albumsViewModel: any SearchViewModelProtocol <Album>,
    delegate: any SearchResultViewControllerDelegate
  ) {
    self.currentScopeIndex = currentScopeIndex
    self.photosViewModel = photosViewModel
    self.albumsViewModel = albumsViewModel
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  deinit {
    print(#function, Self.self, "🔴")
  }
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionViewDelegate()
    stateController()
    setupDataSource()
    configureDownloadSession()
    setupVisibleContainers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationItems()
    setupNavigationTitle()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    resetSearchState()
  }
  
  // MARK: Internal Methods
  func resetSearchState() {
    if self.isMovingFromParent {
      PrepareParameters.searchPhotosPage = .zero
      PrepareParameters.searchAlbumsPage = .zero
      photosDataSource = nil
      photosSections.removeAll()
      currentScopeIndex = .zero
      cancellable.removeAll()
      downloadService.invalidateSession(withID: Self.sessionID)
    }
  }
  
  func fetchMatchingItems(with searchTerm: String) {
    self.currentSearchTerm = searchTerm
    switch currentScopeIndex {
    case .discover:
      photosViewModel.executeSearch(with: searchTerm)
    case .topicAndAlbums:
      albumsViewModel.executeSearch(with: searchTerm)
    default:
      print(#function)
    }
  }
  
  // MARK: Private Methods
  private func setupVisibleContainers() {
    switch currentScopeIndex {
    case .discover:
      rootView.albumsCollectionView.removeFromSuperview()
      rootView.addSubview(rootView.photosCollectionView)
      rootView.photosCollectionView.fillSuperView()
    case .topicAndAlbums:
      rootView.photosCollectionView.removeFromSuperview()
      rootView.addSubview(rootView.albumsCollectionView)
      rootView.albumsCollectionView.fillSuperView()
    default:
      print(#function)
    }
  }
  
  private func setupCollectionViewDelegate() {
    rootView.photosCollectionView.delegate = self
    rootView.albumsCollectionView.delegate = self
  }
  
  private func setupDataSource() {
    createPhotosDataSource(
      for: rootView.photosCollectionView,
      delegate: self
    )
    createCollectionsDataSource(
      for: rootView.albumsCollectionView,
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
    photosState()
    albumsState()
  }
  
  private func photosState() {
    photosViewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        self.handleState(state) {
          self.applyPhotosSnapshot()
        }
      }
      .store(in: &cancellable)
  }
  
  private func albumsState() {
    albumsViewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        self.handleState(state) {
          self.applyCollectionsSnapshot()
        }
      }
      .store(in: &cancellable)
  }
  
  private func handleState(
    _ state: StateController,
    successAction: () -> Void
  ) {
    switch state {
    case .success:
      successAction()
    case .loading: break
    case .fail(error: let error):
      presentAlert(message: error, title: AppLocalized.error)
    }
  }
  
  private func setupNavigationItems() {
    rootView.setupBarButtonItems(
      navigationItem: navigationItem,
      navigationController: navigationController
    )
  }
  
  private func setupNavigationTitle() {
    navigationItem.title = currentSearchTerm
  }
}
