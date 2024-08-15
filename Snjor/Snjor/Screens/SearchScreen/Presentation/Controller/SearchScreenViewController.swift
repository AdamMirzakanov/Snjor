//
//  SearchScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit
import Combine

protocol PhotosCollectionViewControllerDelegate: AnyObject {
  func didSelect(_ photo: Photo)
}

final class SearchScreenViewController: BaseViewController<SearchScreenRootView> {
  
  // MARK: - Internal Properties
  var photosDataSource: UICollectionViewDiffableDataSource<PhotoListSection, Photo>?
  var collectionsDataSource: UICollectionViewDiffableDataSource<CollectionsSection, Item>?
  var photosSections: [PhotoListSection] = []
  var collectionsSections: [CollectionsSection] = []
  
  // MARK: - Private Properties
  private let searchController = UISearchController()
  private var cancellable = Set<AnyCancellable>()
  private(set) weak var delegate: (any PhotosCollectionViewControllerDelegate)?
  private(set) var downloadService = DownloadService()
  private(set) var photosViewModel: any PhotosViewModelProtocol
  private(set) var albumsViewModel: any AlbumsViewModelProtocol
  private(set) var topicsViewModel: any TopicsPageViewModelProtocol
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  // MARK: - Initializers
  init(
    photosViewModel: any PhotosViewModelProtocol,
    albumsViewModel: any AlbumsViewModelProtocol,
    topicsViewModel: any TopicsPageViewModelProtocol,
    delegate: any PhotosCollectionViewControllerDelegate
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
    rootView.photosCollectionView.delegate = self
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

extension SearchScreenViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let delegate = delegate else { return }
    let photo = photosViewModel.getPhoto(at: indexPath.item)
    delegate.didSelect(photo)
  }
}













































//extension SearchScreenViewController {
//  // MARK: - UIScrollViewDelegate
//  override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
//    return .bottom
//  }
//
//  override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//    if let tabBar = tabBarController as? MainTabBarController {
//      tabBar.hideCustomTabBar()
//    }
//  }
//
//  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//    if let tabBar = tabBarController as? MainTabBarController {
//      tabBar.showCustomTabBar()
//    }
//  }
//
//  override func scrollViewDidEndDragging(
//    _ scrollView: UIScrollView,
//    willDecelerate decelerate: Bool
//  ) {
//    if !decelerate {
//      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//        if let tabBar = self.tabBarController as? MainTabBarController {
//          tabBar.showCustomTabBar()
//        }
//      }
//    }
//  }
//}

//extension SearchScreenViewController {
//  override func collectionView(
//    _ collectionView: UICollectionView,
//    didSelectItemAt indexPath: IndexPath
//  ) {
//    guard let delegate = delegate else { return }
//    let photo = photosViewModel.getPhoto(at: indexPath.item)
//    delegate.didSelect(photo)
//  }
//}
