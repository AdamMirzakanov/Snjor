//
//  SearchResultScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.08.2024.
//

import UIKit
import Combine

protocol SearchResultScreenViewControllerDelegate: AnyObject {
  func photoCellDidSelect(_ photo: Photo)
  func topicCellDidSelect(_ topic: Topic)
  func albumcCellDidSelect(_ album: Album)
}

final class SearchResultScreenViewController: BaseViewController<SearchResultScreenRootView> {
  
  // MARK: - Internal Properties
  var photosDataSource: UICollectionViewDiffableDataSource<PhotosSection, Photo>?
  var photosSections: [PhotosSection] = []
  var currentScopeIndex: Int = 0
  
  // MARK: - Private Properties
  private let searchController = UISearchController()
  private var cancellable = Set<AnyCancellable>()
  private(set) weak var delegate: (any SearchResultScreenViewControllerDelegate)?
  private(set) var downloadService = DownloadService()
  private(set) var photosViewModel: any SearchResultPhotosViewModelProtocol
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  // MARK: - Initializers
  init(
    photosViewModel: any SearchResultPhotosViewModelProtocol
  ) {
    self.photosViewModel = photosViewModel
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
    stateController()
    setupDataSource()
    configureDownloadSession()
    setupVisibleContainers()
    configureSearchController()
    setupNavigationItem()
    rootView.backgroundColor = .systemBrown
  }
  
  // MARK: - Internal Methods
  func fetchMatchingItems() {
    let searchTerm = searchController.searchBar.text ?? .empty
    if searchTerm.isEmpty == false {
      photosViewModel.loadSearchPhotos(with: searchTerm)
    }
  }
  
  // MARK: - Private Methods
  private func setupVisibleContainers() {
    rootView.albumsCollectionView.removeFromSuperview()
  }
  
  private func setupCollectionViewDelegate() {
    rootView.photosCollectionView.delegate = self
  }
  
  private func configureSearchController() {
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
  }
  
  private func configureDownloadSession() {
    downloadService.configureSession(
      delegate: self,
      id: Self.sessionID
    )
  }
  
  private func stateController() {
    photosState()
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
