//
//  SearchResultScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.08.2024.
//

import UIKit
import Combine

protocol SearchResultScreenViewControllerDelegate: AnyObject {
  func searchPhotoCellDidSelect(_ photo: Photo)
  func searchAlbumcCellDidSelect(_ album: Album)
}

final class SearchResultScreenViewController: BaseViewController<SearchResultScreenRootView> {
  
  // MARK: - Internal Properties
  var photosDataSource: UICollectionViewDiffableDataSource<SearchResultPhotosSection, Photo>?
  var collectionsDataSource: UICollectionViewDiffableDataSource<SearchResultCollectionsSection, Album>?
  var photosSections: [SearchResultPhotosSection] = []
  var collectionsSections: [SearchResultCollectionsSection] = []
  var currentScopeIndex: Int = .zero
  var photosViewModel: any SearchResultPhotosViewModelProtocol
  var albumsViewModel: any SearchResultAlbumsViewModelProtocol
  
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) weak var delegate: (any SearchResultScreenViewControllerDelegate)?
  private(set) var downloadService = DownloadService()
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  // MARK: - Initializers
  init(
    photosViewModel: any SearchResultPhotosViewModelProtocol,
    albumsViewModel: any SearchResultAlbumsViewModelProtocol,
    delegate: any SearchResultScreenViewControllerDelegate
  ) {
    self.photosViewModel = photosViewModel
    self.albumsViewModel = albumsViewModel
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print(#function, Self.self)
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionViewDelegate()
    stateController()
    setupDataSource()
    configureDownloadSession()
    setupVisibleContainers()
    setupNavigationItem()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    PrepareParameters.searchPhotosPage = .zero
    PrepareParameters.searchAlbumsPage = .zero
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if self.isMovingFromParent {
      resetSearchState()
    }
  }
  
  // MARK: - Internal Methods
  func resetSearchState() {
    photosDataSource = nil
    photosSections.removeAll()
    currentScopeIndex = .zero
    cancellable.removeAll()
    downloadService.invalidateSession(withID: Self.sessionID)
  }
  
  func fetchMatchingItems(with searchTerm: String) {
//    photosViewModel.loadSearchPhotos(with: searchTerm)
    albumsViewModel.loadSearchAlbums(with: searchTerm)
  }
  
  // MARK: - Private Methods
  private func setupVisibleContainers() {
//    rootView.albumsCollectionView.removeFromSuperview()
  }
  
  private func setupCollectionViewDelegate() {
    rootView.photosCollectionView.delegate = self
  }
  
  private func setupNavigationItem() {
    navigationItem.hidesSearchBarWhenScrolling = false
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
//    photosState()
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
}
