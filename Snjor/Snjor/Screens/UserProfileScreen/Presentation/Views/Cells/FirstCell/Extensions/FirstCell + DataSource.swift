//
//  FirstCell + DataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.09.2024.
//

import UIKit

// MARK: - Typealias
typealias UserLikedPhotosDataSource = UICollectionViewDiffableDataSource<UserLikedPhotosSection, Photo>
typealias UserLikedPhotosSnapshot = NSDiffableDataSourceSnapshot<UserLikedPhotosSection, Photo>

// MARK: - Enum
enum UserLikedPhotosSection: Hashable {
  case main
}

// MARK: - Cell Extension
extension FirstCell {
  // MARK: Private Properties
  private var discoverSnapshot: UserLikedPhotosSnapshot {
    var snapshot = UserLikedPhotosSnapshot()
    snapshot.appendSections([.main])
    guard let viewModel = userLikedPhotosViewModel else { return snapshot }
    snapshot.appendItems(viewModel.items, toSection: .main)
    userLikedPhotosSections = snapshot.sectionIdentifiers
    return snapshot
  }

  // MARK: Internal Methods
  func applyPhotosSnapshot() {
    guard let dataSource = userLikedPhotosDataSource else { return }
    dataSource.apply(
      discoverSnapshot,
      animatingDifferences: true
    )
    checkCollectionViewState()
  }
  
  // MARK: Create Data Source
  func createPhotosDataSource(
    for collectionView: UICollectionView
  ) {
    userLikedPhotosDataSource = UserLikedPhotosDataSource(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, photo in
      let cell = UICollectionViewCell()
      guard
        let self = self
      else {
        return cell
      }
      
      return self.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        photo: photo
      )
    }
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo
  ) -> UICollectionViewCell {
    let section = userLikedPhotosSections[indexPath.section]
    switch section {
    case .main:
      return configurePhotoCell(
        collectionView: collectionView,
        indexPath: indexPath,
        photo: photo
      )
    }
  }
  
  private func configurePhotoCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: UserLikedPhotoCell.reuseID,
        for: indexPath
      ) as? UserLikedPhotoCell
    else {
      return UICollectionViewCell()
    }
    guard let viewModel = userLikedPhotosViewModel else { return cell }
    let viewModelItem = viewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
  private func checkCollectionViewState() {
    let numberOfItems = rootView.userLikedPhotosCollectionView.numberOfItems(
      inSection: .zero
    )
    rootView.noLikedPhotosStackView.isHidden = numberOfItems > .zero
  }
}
