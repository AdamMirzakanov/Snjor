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
  var refreshControl = UIRefreshControl()
  var photosCount: Int { photos.count }
  var onPhotosChange: (([Photo]) -> Void)?

  // MARK: - Private Properties
  private var lastPageValidationUseCase: any Pageable
  private let loadPhotosUseCase: any LoadPhotoListUseCaseProtocol
  private (set) var state: PassthroughSubject<StateController, Never>
  private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>?
  private var photos: [Photo] = []
  var downloadService: DownloadService = DownloadService()

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
    self.lastPageValidationUseCase = pagingGenerator
  }

  // MARK: - Internal Methods
  func viewDidLoad() {
    state.send(.loading)
    Task {
      await loadPhotosUseCase()
    }
  }

  func createDataSource(for collectionView: UICollectionView, delegate: any PhotoCellDelegate) {
    dataSource = UICollectionViewDiffableDataSource
    <Section, Photo>(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PhotoCell.reuseID,
        for: indexPath
      )
      guard let photoCell = cell as? PhotoCell else { return cell }
      
      photoCell.delegate = delegate
      self.checkAndLoadMorePhotos(at: indexPath.item)
      photoCell.configure(
        with: item,
        downloaded: item.downloaded,
        download: self.downloadService.activeDownloads[item.downloadURL!]
      )
      
      return photoCell
    }
  }

  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(snapshot, animatingDifferences: true)
  }

  func getPhotoItem(at index: Int) -> Photo {
    return photos[index]
  }

  func loadPhoto(at index: Int) -> Photo {
    checkAndLoadMorePhotos(at: index)
    return photos[index]
  }

  func getPhotoID(at indexPath: Int) -> Photo {
    let id = photos[indexPath]
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
      onPhotosChange?(self.photos)
    case .failure(let error):
      state.send(.fail(error: error.localizedDescription))
    }
  }
}
