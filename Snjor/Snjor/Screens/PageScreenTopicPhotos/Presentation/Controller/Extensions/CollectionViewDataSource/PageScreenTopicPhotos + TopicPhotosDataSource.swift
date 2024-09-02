//
//  PageScreenTopicPhotos + TopicPhotosDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import UIKit

extension PageScreenTopicPhotosViewController {
  
  private typealias DataSource = UICollectionViewDiffableDataSource<Section, Photo>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Photo>
  
  // MARK: - Private Properties
  private var snapshot: NSDiffableDataSourceSnapshot<Section, Photo> {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.items)
    return snapshot
  }
  
  // MARK: - Internal Methods
  func applySnapshot() {
    guard let dataSource = dataSource else { return }
    dataSource.apply(
      snapshot,
      animatingDifferences: true
    )
  }
  
  func createDataSource(
    for collectionView: UICollectionView
  ) {
    dataSource = UICollectionViewDiffableDataSource<Section, Photo>(
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
  
  private func configureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    photo: Photo
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PageScreenTopicPhotoCell.reuseID,
        for: indexPath
      ) as? PageScreenTopicPhotoCell
    else {
      return UICollectionViewCell()
    }
    
    let viewModelItem = viewModel.getViewModelItem(at: indexPath.item)
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
