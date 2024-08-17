//
//  TopicPhotosViewModel.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit
import Combine

final class TopicPhotosViewModel: TopicPhotosViewModelProtocol {
  
  private typealias DataSource = UICollectionViewDiffableDataSource<TopicPhotosSection, Photo>?
  
  // MARK: - Internal Properties
//  var photosCount: Int { photos.count }
  var state: PassthroughSubject<StateController, Never>
  
  // MARK: - Private Properties
  private let loadUseCase: any LoadTopicPhotosUseCaseProtocol
  private var lastPageValidationUseCase: any lastPageValidationUseCaseProtocol
  private var dataSource: UICollectionViewDiffableDataSource<TopicPhotosSection, Photo>?
  private var photos: [Photo] = []
  
  private var snapshot: NSDiffableDataSourceSnapshot<TopicPhotosSection, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<TopicPhotosSection, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(photos)
    return snapshot
  }
  
  // MARK: - Initializers
  init(
    state: PassthroughSubject<StateController, Never>,
    loadUseCase: any LoadTopicPhotosUseCaseProtocol,
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
    dataSource = UICollectionViewDiffableDataSource<TopicPhotosSection, Photo>(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      guard let strongSelf = self else { return UICollectionViewCell() }
      return strongSelf.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        photo: photo
      )
    }
//    configureSectionHeaders(dataSource: dataSource)
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
  
  func getTopicPhotoListViewModelItem(at index: Int) -> PageScreenTopicPhotosViewModelItem {
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
  
  private func makeTopicPhotoListViewModelItem(at index: Int) -> PageScreenTopicPhotosViewModelItem {
    let photo = photos[index]
    return PageScreenTopicPhotosViewModelItem(photo: photo)
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TopicPhotoCell.reuseID,
        for: indexPath
      ) as? TopicPhotoCell
    else {
      return UICollectionViewCell()
    }
    
    checkAndLoadMorePhotos(at: indexPath.item)
    let viewModelItem = getTopicPhotoListViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
//  private func configureSectionHeaders(dataSource: DataSource) {
//    dataSource?.supplementaryViewProvider = {
//      collectionView, kind, indexPath -> UICollectionReusableView? in
//      guard kind == UICollectionView.elementKindSectionHeader else {
//        return nil
//      }
//      let headerView = collectionView.dequeueReusableSupplementaryView(
//        ofKind: kind,
//        withReuseIdentifier: SectionHeaderView.reuseID,
//        for: indexPath
//      ) as! SectionHeaderView
//      headerView.setImage()
//      return headerView
//    }
//  }
}


// MARK: - Section
private enum TopicPhotosSection: CaseIterable {
  case main
}
