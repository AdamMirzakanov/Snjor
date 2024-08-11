//
//  SearchScreenViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit
import Combine

final class SearchScreenViewModel: SearchScreenViewModelProtocol {

  
  func applyAlbumsSnapshot() {
    guard let dataSource = albumsDataSource else { return }
    dataSource.apply(
      albumsSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: - Internal Properties
  var photosCount: Int { photos.count }
  
  // Albums
  var albumsCount: Int { albums.count }

  // MARK: - Private Properties
  private(set) var state: PassthroughSubject<StateController, Never>
  private let loadPhotosUseCase: any LoadPhotoListUseCaseProtocol
  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  private var dataSource: UICollectionViewDiffableDataSource<PhotoListSection, Photo>?
  private var photos: [Photo] = []
  private var sections: [PhotoListSection] = []
  
  private var albumsSections: [AlbumsSection] = []
  
  // Albums
  private let loadAlbumsUseCase: any LoadAlbumListUseCaseProtocol
  private var albumsDataSource: UICollectionViewDiffableDataSource<AlbumsSection, Album>?
  private var albums: [Album] = []
  

  private var snapshot: NSDiffableDataSourceSnapshot<PhotoListSection, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(photos, toSection: .main)
    sections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // Albums
  private var albumsSnapshot: NSDiffableDataSourceSnapshot<AlbumsSection, Album> {
    var snapshot = NSDiffableDataSourceSnapshot<AlbumsSection, Album>()
    snapshot.appendSections([.main])
    snapshot.appendItems(albums, toSection: .main)
    albumsSections = snapshot.sectionIdentifiers
    return snapshot
  }

  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadPhotosUseCase: any LoadPhotoListUseCaseProtocol,
    loadAlbumsUseCase: any LoadAlbumListUseCaseProtocol,
    lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  ) {
    self.state = state
    self.loadPhotosUseCase = loadPhotosUseCase
    self.loadAlbumsUseCase = loadAlbumsUseCase
    self.lastPageValidationUseCase = lastPageValidationUseCase
  }

  // MARK: - Internal Methods
  func viewDidLoad() {
    photosLoad()
    albumsLoad()
  }
  
  func photosLoad() {
    state.send(.loading)
    Task {
      await loadPhotosUseCase()
    }
  }
  
  func albumsLoad() {
    state.send(.loading)
    Task {
      await loadAlbumsUseCase()
    }
  }
  
  private func loadAlbumsUseCase() async {
    let result = await loadAlbumsUseCase.execute()
    updateStateUI(with: result)
  }
  
  private func updateStateUI(with result: Result<[Album], Error>) {
    switch result {
    case .success(let albums):
      let existingAlbumIDs = self.albums.map { $0.id }
      let newAlbums = albums.filter { !existingAlbumIDs.contains($0.id) }
      lastPageValidationUseCase.updateLastPage(itemsCount: albums.count)
      self.albums.append(contentsOf: newAlbums)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }

  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any PhotoCellDelegate
  ) {
    dataSource = UICollectionViewDiffableDataSource<PhotoListSection, Photo>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      
      let defaultCell = UICollectionViewCell()
      
      guard let strongSelf = self else { return defaultCell }
      
      let section = strongSelf.sections[indexPath.section]
      switch section {
      case .main:
        return strongSelf.configureCell(
          collectionView: collectionView,
          indexPath: indexPath,
          photo: photo,
          delegate: delegate
        )
      }
    }
  }
  
  // Albums
  func createAlbumsDataSource(for collectionView: UICollectionView) {
    albumsDataSource = UICollectionViewDiffableDataSource<AlbumsSection, Album>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, album in
      
      let defaultCell = UICollectionViewCell()
      
      guard let strongSelf = self else { return defaultCell }
      
      let section = strongSelf.sections[indexPath.section]
      switch section {
      case .main:
        return strongSelf.configureAlbumCell(
          collectionView: collectionView,
          indexPath: indexPath,
          album: album
        )
      }
    }
  }
  
  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(
      snapshot,
      animatingDifferences: true
    )
  }

  func getPhoto(at indexPath: Int) -> Photo {
    photos[indexPath]
  }
  
  func getPhotoListViewModelItem(
    at index: Int
  ) -> PhotoListViewModelItem {
    checkAndLoadMorePhotos(at: index)
    return makePhotoListViewModelItem(at: index)
  }

  // MARK: - Private Methods
  private func checkAndLoadMorePhotos(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: photosLoad
    )
  }

  private func loadPhotosUseCase() async {
    let result = await loadPhotosUseCase.execute()
    updateStateUI(with: result)
  }

  private func updateStateUI(with result: Result<[Photo], Error>) {
    switch result {
    case .success(let photos):
      let existingPhotoIDs = self.photos.map { $0.id }
      let newPhotos = photos.filter { !existingPhotoIDs.contains($0.id) }
      lastPageValidationUseCase.updateLastPage(itemsCount: photos.count)
      self.photos.append(contentsOf: newPhotos)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
  
  private func makePhotoListViewModelItem(at index: Int) -> PhotoListViewModelItem {
    let photo = photos[index]
    return PhotoListViewModelItem(photo: photo)
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo,
    delegate: any PhotoCellDelegate
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PhotoListCell.reuseID,
        for: indexPath
      ) as? PhotoListCell
    else {
      return UICollectionViewCell()
    }
    
    cell.delegate = delegate
    checkAndLoadMorePhotos(at: indexPath.item)
    let viewModelItem = getPhotoListViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
  // Albums
  private func configureAlbumCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    album: Album
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: AlbumListCell.reuseID,
        for: indexPath
      ) as? AlbumListCell
    else {
      return UICollectionViewCell()
    }
    
    checkAndLoadMoreAlbums(at: indexPath.item)
    let viewModelItem = getAlbumListViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
  func getAlbumListViewModelItem(
    at index: Int
  ) -> AlbumListViewModelItem {
    checkAndLoadMoreAlbums(at: index)
    return makeAlbumListViewModelItem(at: index)
  }
  
  private func makeAlbumListViewModelItem(at index: Int) -> AlbumListViewModelItem {
    let album = albums[index]
    return AlbumListViewModelItem(album: album)
  }
  
  private func checkAndLoadMoreAlbums(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: albums.count,
      action: albumsLoad
    )
  }
}

private enum PhotoListSection: Hashable {
  case main
}

private enum AlbumsSection: Hashable {
  case main
}
