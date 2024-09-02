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
  func topicCellDidSelect(_ topic: Topic)
  func albumcCellDidSelect(_ album: Album)
  func searchButtonClicked(with searchTerm: String, currentScopeIndex: Int)
}

final class SearchScreenViewController: MainViewController<SearchScreenRootView> {
  
  // MARK: - Internal Properties
  var photosDataSource: UICollectionViewDiffableDataSource<PhotosSection, Photo>?
  var collectionsDataSource: UICollectionViewDiffableDataSource<TopicsAndAlbumsSection, CollectionsItem>?
  var photosSections: [PhotosSection] = []
  var collectionsSections: [TopicsAndAlbumsSection] = []
  var currentScopeIndex: Int = .zero
  
  // MARK: - Private Properties
  lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.obscuresBackgroundDuringPresentation = true
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.showsScopeBar = true
    searchController.searchBar.delegate = self
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchBar.placeholder = "Search photos"
    searchController.searchBar.scopeButtonTitles = [
      "Photos",
      "Collections",
      "Users"
    ]
    return searchController
  }()
  
  private var cancellable = Set<AnyCancellable>()
  private(set) weak var delegate: (any SearchScreenViewControllerDelegate)?
  private(set) var downloadService = DownloadService()
  private(set) var photosViewModel: any SearchViewModelProtocol <Photo>
  private(set) var albumsViewModel: any SearchViewModelProtocol <Album>
  private(set) var topicsViewModel: any ContentManagingProtocol <Topic>
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  // MARK: - Initializers
  init(
    photosViewModel: any SearchViewModelProtocol <Photo>,
    albumsViewModel: any SearchViewModelProtocol <Album>,
    topicsViewModel: any ContentManagingProtocol <Topic>,
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    showCustomTabBar()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    hideCustomTabBar()
    searchController.isActive = false
  }
  
  // MARK: - Internal Methods
  func hideCustomTabBar() {
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }
  
  func showCustomTabBar() {
    if let tabBar = self.tabBarController as? MainTabBarController {
      tabBar.showCustomTabBar()
    }
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
