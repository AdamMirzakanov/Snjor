//
//  SearchScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit
import Combine

final class SearchScreenViewController: BaseViewController<SearchScreenRootView> {

  // MARK: - Internal Properties
  var photosDataSource: UICollectionViewDiffableDataSource<PhotoListSection, Photo>?
  var collectionsDataSource: UICollectionViewDiffableDataSource<CollectionsSection, Item>?
//  var topicsDataSource: UICollectionViewDiffableDataSource<CollectionsSection, Topic>?
  
  var photosSections: [PhotoListSection] = []
  var albumsSections: [CollectionsSection] = [.albums]
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    photosViewModel.viewDidLoad()
    albumsViewModel.viewDidLoad()
    
    stateController()
    setupDataSource()
    configureDownloadSession()
    
    view.backgroundColor = .systemBackground
    navigationItem.searchController = searchController
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.automaticallyShowsSearchResultsController = true
    searchController.searchBar.showsScopeBar = true
    navigationItem.hidesSearchBarWhenScrolling = false
    
    searchController.searchBar.scopeButtonTitles = [
      "Photos",
      "Collections"
    ]
    
    setupVisibleContainers()
  }
  
  private func setupVisibleContainers() {
    rootView.albumsCollectionView.removeFromSuperview()
  }
  
  // MARK: - Private Methods
  private func setupDataSource() {
    createPhotosDataSource(
      for: rootView.photosCollectionView,
      delegate: self
    )
    createAlbumsDataSource(
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
    photosViewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          applyPhotosSnapshot()
        case .loading: break
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
    
    albumsViewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          applyAlbumsSnapshot()
        case .loading: break
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
    
    topicsViewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          applyAlbumsSnapshot()
        case .loading: break
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }
}































// MARK: - Extension














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
