//
//  FirstCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class FirstCell: BaseColletionViewCell<FirstCellRootView> {
  // MARK: Internal Properties
  var userLikedPhotosSections: [UserLikedPhotosSection] = []
  var userLikedPhotosDataSource: UserLikedPhotosDataSource?
  var userLikedPhotosViewModel: (any ContentManagingProtocol<Photo>)?
  weak var delegate: (any FirstCellDelegate)?

  // MARK: Initializers
  override func initCell() {
    super.initCell()
    setupLayout()
    createPhotosDataSource(for: rootView.userLikedPhotosCollectionView)
    setupCollectionViewDelegate()
  }
  
  // MARK: Internal Methods
  func configure(with viewModel: any ContentManagingProtocol<Photo>) {
    self.userLikedPhotosViewModel = viewModel
    applyPhotosSnapshot()
  }
  
  // MARK: Private Methods
  private func setupLayout() {
    let cascadeLayout = UserPhotosCascadeLayout(with: self)
    rootView.userLikedPhotosCollectionView.collectionViewLayout = cascadeLayout
    rootView.userLikedPhotosCollectionView.frame = contentView.bounds
  }
  
  private func setupCollectionViewDelegate() {
    rootView.userLikedPhotosCollectionView.likedPhotosDelegate = self
  }
}
