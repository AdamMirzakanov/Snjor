//
//  PhotoListViewModel.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit
import Combine

final class PhotoListViewModel: PhotoListViewModelProtocol {
  // MARK: - Public Properties
  var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?
  var refreshControl = UIRefreshControl()

  // MARK: - Private Properties
  private var pagingGenerator: any Pageable
  private let loadPhotosUseCase: any LoadPhotoListUseCaseProtocol
  private (set) var state: PassthroughSubject<StateController, Never>
  private var photos: [Photo] = []
  private var photosCount: Int { photos.count }

  private var snapshot: NSDiffableDataSourceSnapshot<Section, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(photos)
    return snapshot
  }

  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadPhotosUseCase: any LoadPhotoListUseCaseProtocol,
    pagingGenerator: any Pageable
  ) {
    self.state = state
    self.loadPhotosUseCase = loadPhotosUseCase
    self.pagingGenerator = pagingGenerator
  }

  // MARK: - Public Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadPhotosUseCase()
    }
  }

  func getUrlDetail(itemIndex: Int) -> URL {
    let photo = photos[itemIndex]
    return photo.urls[.regular]!
  }

//  @objc func refreshData() {
//    state.send(.loading)
//    Task {
//      await loadPhotosUseCase()
//    }
//  }

  func createDataSource(for collectionView: UICollectionView) {
    dataSource = UICollectionViewDiffableDataSource
    <Section, Photo>(collectionView: collectionView) { collectionView, indexPath, _ in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath)
      guard let waterfallCell = cell as? PhotoCell else { return cell }
      let photo = self.loadPhoto(at: indexPath)
      waterfallCell.configure(with: photo)
      return cell
    }
  }

  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(snapshot, animatingDifferences: true)
  }

  func fetchPhoto(at indexPath: IndexPath) -> Photo {
    return photos[indexPath.item]
  }

//  func setupRefreshControl(for collectionView: UICollectionView) {
//    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//    collectionView.refreshControl = refreshControl
//  }

  // MARK: - Private Methods
  private func loadPhoto(at indexPath: IndexPath) -> Photo {
    checkAndLoadMorePhotos(at: indexPath)
    return photos[indexPath.item]
  }

  private func checkAndLoadMorePhotos(at indexPath: IndexPath) {
    pagingGenerator.checkAndLoadMoreItems(
      item: indexPath.item,
      actualItems: photos.count,
      action: viewDidLoad
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
      pagingGenerator.updateLastPage(itemsCount: photos.count)
      self.photos.append(contentsOf: newPhotos)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
