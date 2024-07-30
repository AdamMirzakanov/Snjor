//
//  PhotoListViewModel.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit
import Combine

final class PhotoListViewModel: PhotoListViewModelProtocol {
  // MARK: - Internal Properties
  var photosCount: Int { photos.count }

  // MARK: - Private Properties
  private(set) var state: PassthroughSubject<StateController, Never>
  private let loadUseCase: any LoadPhotoListUseCaseProtocol
  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?
  private var photos: [Photo] = []
  private var sections: [Section] = []

  private var snapshot: NSDiffableDataSourceSnapshot<Section, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(photos)
//    sections = snapshot.sectionIdentifiers
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
    dataSource = UICollectionViewDiffableDataSource<Section, Photo>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      
      guard
        let strongSelf = self,
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: PhotoListCell.reuseID,
          for: indexPath
        ) as? PhotoListCell
      else {
        return UICollectionViewCell()
      }

//      let section = self.sections[indexPath.section]

//      switch section {
//      case .main:
        cell.delegate = delegate
      strongSelf.checkAndLoadMorePhotos(at: indexPath.item)
      let viewModelItem = strongSelf.getPhotoListViewModelItem(at: indexPath.item)
      cell.configure(viewModelItem: viewModelItem)
        return cell
//      }
    }

    dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
      guard kind == UICollectionView.elementKindSectionHeader else {
        return nil
      }

//      let section = self.sections[indexPath.section]

      let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: SectionHeaderView.reuseID,
        for: indexPath
      ) as! SectionHeaderView

//      switch section {
//      case .main:
        headerView.setImage()
//      }
      return headerView
    }
  }

  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(snapshot, animatingDifferences: true)
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
  
  func makePhotoListViewModelItem(
    at index: Int
  ) -> PhotoListViewModelItem {
    let photo = photos[index]
    return PhotoListViewModelItem(photo: photo)
  }
}

// MARK: - Section
//private enum Section: CaseIterable {
//  case main
//}

//private enum SupplementaryViewKind {
//  static let header = "header"
//}
