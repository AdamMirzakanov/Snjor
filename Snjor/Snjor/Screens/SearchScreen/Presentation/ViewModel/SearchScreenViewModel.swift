////
////  SearchScreenViewModel.swift
////  Snjor
////
////  Created by Адам Мирзаканов on 07.08.2024.
////
//
//import UIKit
//import Combine
//
//final class SearchScreenViewModel: SearchScreenViewModelProtocol {
//
//  // MARK: - Private Properties
//  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
//  private(set) var state: PassthroughSubject<StateController, Never>
//  
//  // MARK: - Initializers
//  init(
//    state: PassthroughSubject<StateController, Never>,
//    loadPhotosUseCase: any LoadPhotosUseCaseProtocol,
//    loadAlbumsUseCase: any LoadAlbumsUseCaseProtocol,
//    lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
//  ) {
//    self.state = state
//    self.loadPhotosUseCase = loadPhotosUseCase
//    self.loadAlbumsUseCase = loadAlbumsUseCase
//    self.lastPageValidationUseCase = lastPageValidationUseCase
//  }
//
//  // MARK: - viewDidLoad
//  func viewDidLoad() {
//    loadPhotos()
//    loadAlbums()
//  }
//  
//  // MARK: - Photos
//  // MARK:  Private Properties
//  private let loadPhotosUseCase: any LoadPhotoListUseCaseProtocol
//  private var photosDataSource: UICollectionViewDiffableDataSource<PhotosSection, Photo>?
//  private var photos: [Photo] = []
//  private var photosSections: [PhotosSection] = []
//  private var photosSnapshot: NSDiffableDataSourceSnapshot<PhotosSection, Photo> {
//    var snapshot = NSDiffableDataSourceSnapshot<PhotosSection, Photo>()
//    snapshot.appendSections([.main])
//    snapshot.appendItems(photos, toSection: .main)
//    photosSections = snapshot.sectionIdentifiers
//    return snapshot
//  }
//  
//  // MARK:  Internal Methods
//  func createPhotosDataSource(
//    for collectionView: UICollectionView,
//    delegate: any PhotoCellDelegate
//  ) {
//    photosDataSource = UICollectionViewDiffableDataSource<PhotosSection, Photo>(
//      collectionView: collectionView
//    ) { [weak self] collectionView, indexPath, photo in
//      let defaultCell = UICollectionViewCell()
//      guard let strongSelf = self else { return defaultCell }
//      let section = strongSelf.photosSections[indexPath.section]
//      switch section {
//      case .main:
//        return strongSelf.configurePhotoCell(
//          collectionView: collectionView,
//          indexPath: indexPath,
//          photo: photo,
//          delegate: delegate
//        )
//      }
//    }
//  }
//  
//  func applyPhotosSnapshot() {
//    guard let dataSource = photosDataSource else { return }
//    dataSource.apply(
//      photosSnapshot,
//      animatingDifferences: true
//    )
//  }
//  
//  func getPhoto(at indexPath: Int) -> Photo {
//    photos[indexPath]
//  }
//  
//  // MARK:  Private Methods
//  private func loadPhotos() {
//    state.send(.loading)
//    Task {
//      await loadPhotosUseCase()
//    }
//  }
//  
//  private func loadPhotosUseCase() async {
//    let result = await loadPhotosUseCase.execute()
//    updatePhotosStateUI(with: result)
//  }
//  
//  private func updatePhotosStateUI(with result: Result<[Photo], Error>) {
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
//    lastPageValidationUseCase.checkAndLoadMoreItems(
//      at: index,
//      actualItems: photos.count,
//      action: loadPhotos
//    )
//  }
//  
//  private func getPhotosViewModelItem(
//    at index: Int
//  ) -> PhotosViewModelItem {
//    checkAndLoadMorePhotos(at: index)
//    return makePhotosViewModelItem(at: index)
//  }
//  
//  private func makePhotosViewModelItem(at index: Int) -> PhotosViewModelItem {
//    let photo = photos[index]
//    return PhotosViewModelItem(photo: photo)
//  }
//  
//  private func configurePhotoCell(
//    collectionView: UICollectionView,
//    indexPath: IndexPath,
//    photo: Photo,
//    delegate: any PhotoCellDelegate
//  ) -> UICollectionViewCell {
//    guard
//      let cell = collectionView.dequeueReusableCell(
//        withReuseIdentifier: PhotoCell.reuseID,
//        for: indexPath
//      ) as? PhotoListCell
//    else {
//      return UICollectionViewCell()
//    }
//    
//    cell.delegate = delegate
//    checkAndLoadMorePhotos(at: indexPath.item)
//    let viewModelItem = getPhotosViewModelItem(at: indexPath.item)
//    cell.configure(viewModelItem: viewModelItem)
//    return cell
//  }
//  
//  // MARK:  Sections
//  private enum PhotosSection: Hashable {
//    case main
//  }
//  
//  // MARK: - Albums
//  // MARK:  Private Properties
//  private let loadAlbumsUseCase: any LoadAlbumListUseCaseProtocol
//  private var albumsDataSource: UICollectionViewDiffableDataSource<AlbumsSection, Album>?
//  private var albums: [Album] = []
//  private var albumsSections: [AlbumsSection] = []
//  private var albumsSnapshot: NSDiffableDataSourceSnapshot<AlbumsSection, Album> {
//    var snapshot = NSDiffableDataSourceSnapshot<AlbumsSection, Album>()
//    snapshot.appendSections([.main])
//    snapshot.appendItems(albums, toSection: .main)
//    albumsSections = snapshot.sectionIdentifiers
//    return snapshot
//  }
//  
//  // MARK: Internal Methods
//  func createAlbumsDataSource(for collectionView: UICollectionView) {
//    albumsDataSource = UICollectionViewDiffableDataSource<AlbumsSection, Album>(
//      collectionView: collectionView
//    ) { [weak self] collectionView, indexPath, album in
//      let defaultCell = UICollectionViewCell()
//      guard let strongSelf = self else { return defaultCell }
//      let section = strongSelf.photosSections[indexPath.section]
//      switch section {
//      case .main:
//        return strongSelf.configureAlbumCell(
//          collectionView: collectionView,
//          indexPath: indexPath,
//          album: album
//        )
//      }
//    }
//  }
//  
//  func applyAlbumsSnapshot() {
//    guard let dataSource = albumsDataSource else { return }
//    dataSource.apply(
//      albumsSnapshot,
//      animatingDifferences: true
//    )
//  }
//  
//  // MARK:  Private Methods
//  private func loadAlbums() {
//    state.send(.loading)
//    Task {
//      await loadAlbumsUseCase()
//    }
//  }
//  
//  private func loadAlbumsUseCase() async {
//    let result = await loadAlbumsUseCase.execute()
//    updateAlbumsStateUI(with: result)
//  }
//  
//  private func updateAlbumsStateUI(with result: Result<[Album], Error>) {
//    switch result {
//    case .success(let albums):
//      let existingAlbumIDs = self.albums.map { $0.id }
//      let newAlbums = albums.filter { !existingAlbumIDs.contains($0.id) }
//      lastPageValidationUseCase.updateLastPage(itemsCount: albums.count)
//      self.albums.append(contentsOf: newAlbums)
//      state.send(.success)
//    case .failure(let error):
//      state.send(.fail(error: error.localizedDescription))
//    }
//  }
//  
//  private func checkAndLoadMoreAlbums(at index: Int) {
//    lastPageValidationUseCase.checkAndLoadMoreItems(
//      at: index,
//      actualItems: albums.count,
//      action: loadAlbums
//    )
//  }
//  
//  private func getAlbumsViewModelItem(
//    at index: Int
//  ) -> AlbumsViewModelItem {
//    checkAndLoadMoreAlbums(at: index)
//    return makeAlbumListViewModelItem(at: index)
//  }
//  
//  private func makeAlbumListViewModelItem(at index: Int) -> AlbumsViewModelItem {
//    let album = albums[index]
//    return AlbumsViewModelItem(album: album)
//  }
//  
//  private func configureAlbumCell(
//    collectionView: UICollectionView,
//    indexPath: IndexPath,
//    album: Album
//  ) -> UICollectionViewCell {
//    guard
//      let cell = collectionView.dequeueReusableCell(
//        withReuseIdentifier: AlbumCell.reuseID,
//        for: indexPath
//      ) as? AlbumListCell
//    else {
//      return UICollectionViewCell()
//    }
//    
//    checkAndLoadMoreAlbums(at: indexPath.item)
//    let viewModelItem = getAlbumsViewModelItem(at: indexPath.item)
//    cell.configure(viewModelItem: viewModelItem)
//    return cell
//  }
//  
//  // MARK:  Sections
//  private enum AlbumsSection: Hashable {
//    case main
//  }
//}
