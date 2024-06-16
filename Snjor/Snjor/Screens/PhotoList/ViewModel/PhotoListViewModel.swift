//
//  PhotoListViewModel.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit
import Combine

final class PhotosViewModel: PhotoListViewModelProtocol {
  // MARK: - Public Properties
  var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?

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
      PrepareParameters.page += 1
      await loadPhotosUseCase()
    }
  }

  func fetchPhoto(at indexPath: IndexPath) -> Photo {
    return photos[indexPath.item]
  }

  func loadPhoto(at indexPath: IndexPath) -> Photo {
    checkAndLoadMorePhotos(at: indexPath)
    return photos[indexPath.item]
  }

  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(snapshot, animatingDifferences: true)
  }

  // MARK: - Private Methods
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
      DispatchQueue.main.async {
        self.applySnapshot()
      }
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
