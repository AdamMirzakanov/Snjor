//
//  SecondCell + DataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import UIKit

// MARK: - Typealias
typealias UserPhotosDataSource = UICollectionViewDiffableDataSource<UserPhotosSection, Photo>
typealias UserPhotosSnapshot = NSDiffableDataSourceSnapshot<UserPhotosSection, Photo>

// MARK: - Enum
enum UserPhotosSection: Hashable {
  case main
}

// MARK: - Cell Extension
extension SecondCell {
  // MARK: Private Properties
  private var discoverSnapshot: UserPhotosSnapshot {
    var snapshot = UserPhotosSnapshot()
    snapshot.appendSections([.main])
    guard let viewModel = userPhotosViewModel else { return snapshot }
    snapshot.appendItems(viewModel.items, toSection: .main)
    userPhotosSections = snapshot.sectionIdentifiers
    return snapshot
  }

  // MARK: Internal Methods
  func applyPhotosSnapshot() {
    guard let dataSource = userPhotosDataSource else { return }
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
    userPhotosDataSource = UserPhotosDataSource(
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
    let section = userPhotosSections[indexPath.section]
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
        withReuseIdentifier: UserPhotoCell.reuseID,
        for: indexPath
      ) as? UserPhotoCell
    else {
      return UICollectionViewCell()
    }
    guard let viewModel = userPhotosViewModel else { return cell }
    let viewModelItem = viewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
  private func checkCollectionViewState() {
    let numberOfItems = rootView.userPhotosCollectionView.numberOfItems(inSection: .zero)
    rootView.noPhotosStackView.isHidden = numberOfItems > .zero
  }
}
