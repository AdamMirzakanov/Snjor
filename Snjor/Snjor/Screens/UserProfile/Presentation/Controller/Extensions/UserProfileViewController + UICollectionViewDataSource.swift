//
//  UserProfileViewController + UICollectionViewDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerConst

extension UserProfileViewController: UICollectionViewDataSource {
  // MARK: Collection View Data Source
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return Const.itemsCount
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    switch indexPath.item {
    case Const.firstCell:
      return configureFirstCell(for: collectionView, at: indexPath)
    case Const.secondCell:
      return configureSecondCell(for: collectionView, at: indexPath)
    default:
      return configureThirdCell(for: collectionView, at: indexPath)
    }
  }
  
  // MARK: Configure Cells
  private func configureFirstCell(
    for collectionView: UICollectionView,
    at indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: FirstCell.reuseID,
      for: indexPath
    ) as? FirstCell else {
      return UICollectionViewCell()
    }
    cell.delegate = self
    cell.configure(with: userLikedPhotosViewModel)
    return cell
  }
  
  private func configureSecondCell(
    for collectionView: UICollectionView,
    at indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: SecondCell.reuseID,
      for: indexPath
    ) as? SecondCell else {
      return UICollectionViewCell()
    }
    cell.configure(with: userPhotosViewModel)
    return cell
  }
  
  private func configureThirdCell(
    for collectionView: UICollectionView,
    at indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: ThirdCell.reuseID,
      for: indexPath
    ) as? ThirdCell else {
      return UICollectionViewCell()
    }
    cell.configure(with: userAlbumsViewModel)
    return cell
  }
}

extension UserProfileViewController: FirstCellDelegate {
  func firstCellDidSelectItem(at indexPath: IndexPath) {
    let photo = userLikedPhotosViewModel.getItem(at: indexPath.item)
    delegate?.didSelectLikedPhoto(photo)
  }
}
