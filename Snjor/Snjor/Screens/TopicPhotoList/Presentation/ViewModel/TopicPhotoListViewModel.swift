//
//  TopicPhotoListViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import UIKit
import Combine

final class TopicPhotoListViewModel: TopicPhotoListViewModelProtocol {
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Photo>?
  
  // MARK: - Internal Properties
  var photosCount: Int { photos.count }
  var state: PassthroughSubject<StateController, Never>
  
  // MARK: - Private Properties
  private let loadUseCase: any LoadTopicPhotoListUseCaseProtocol
  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
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
    loadUseCase: any LoadTopicPhotoListUseCaseProtocol,
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
      await loadTopicsPagePhotoListUseCase()
    }
  }
  
  func createDataSource(
    for collectionView: UICollectionView
  ) {
    dataSource = UICollectionViewDiffableDataSource<Section, Photo>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      return self?.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        photo: photo
      ) ?? UICollectionViewCell()
    }
    configureSectionHeaders(dataSource: dataSource)
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
  
  func getTopicPhotoListViewModelItem(at index: Int) -> TopicPhotoListViewModelItem {
    checkAndLoadMorePhotos(at: index)
    return makeTopicPhotoListViewModelItem(at: index)
  }
  
  // MARK: - Private Methods
  private func checkAndLoadMorePhotos(at index: Int) {
    lastPageValidationUseCase.checkAndLoadMoreItems(
      at: index,
      actualItems: photos.count,
      action: viewDidLoad
    )
  }
  
  private func loadTopicsPagePhotoListUseCase() async {
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
  
  private func makeTopicPhotoListViewModelItem(at index: Int) -> TopicPhotoListViewModelItem {
    let photo = photos[index]
    return TopicPhotoListViewModelItem(photo: photo)
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TopicsPagePhotoListCell.reuseID,
        for: indexPath
      ) as? TopicsPagePhotoListCell
    else {
      return UICollectionViewCell()
    }
    
    checkAndLoadMorePhotos(at: indexPath.item)
    let viewModelItem = getTopicPhotoListViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
  private func configureSectionHeaders(dataSource: DataSource) {
    dataSource?.supplementaryViewProvider = {
      collectionView, kind, indexPath -> UICollectionReusableView? in
      guard kind == UICollectionView.elementKindSectionHeader else {
        return nil
      }
      let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: SectionHeaderView.reuseID,
        for: indexPath
      ) as! SectionHeaderView
      headerView.setImage()
      return headerView
    }
  }
}

// MARK: - Section
enum Section: CaseIterable {
  case main
}
