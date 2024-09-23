//
//  ThirdCell + DataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import UIKit

// MARK: - Typealias
typealias UserAlbumsDataSource = UICollectionViewDiffableDataSource<UserAlbumsSection, Album>
typealias UserAlbumsSnapshot = NSDiffableDataSourceSnapshot<UserAlbumsSection, Album>

// MARK: - Enum
enum UserAlbumsSection: Hashable {
  case main
}

// MARK: - Cell Extension
extension ThirdCell {
  // MARK: Private Properties
  private var albumsSnapshot: UserAlbumsSnapshot {
    var snapshot = UserAlbumsSnapshot()
    snapshot.appendSections([.main])
    guard let viewModel = userAlbumsViewModel else { return snapshot }
    snapshot.appendItems(viewModel.items, toSection: .main)
    userAlbumsSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: Internal Methods
  func applyAlbumsSnapshot() {
    guard let dataSource = userAlbumsDataSource else { return }
    dataSource.apply(
      albumsSnapshot,
      animatingDifferences: true
    )
    checkCollectionViewState()
  }
  
  // MARK: Create Data Source
  func createAlbumsDataSource(
    for collectionView: UICollectionView
  ) {
    userAlbumsDataSource = UserAlbumsDataSource(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, item in
      guard
        let self = self
      else {
        return UICollectionViewCell()
      }
      return self.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        item: item
      )
    }
  }
  
  // MARK: Configure Cells
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    item: Album
  ) -> UICollectionViewCell {
    let section = userAlbumsSections[indexPath.section]
    switch section {
    case .main:
      return configureAlbumCell(
        collectionView: collectionView,
        indexPath: indexPath,
        album: item
      )
    }
  }
  
  private func configureAlbumCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    album: Album
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: UserAlbumCell.reuseID,
        for: indexPath
      ) as? UserAlbumCell,
      let userAlbumsViewModel = userAlbumsViewModel
    else {
      return UICollectionViewCell()
    }
    
    let viewModelItem = userAlbumsViewModel.getViewModelItem(at: indexPath.item)
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
  
  private func checkCollectionViewState() {
    let numberOfItems = userAlbumsCollectionView.numberOfItems(inSection: .zero)
    noAlbumsStackView.isHidden = numberOfItems > .zero
  }
}
