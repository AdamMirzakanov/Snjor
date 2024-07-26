//
//  TopicsPagePhotoListViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

protocol TopicsPagePhotoListViewModelProtocol: BaseViewModelProtocol {
  var photosCount: Int { get }

  func getPhoto(at index: Int) -> Photo
  func applySnapshot()
  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any PhotoCellDelegate
  )
}

final class TopicsPagePhotoListViewModel: TopicsPagePhotoListViewModelProtocol {
  // MARK: - Internal Properties
  var photosCount: Int { photos.count }

  // MARK: - Private Properties
  private let loadTopicsPagePhotosUseCase: any LoadTopicsPagePhotoListUseCaseProtocol
  private var lastPageValidationUseCase: any Pageable
  private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?
  private var photos: [Photo] = []
  private var sections: [Section] = []
  private (set) var state: PassthroughSubject<StateController, Never>
  
  private var snapshot: NSDiffableDataSourceSnapshot<Section, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(photos, toSection: .main)
    sections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadTopicsPagePhotosUseCase: any LoadTopicsPagePhotoListUseCaseProtocol,
    pagingGenerator: any Pageable
  ) {
    self.state = state
    self.loadTopicsPagePhotosUseCase = loadTopicsPagePhotosUseCase
    self.lastPageValidationUseCase = pagingGenerator
  }
  
  // MARK: - Internal Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadTopicsPagePhotoListUseCase()
    }
  }
  
  func createDataSource(
    for collectionView: UICollectionView,
    delegate: any PhotoCellDelegate
  ) {
    dataSource = UICollectionViewDiffableDataSource
    <Section, Photo>(collectionView: collectionView) { collectionView, indexPath, photo in

      let section = self.sections[indexPath.section]

      switch section {
      case .main:
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: PhotoCell.reuseID,
          for: indexPath
        )
        guard let photoCell = cell as? PhotoCell else { return cell }
        photoCell.delegate = delegate
        self.checkAndLoadMorePhotos(at: indexPath.item)
        photoCell.configure(with: photo)
        return photoCell
      }
    }

    dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
      guard kind == UICollectionView.elementKindSectionHeader else {
        return nil
      }

      let section = self.sections[indexPath.section]

      let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: SectionHeaderView.reuseID,
        for: indexPath
      ) as! SectionHeaderView

      switch section {
      case .main:
        headerView.setImage()
      }
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
  
  // MARK: - Private Methods
  private func checkAndLoadMorePhotos(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: viewDidLoad
    )
    print(#function)
  }

  private func loadTopicsPagePhotoListUseCase() async {
    let result = await loadTopicsPagePhotosUseCase.execute()
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
}

// MARK: - Section
private enum Section: CaseIterable {
  case main
}

private enum SupplementaryViewKind {
  static let header = "header"
}
