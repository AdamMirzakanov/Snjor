//
//  SearchResultViewController + AlbumsDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 29.08.2024.
//

import UIKit

extension SearchResultViewController {
  
  private typealias DataSource = UICollectionViewDiffableDataSource<AlbumsSection, Album>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<AlbumsSection, Album>
  
  // MARK: Private Properties
  private var collectionsSnapshot: Snapshot {
    var snapshot = Snapshot()
    snapshot.appendSections([.albums])
    snapshot.appendItems(albumsViewModel.items, toSection: .albums)
    collectionsSections = snapshot.sectionIdentifiers
    return snapshot
  }
  
  // MARK: Internal Methods
  func applyCollectionsSnapshot() {
    guard let dataSource = collectionsDataSource else { return }
    dataSource.apply(
      collectionsSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createCollectionsDataSource(for collectionView: UICollectionView) {
    collectionsDataSource = DataSource(
      collectionView: collectionView
    ) { [weak self] collectionView, indexPath, item in
      guard let strongSelf = self else {
        return UICollectionViewCell()
      }
      return strongSelf.configureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        item: item
      )
    }
    
    collectionsDataSource?.supplementaryViewProvider = {
      [weak self] collectionView, kind, indexPath in
      guard let strongSelf = self else {
        return UICollectionReusableView()
      }
      return strongSelf.configureSupplementaryView(
        collectionView: collectionView,
        kind: kind,
        indexPath: indexPath
      )
    }
  }
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    item: Album
  ) -> UICollectionViewCell {
    let section = collectionsSections[indexPath.section]
    switch section {
    case .albums:
      return configureAlbumCell(
        collectionView: collectionView,
        indexPath: indexPath,
        album: item
      )
    }
  }
  
  private func configureSupplementaryView(
    collectionView: UICollectionView,
    kind: String,
    indexPath: IndexPath
  ) -> UICollectionReusableView {
    switch kind {
    case SupplementaryViewKind.header:
      return configureHeaderView(
        collectionView: collectionView,
        indexPath: indexPath
      )
    default:
      return UICollectionReusableView()
    }
  }
  
  private func configureHeaderView(
    collectionView: UICollectionView,
    indexPath: IndexPath
  ) -> UICollectionReusableView {
    let section = collectionsSections[indexPath.section]
    let defoultHeaderView = collectionView.dequeueReusableSupplementaryView(
      ofKind: SupplementaryViewKind.header,
      withReuseIdentifier: SectionHeaderView.reuseID,
      for: indexPath
    )
    guard let headerView = defoultHeaderView as? SectionHeaderView else {
      return defoultHeaderView
    }
    switch section {
    case .albums:
      return headerView
    }
  }
  
  // MARK: Configure Cells
  private func configureAlbumCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    album: Album
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: AlbumCell.reuseID,
        for: indexPath
      ) as? AlbumCell
    else {
      return UICollectionViewCell()
    }
    
    guard let currentSearchTerm = self.currentSearchTerm else {
      return cell
    }
    let viewModelItem = albumsViewModel.getSearchItemsViewModelItem(
      at: indexPath.item,
      with: currentSearchTerm
    )
    cell.configure(viewModelItem: viewModelItem)
    return cell
  }
}
