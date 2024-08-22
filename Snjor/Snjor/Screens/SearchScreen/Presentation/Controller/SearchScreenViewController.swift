//
//  SearchScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit
import Combine

protocol SearchScreenViewControllerDelegate: AnyObject {
  func photoCellDidSelect(_ photo: Photo)
//  func topicCellDidSelect(_ topic: Topic)
//  func albumcCellDidSelect(_ album: Album)
}

final class SearchScreenViewController: BaseViewController<SearchScreenRootView> {
  
  // MARK: - Internal Properties
  var photosDataSource: UICollectionViewDiffableDataSource<PhotosSection, Photo>?
  var collectionsDataSource: UICollectionViewDiffableDataSource<CollectionsSection, CollectionsItem>?
  var photosSections: [PhotosSection] = []
  var collectionsSections: [CollectionsSection] = []
  var currentScopeIndex: Int = 0
  
  // MARK: - Private Properties
  
  lazy var searchController = UISearchController(searchResultsController: getController())
  private var cancellable = Set<AnyCancellable>()
  private(set) weak var delegate: (any SearchScreenViewControllerDelegate)?
  private(set) var downloadService = DownloadService()
  private(set) var photosViewModel: any PhotosViewModelProtocol
  private(set) var albumsViewModel: any AlbumsViewModelProtocol
  private(set) var topicsViewModel: any TopicsViewModelProtocol
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  func getController() -> UIViewController {
    let factory = SearchResultScreenFactory()
    let modul = factory.makeModule()
    return modul
  }
  
  // MARK: - Initializers
  init(
    photosViewModel: any PhotosViewModelProtocol,
    albumsViewModel: any AlbumsViewModelProtocol,
    topicsViewModel: any TopicsViewModelProtocol,
    delegate: any SearchScreenViewControllerDelegate
  ) {
    self.photosViewModel = photosViewModel
    self.albumsViewModel = albumsViewModel
    self.topicsViewModel = topicsViewModel
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionViewDelegate()
    photosViewModel.viewDidLoad()
    albumsViewModel.viewDidLoad()
    topicsViewModel.viewDidLoad()
    stateController()
    setupDataSource()
    configureDownloadSession()
    setupVisibleContainers()
    configureSearchController()
    setupNavigationItem()
  }
  
  // MARK: - Private Methods
  private func setupVisibleContainers() {
    rootView.albumsCollectionView.removeFromSuperview()
  }
  
  private func setupCollectionViewDelegate() {
    rootView.photosCollectionView.delegate = self
    rootView.albumsCollectionView.delegate = self
  }
  
  private func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.automaticallyShowsSearchResultsController = true
    searchController.searchBar.showsScopeBar = true
    searchController.searchBar.scopeButtonTitles = [
      "Photos",
      "Collections",
      "Users"
    ]
    searchController.searchBar.placeholder = "Search photos, collections, users"
    navigationItem.hidesSearchBarWhenScrolling = true
  }
  
  private func setupNavigationItem() {
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.title = "Photos"
    navigationItem.searchController = searchController
  }
  
  private func setupDataSource() {
    createPhotosDataSource(
      for: rootView.photosCollectionView,
      delegate: self
    )
    createCollectionsDataSource(
      for: rootView.albumsCollectionView
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
    topicsState()
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
  
  private func topicsState() {
    topicsViewModel
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
}
