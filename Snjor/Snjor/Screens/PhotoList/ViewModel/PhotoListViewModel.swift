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
  var refreshControl = UIRefreshControl()
  var photosCount: Int { photos.count }

  // если буду делать индиктор загрузки, может и не буду
  var lastPage: Bool {
    lastPageValidationUseCase.lastPage
  }

  // MARK: - Private Properties
  private var lastPageValidationUseCase: any Pageable
  private let loadPhotosUseCase: any LoadPhotoListUseCaseProtocol
  private var imageDataUseCase: any ImageDataUseCaseProtocol
  private (set) var state: PassthroughSubject<StateController, Never>
  private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?
  private var photos: [Photo] = []

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
    pagingGenerator: any Pageable,
    imageDataUseCase: any ImageDataUseCaseProtocol
  ) {
    self.state = state
    self.loadPhotosUseCase = loadPhotosUseCase
    self.lastPageValidationUseCase = pagingGenerator
    self.imageDataUseCase = imageDataUseCase
  }

  // MARK: - Public Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadPhotosUseCase()
    }
  }

  //  @objc func refreshData() {
  //    state.send(.loading)
  //    Task {
  //      await loadPhotosUseCase()
  //    }
  //  }

  func createDataSource(for collectionView: UICollectionView) {
    dataSource = UICollectionViewDiffableDataSource
    <Section, Photo>(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PhotoCell.reuseID,
        for: indexPath
      )
      guard let waterfallCell = cell as? PhotoCell else { return cell }
      let viewModelItem = self.getPhotoListViewModelItem(at: indexPath.item)
      waterfallCell.configCell(viewModel: viewModelItem)
      return cell
    }
  }

  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(snapshot, animatingDifferences: true)
  }

  func getPhotoItem(at index: Int) -> Photo {
    return photos[index]
  }

  //  func setupRefreshControl(for collectionView: UICollectionView) {
  //    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
  //    collectionView.refreshControl = refreshControl
  //  }

  func getPhotoListViewModelItem(at indexPath: Int) -> PhotoListViewModelItem {
    checkAndLoadMorePhotos(at: indexPath)
    return makePhotoListViewModelItem(index: indexPath)
  }

  func makePhotoListViewModelItem(index: Int) -> PhotoListViewModelItem {
    let photo = photos[index]
    let photoViewModelItem = PhotoListViewModelItem(
      photo: photo,
      dataImageUseCase: imageDataUseCase
    )
    return photoViewModelItem
  }

  func getPhotoID(at indexPath: Int) -> String {
    let id = photos[indexPath].id
    return id
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
}
