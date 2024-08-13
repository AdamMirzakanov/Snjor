//
//  PhotosViewModel.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit
import Combine

final class PhotosViewModel: PhotosViewModelProtocol {
  
  // MARK: - Internal Properties
  var photosCount: Int { photos.count }

  // MARK: - Private Properties
  private(set) var state: PassthroughSubject<StateController, Never>
  private let loadUseCase: any LoadPhotoListUseCaseProtocol
  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  private var dataSource: UICollectionViewDiffableDataSource<PhotoListSection, Photo>?
  private var photos: [Photo] = []
  private var sections: [PhotoListSection] = []

  private var snapshot: NSDiffableDataSourceSnapshot<PhotoListSection, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<PhotoListSection, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(photos, toSection: .main)
    sections = snapshot.sectionIdentifiers
    return snapshot
  }

  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadPhotoListUseCaseProtocol,
    lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  ) {
    self.state = state
    self.loadUseCase = loadUseCase
    self.lastPageValidationUseCase = lastPageValidationUseCase
  }

  // MARK: - Internal Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadPhotosUseCase()
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
  ) -> PhotosViewModelItem {
    checkAndLoadMorePhotos(at: index)
    return makePhotoListViewModelItem(at: index)
  }

  // MARK: - Private Methods
  private func checkAndLoadMorePhotos(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: viewDidLoad
    )
  }

  private func loadPhotosUseCase() async {
    let result = await loadUseCase.execute()
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
  
  private func makePhotoListViewModelItem(at index: Int) -> PhotosViewModelItem {
    let photo = photos[index]
    return PhotosViewModelItem(photo: photo)
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo,
    delegate: any PhotoCellDelegate
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PhotoCell.reuseID,
        for: indexPath
      ) as? PhotoCell
    else {
      return UICollectionViewCell()
    }
    
    cell.delegate = delegate
    checkAndLoadMorePhotos(at: indexPath.item)
    let viewModelItem = getPhotoListViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}

private enum PhotoListSection: Hashable {
  case main
}
