//
//  FirstCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

/// Первая из трех ячеек горизонтальной коллекции
final class FirstCell: UICollectionViewCell {
  // MARK: Internal Properties
  var discoverSections: [DiscoverSection] = []
  var discoverDataSource: DiscoverDataSource?
  var userLikedPhotosViewModel: (any ContentManagingProtocol<Photo>)?
  
  // MARK: Views
  let userLikedPhotosCollectionView: UserLikedPhotosCollectionView = {
    return $0
  }(UserLikedPhotosCollectionView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    createPhotosDataSource(for: userLikedPhotosCollectionView)
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  // MARK: Internal Methods
  func configure(with viewModel: any ContentManagingProtocol<Photo>) {
    self.userLikedPhotosViewModel = viewModel
    applyPhotosSnapshot()
  }
  
  // MARK: Private Methods
  private func setupViews() {
    contentView.addSubview(userLikedPhotosCollectionView)
    userLikedPhotosCollectionView.frame = contentView.bounds
  }
}

extension FirstCell {
  // MARK: Private Properties
  private var discoverSnapshot: DiscoverSnapshot {
    var snapshot = DiscoverSnapshot()
    snapshot.appendSections([.main])
    guard let viewModel = userLikedPhotosViewModel else { return snapshot }
    snapshot.appendItems(viewModel.items, toSection: .main)
    discoverSections = snapshot.sectionIdentifiers
    return snapshot
  }

  // MARK: Internal Methods
  func applyPhotosSnapshot() {
    guard let dataSource = discoverDataSource else { return }
    dataSource.apply(
      discoverSnapshot,
      animatingDifferences: true
    )
  }
  
  // MARK: Create Data Source
  func createPhotosDataSource(
    for collectionView: UICollectionView
  ) {
    discoverDataSource = DiscoverDataSource(
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
    let section = discoverSections[indexPath.section]
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
}
