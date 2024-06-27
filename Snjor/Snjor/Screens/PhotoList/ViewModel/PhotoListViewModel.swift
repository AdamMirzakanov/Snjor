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
    <Section, Photo>(collectionView: collectionView) { collectionView, indexPath, _ in
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PhotoCell.reuseID,
        for: indexPath
      )
      guard let waterfallCell = cell as? PhotoCell else { return cell }
      let viewModelItem = self.getPhotoListViewModelItem(at: indexPath)
      waterfallCell.configCell(viewModel: viewModelItem)
      return cell
    }
  }

  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(snapshot, animatingDifferences: true)
  }

  func getPhotoItem(at indexPath: IndexPath) -> Photo {
    return photos[indexPath.item]
  }

  //  func setupRefreshControl(for collectionView: UICollectionView) {
  //    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
  //    collectionView.refreshControl = refreshControl
  //  }

  func getPhotoListViewModelItem(at indexPath: IndexPath) -> PhotoListViewModelItem {
    checkAndLoadMorePhotos(at: indexPath)
    return makePhotoListViewModelItem(itemIndex: indexPath.item)
  }

  func makePhotoListViewModelItem(itemIndex: Int) -> PhotoListViewModelItem {
    let photo = photos[itemIndex]
    let itemPhotoViewModel = PhotoListViewModelItem(
      photo: photo,
      dataImageUseCase: imageDataUseCase
    )
    return itemPhotoViewModel
  }

  func getPhotoID(at indexPath: IndexPath) -> String {
    let id = photos[indexPath.item].id
    return id
  }

  // MARK: - Private Methods
  private func checkAndLoadMorePhotos(at indexPath: IndexPath) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
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
      lastPageValidationUseCase.updateLastPage(itemsCount: photos.count)
      self.photos.append(contentsOf: newPhotos)
      state.send(.success)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
