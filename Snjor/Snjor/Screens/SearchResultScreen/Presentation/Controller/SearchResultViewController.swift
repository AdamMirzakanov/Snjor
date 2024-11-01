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
  var photosDataSource: SearchResultPhotosDataSource?
  var albumsDataSource: SearchResultAlbumsDataSource?
  var usersDataSource: SearchResultUsersDataSource?
  var photosSections: [SearchResultPhotosSection] = []
  var albumsSections: [SearchResultAlbumsSection] = []
  var usersSections: [SearchResultUsersSection] = []
  var currentScopeIndex: Int
  var photosViewModel: any SearchViewModelProtocol<Photo>
  var albumsViewModel: any SearchViewModelProtocol<Album>
  var usersViewModel: any SearchViewModelProtocol<User>
  var currentSearchTerm: String?
  
  // MARK: Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) weak var delegate: (any SearchResultViewControllerDelegate)?
  private(set) var downloadService = DownloadService()
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  // MARK: Override Properties
  override var shouldShowTabBarOnScroll: Bool {
    return false
  }
  
  // MARK: Initializers
  init(
    currentScopeIndex: Int,
    photosViewModel: any SearchViewModelProtocol<Photo>,
    albumsViewModel: any SearchViewModelProtocol<Album>,
    usersViewModel: any SearchViewModelProtocol<User>,
    delegate: any SearchResultViewControllerDelegate
  ) {
    self.currentScopeIndex = currentScopeIndex
    self.photosViewModel = photosViewModel
    self.albumsViewModel = albumsViewModel
    self.usersViewModel = usersViewModel
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionViewDelegate()
    stateController()
    setupDataSource()
    setupVisibleContainers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureDownloadSession()
    setupNavigationItems()
    setupNavigationTitle()
    hideCustomTabBar()
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
    }
    downloadService.invalidateSession(withID: Self.sessionID)
  }
  
  func fetchMatchingItems(with searchTerm: String) {
    self.currentSearchTerm = searchTerm
    switch currentScopeIndex {
    case .discover:
      photosViewModel.executeSearch(with: searchTerm)
    case .topicAndAlbums:
      albumsViewModel.executeSearch(with: searchTerm)
    default:
      usersViewModel.executeSearch(with: searchTerm)
    }
  }
  
  // MARK: Private Methods
  private func setupVisibleContainers() {
    switch currentScopeIndex {
    case .discover:
      configureForPhotosMode()
    case .topicAndAlbums:
      configureForAlbumsMode()
    default:
      configureForUsersMode()
    }
  }
  
  private func configureForPhotosMode() {
    rootView.albumsCollectionView.removeFromSuperview()
    rootView.usersTableViewView.removeFromSuperview()
    rootView.addSubview(rootView.photosCollectionView)
    rootView.photosCollectionView.fillSuperView()
  }
  
  private func configureForAlbumsMode() {
    rootView.photosCollectionView.removeFromSuperview()
    rootView.usersTableViewView.removeFromSuperview()
    rootView.addSubview(rootView.albumsCollectionView)
    rootView.albumsCollectionView.fillSuperView()
  }
  
  private func configureForUsersMode() {
    rootView.photosCollectionView.removeFromSuperview()
    rootView.albumsCollectionView.removeFromSuperview()
    rootView.addSubview(rootView.usersTableViewView)
    rootView.usersTableViewView.fillSuperView()
  }

  private func setupCollectionViewDelegate() {
    rootView.photosCollectionView.delegate = self
    rootView.albumsCollectionView.delegate = self
    rootView.usersTableViewView.delegate = self
  }
  
  private func setupDataSource() {
    createPhotosDataSource(
      for: rootView.photosCollectionView,
      delegate: self
    )
    createAlbumsDataSource(
      for: rootView.albumsCollectionView,
      delegate: self
    )
    createUsersDataSource(
      for: rootView.usersTableViewView
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
    usersState()
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
          self.applyAlbumsSnapshot()
        }
      }
      .store(in: &cancellable)
  }
  
  private func usersState() {
    usersViewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        self.handleState(state) {
          self.applyUsersSnapshot()
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
      showError(error: error)
    }
  }
  
  private func showError(error: String) {
    guard let navigationController = navigationController else { return }
    navigationItem.rightBarButtonItem?.isHidden = true
    navigationItem.leftBarButtonItem?.isHidden = true
    navigationItem.title = .empty
    rootView.photosCollectionView.isHidden = true
    rootView.albumsCollectionView.isHidden = true
    rootView.usersTableViewView.isHidden = true
    showError(error: error, navigationController: navigationController)
  }
  
  private func setupNavigationItems() {
    rootView.setupBarButtonItems(
      navigationItem: navigationItem,
      navigationController: navigationController
    )
  }
  
  private func setupNavigationTitle() {
    navigationItem.title = .hash + (currentSearchTerm ?? .empty)
  }
}
